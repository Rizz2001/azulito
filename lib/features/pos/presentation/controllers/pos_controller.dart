import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/pos_models.dart';

// ---------------------------------------------------------------------------
// ESTADO GLOBAL DEL POS
// ---------------------------------------------------------------------------
class PosState {
  final List<ProductModel> catalog;
  final Map<String, double> stockMap; // Caché reactiva en memoria (_stockMap)
  final List<CartItemModel> cart;
  final CustomerModel? customer;
  final double exchangeRate;
  final double discountPercent;
  final double discountFixedUsd;
  final bool igtfEnabled;
  final List<HeldBillModel> heldBills;
  final SaleReceiptModel? lastReceipt;

  PosState({
    required this.catalog,
    required this.stockMap,
    this.cart = const [],
    this.customer,
    this.exchangeRate = 45.50,
    this.discountPercent = 0.0,
    this.discountFixedUsd = 0.0,
    this.igtfEnabled = true,
    this.heldBills = const [],
    this.lastReceipt,
  });

  // Cálculos reactivos de la orden
  double get rawSubtotalUsd => cart.fold(0.0, (acc, item) => acc + item.subtotalUsd);

  double get calculatedDiscountUsd {
    if (discountPercent > 0) {
      return (rawSubtotalUsd * (discountPercent / 100)).clamp(0.0, rawSubtotalUsd);
    }
    return discountFixedUsd.clamp(0.0, rawSubtotalUsd);
  }

  double get discountedSubtotalUsd => (rawSubtotalUsd - calculatedDiscountUsd).clamp(0.0, double.infinity);

  // Estimado de IGTF (3%) en checkout previo
  double get estimatedIgtfUsd => igtfEnabled ? (discountedSubtotalUsd * 0.03) : 0.0;
  double get totalWithEstimatedIgtfUsd => discountedSubtotalUsd + estimatedIgtfUsd;
  double get totalBs => totalWithEstimatedIgtfUsd * exchangeRate;

  PosState copyWith({
    List<ProductModel>? catalog,
    Map<String, double>? stockMap,
    List<CartItemModel>? cart,
    CustomerModel? customer,
    bool clearCustomer = false,
    double? exchangeRate,
    double? discountPercent,
    double? discountFixedUsd,
    bool? igtfEnabled,
    List<HeldBillModel>? heldBills,
    SaleReceiptModel? lastReceipt,
    bool clearReceipt = false,
  }) {
    return PosState(
      catalog: catalog ?? this.catalog,
      stockMap: stockMap ?? this.stockMap,
      cart: cart ?? this.cart,
      customer: clearCustomer ? null : (customer ?? this.customer),
      exchangeRate: exchangeRate ?? this.exchangeRate,
      discountPercent: discountPercent ?? this.discountPercent,
      discountFixedUsd: discountFixedUsd ?? this.discountFixedUsd,
      igtfEnabled: igtfEnabled ?? this.igtfEnabled,
      heldBills: heldBills ?? this.heldBills,
      lastReceipt: clearReceipt ? null : (lastReceipt ?? this.lastReceipt),
    );
  }
}

// ---------------------------------------------------------------------------
// POS NOTIFIER CON CONTROL DE STOCK ATÓMICO Y NEGOCIO VENEZUELA
// ---------------------------------------------------------------------------
class PosNotifier extends StateNotifier<PosState> {
  static const _uuid = Uuid();

  PosNotifier()
      : super(
          PosState(
            catalog: _initialDemoProducts,
            stockMap: _createInitialStockMap(_initialDemoProducts),
          ),
        );

  static Map<String, double> _createInitialStockMap(List<ProductModel> prods) {
    final map = <String, double>{};
    for (final p in prods) {
      map[p.id] = p.stockQuantity;
      for (final v in p.variants) {
        map['var_${v.id}'] = v.stockQuantity;
      }
    }
    return map;
  }

  // -------------------------------------------------------------------------
  // 1. GESTIÓN REACTIVA DE STOCK Y PREVENCIÓN DE SOBREVENTA (Inspirado en pos-app)
  // -------------------------------------------------------------------------

  /// Valida si es posible agregar [additionalQuantity] respetando presentaciones o variantes
  String? validateStockAddition({
    required ProductModel product,
    required double additionalQuantity,
    double quantityEquivalent = 1.0,
    String? variantId,
  }) {
    final unitsToAdd = additionalQuantity * quantityEquivalent;
    final stockKey = variantId != null ? 'var_$variantId' : product.id;
    final totalAvailable = state.stockMap[stockKey] ?? 0.0;

    // Calcular cuántas unidades ya están en el carrito de este mismo producto base/variante
    double alreadyInCartUnits = 0.0;
    for (final item in state.cart) {
      if (variantId != null && item.variantId == variantId) {
        alreadyInCartUnits += item.totalStockUnitsDeducted;
      } else if (variantId == null && item.productId == product.id) {
        alreadyInCartUnits += item.totalStockUnitsDeducted;
      }
    }

    final projectedUnits = alreadyInCartUnits + unitsToAdd;
    if (projectedUnits > totalAvailable) {
      final remainingUnits = (totalAvailable - alreadyInCartUnits).clamp(0.0, totalAvailable);
      return 'Stock insuficiente para ${product.name}. Disponible: $remainingUnits ${product.isWeightFraction ? "kg" : "unid."}';
    }
    return null; // Válido
  }

  /// Agrega un ítem al carrito con validación atómica
  bool addToCart({
    required ProductModel product,
    ProductPresentationModel? presentation,
    ProductVariantModel? variant,
    double quantity = 1.0,
    bool isWeight = false,
  }) {
    final quantityEq = presentation?.quantityEquivalent ?? 1.0;
    final variantId = variant?.id;

    final error = validateStockAddition(
      product: product,
      additionalQuantity: quantity,
      quantityEquivalent: quantityEq,
      variantId: variantId,
    );

    if (error != null) {
      return false; // Bloqueado por sobreventa
    }

    final itemId = presentation != null
        ? '${product.id}_pres_${presentation.id}'
        : variant != null
            ? '${product.id}_var_${variant.id}'
            : product.id;

    final unitPrice = presentation != null
        ? presentation.priceUsd
        : variant != null
            ? (product.priceUsd + variant.additionalPriceUsd)
            : product.priceUsd;

    final unitLabel = presentation != null
        ? presentation.name
        : variant != null
            ? variant.variantName
            : isWeight
                ? 'Kg'
                : 'Unidad';

    final cartList = List<CartItemModel>.from(state.cart);
    final existingIndex = cartList.indexWhere((i) => i.id == itemId);

    if (existingIndex >= 0) {
      final existing = cartList[existingIndex];
      cartList[existingIndex] = existing.copyWith(
        quantity: existing.quantity + quantity,
      );
    } else {
      cartList.add(
        CartItemModel(
          id: itemId,
          productId: product.id,
          presentationId: presentation?.id,
          variantId: variant?.id,
          name: presentation != null
              ? '${product.name} (${presentation.name})'
              : variant != null
                  ? '${product.name} - ${variant.variantName}'
                  : product.name,
          unitLabel: unitLabel,
          unitPriceUsd: unitPrice,
          quantity: quantity,
          quantityEquivalent: quantityEq,
          isWeight: isWeight,
        ),
      );
    }

    state = state.copyWith(cart: cartList);
    return true;
  }

  /// Modifica la cantidad de un ítem en el carrito con validación
  bool updateQuantity(String cartItemId, double delta) {
    final cartList = List<CartItemModel>.from(state.cart);
    final index = cartList.indexWhere((i) => i.id == cartItemId);
    if (index < 0) return false;

    final item = cartList[index];
    final newQty = item.quantity + delta;

    if (newQty <= 0) {
      cartList.removeAt(index);
      state = state.copyWith(cart: cartList);
      return true;
    }

    if (delta > 0) {
      final product = state.catalog.firstWhere((p) => p.id == item.productId);
      final error = validateStockAddition(
        product: product,
        additionalQuantity: delta,
        quantityEquivalent: item.quantityEquivalent,
        variantId: item.variantId,
      );
      if (error != null) return false;
    }

    cartList[index] = item.copyWith(quantity: newQty);
    state = state.copyWith(cart: cartList);
    return true;
  }

  void removeFromCart(String cartItemId) {
    state = state.copyWith(
      cart: state.cart.where((i) => i.id != cartItemId).toList(),
    );
  }

  void clearCart() {
    state = state.copyWith(
      cart: [],
      clearCustomer: true,
      discountPercent: 0.0,
      discountFixedUsd: 0.0,
    );
  }

  // -------------------------------------------------------------------------
  // 2. CONFIGURACIÓN: TASA DEL DÍA, CLIENTE Y DESCUENTOS
  // -------------------------------------------------------------------------

  void updateExchangeRate(double newRate) {
    state = state.copyWith(exchangeRate: newRate);
  }

  void setCustomer(CustomerModel? customer) {
    state = state.copyWith(
      customer: customer,
      clearCustomer: customer == null,
    );
  }

  void setDiscount({double? percent, double? fixedUsd}) {
    state = state.copyWith(
      discountPercent: percent ?? 0.0,
      discountFixedUsd: fixedUsd ?? 0.0,
    );
  }

  void setIgtfEnabled(bool enabled) {
    state = state.copyWith(igtfEnabled: enabled);
  }

  // -------------------------------------------------------------------------
  // 3. CUENTAS EN ESPERA / HOLD BILLS
  // -------------------------------------------------------------------------

  void holdCurrentBill(String note) {
    if (state.cart.isEmpty) return;

    final held = HeldBillModel(
      id: _uuid.v4(),
      note: note.trim().isEmpty ? 'Cuenta #${state.heldBills.length + 1}' : note.trim(),
      items: List.from(state.cart),
      customer: state.customer,
      discountPercent: state.discountPercent,
      discountFixedUsd: state.discountFixedUsd,
      igtfEnabled: state.igtfEnabled,
      heldAt: DateTime.now(),
    );

    state = state.copyWith(
      heldBills: [...state.heldBills, held],
      cart: [],
      clearCustomer: true,
      discountPercent: 0.0,
      discountFixedUsd: 0.0,
    );
  }

  void resumeHeldBill(String heldBillId) {
    final billIndex = state.heldBills.indexWhere((b) => b.id == heldBillId);
    if (billIndex < 0) return;

    final bill = state.heldBills[billIndex];
    final remainingBills = List<HeldBillModel>.from(state.heldBills)..removeAt(billIndex);

    state = state.copyWith(
      cart: bill.items,
      customer: bill.customer,
      clearCustomer: bill.customer == null,
      discountPercent: bill.discountPercent,
      discountFixedUsd: bill.discountFixedUsd,
      igtfEnabled: bill.igtfEnabled,
      heldBills: remainingBills,
    );
  }

  void deleteHeldBill(String heldBillId) {
    state = state.copyWith(
      heldBills: state.heldBills.where((b) => b.id != heldBillId).toList(),
    );
  }

  // -------------------------------------------------------------------------
  // 4. CONFIRMACIÓN ATÓMICA DE VENTA Y REGISTRO EN BASE DE DATOS
  // -------------------------------------------------------------------------

  SaleReceiptModel completeSale({
    required List<PaymentItemModel> payments,
    required double totalUsdFinal,
    required double totalBsFinal,
    required double igtfAmountUsdFinal,
    required bool igtfAppliedFinal,
  }) {
    final saleId = _uuid.v4();
    final invoiceNumber = 'FAC-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    // 1. Descontar stock en el caché en memoria atómico
    final updatedStockMap = Map<String, double>.from(state.stockMap);
    for (final item in state.cart) {
      final key = item.variantId != null ? 'var_${item.variantId}' : item.productId;
      final current = updatedStockMap[key] ?? 0.0;
      updatedStockMap[key] = (current - item.totalStockUnitsDeducted).clamp(0.0, double.infinity);
    }

    // 2. Generar modelo de recibo para vista previa y archivo
    final receipt = SaleReceiptModel(
      saleId: saleId,
      invoiceNumber: invoiceNumber,
      date: DateTime.now(),
      storeName: 'Azulito Market & POS',
      storeRif: 'J-50123456-7',
      cashierName: 'Cajero Principal',
      customer: state.customer,
      items: List.from(state.cart),
      exchangeRate: state.exchangeRate,
      subtotalUsd: state.rawSubtotalUsd,
      discountUsd: state.calculatedDiscountUsd,
      igtfApplied: igtfAppliedFinal,
      igtfAmountUsd: igtfAmountUsdFinal,
      totalUsd: totalUsdFinal,
      totalBs: totalBsFinal,
      payments: payments,
    );

    // 3. Limpiar carrito y actualizar estado
    state = state.copyWith(
      stockMap: updatedStockMap,
      cart: [],
      clearCustomer: true,
      discountPercent: 0.0,
      discountFixedUsd: 0.0,
      lastReceipt: receipt,
    );

    return receipt;
  }

  /// Restaura unidades al stock base en memoria (para devoluciones de ventas)
  void restoreStock(String productId, double units) {
    final updatedStockMap = Map<String, double>.from(state.stockMap);
    final current = updatedStockMap[productId] ?? 0.0;
    updatedStockMap[productId] = current + units;
    state = state.copyWith(stockMap: updatedStockMap);
  }

  /// Agrega un nuevo producto creado al catálogo y a la memoria de stock
  void addProduct(ProductModel product) {
    final updatedCatalog = [...state.catalog, product];
    final updatedStockMap = Map<String, double>.from(state.stockMap);
    updatedStockMap[product.id] = product.stockQuantity;
    for (final v in product.variants) {
      updatedStockMap['var_${v.id}'] = v.stockQuantity;
    }
    state = state.copyWith(
      catalog: updatedCatalog,
      stockMap: updatedStockMap,
    );
  }

  /// Actualiza un producto existente en el catálogo
  void updateProduct(ProductModel product) {
    final updatedCatalog = state.catalog.map((p) => p.id == product.id ? product : p).toList();
    final updatedStockMap = Map<String, double>.from(state.stockMap);
    updatedStockMap[product.id] = product.stockQuantity;
    for (final v in product.variants) {
      updatedStockMap['var_${v.id}'] = v.stockQuantity;
    }
    state = state.copyWith(
      catalog: updatedCatalog,
      stockMap: updatedStockMap,
    );
  }

  /// Ajusta el stock de un producto (por compra, ajuste o merma)
  void adjustStock(String productId, double deltaUnits, {double? newCostUsd}) {
    final updatedStockMap = Map<String, double>.from(state.stockMap);
    final currentStock = updatedStockMap[productId] ?? 0.0;
    final newStock = (currentStock + deltaUnits).clamp(0.0, double.infinity);
    updatedStockMap[productId] = newStock;

    final updatedCatalog = state.catalog.map((p) {
      if (p.id == productId) {
        return ProductModel(
          id: p.id,
          name: p.name,
          categoryId: p.categoryId,
          barcode: p.barcode,
          sku: p.sku,
          type: p.type,
          priceUsd: p.priceUsd,
          costUsd: newCostUsd ?? p.costUsd,
          stockQuantity: newStock,
          minStockAlert: p.minStockAlert,
          presentations: p.presentations,
          variants: p.variants,
        );
      }
      return p;
    }).toList();

    state = state.copyWith(
      catalog: updatedCatalog,
      stockMap: updatedStockMap,
    );
  }
}

// ---------------------------------------------------------------------------
// DATOS SEMILLA EN MEMORIA (Espejo de Supabase)
// ---------------------------------------------------------------------------
final List<ProductModel> _initialDemoProducts = [
  ProductModel(
    id: 'd0000000-0000-4000-8000-000000000001',
    name: 'Harina PAN Maíz Blanco 1kg',
    categoryId: 'viveres',
    barcode: '759100100101',
    sku: 'VIV-001',
    type: ProductType.unit,
    priceUsd: 1.25,
    costUsd: 0.95,
    stockQuantity: 85.0,
    minStockAlert: 10.0,
    presentations: [
      ProductPresentationModel(
        id: 'pres_harina_caja20',
        productId: 'd0000000-0000-4000-8000-000000000001',
        name: 'Caja x 20 Unidades',
        barcode: '759100100120',
        quantityEquivalent: 20.0,
        priceUsd: 23.50, // Ahorro vs 20 x 1.25 = $25
      ),
    ],
  ),
  ProductModel(
    id: 'd0000000-0000-4000-8000-000000000002',
    name: 'Arroz Mary Tradicional 1kg',
    categoryId: 'viveres',
    barcode: '759100100102',
    sku: 'VIV-002',
    type: ProductType.unit,
    priceUsd: 1.15,
    costUsd: 0.85,
    stockQuantity: 60.0,
    minStockAlert: 10.0,
  ),
  ProductModel(
    id: 'd0000000-0000-4000-8000-000000000003',
    name: 'Refresco Pepsi Cola 1.5L',
    categoryId: 'bebidas',
    barcode: '759100100201',
    sku: 'BEB-001',
    type: ProductType.unit,
    priceUsd: 1.50,
    costUsd: 1.05,
    stockQuantity: 48.0,
    minStockAlert: 6.0,
    presentations: [
      ProductPresentationModel(
        id: 'pres_pepsi_caja12',
        productId: 'd0000000-0000-4000-8000-000000000003',
        name: 'Caja x 12 Botellas',
        barcode: '759100100212',
        quantityEquivalent: 12.0,
        priceUsd: 16.50,
      ),
    ],
  ),
  ProductModel(
    id: 'd0000000-0000-4000-8000-000000000004',
    name: 'Queso Blanco Llanero (Kg)',
    categoryId: 'charcuteria',
    barcode: '759100100301',
    sku: 'CHA-001',
    type: ProductType.weightFraction,
    priceUsd: 5.80,
    costUsd: 4.20,
    stockQuantity: 24.500,
    minStockAlert: 5.0,
  ),
  ProductModel(
    id: 'd0000000-0000-4000-8000-000000000005',
    name: 'Jamón Pierna Plumrose (Kg)',
    categoryId: 'charcuteria',
    barcode: '759100100302',
    sku: 'CHA-002',
    type: ProductType.weightFraction,
    priceUsd: 8.50,
    costUsd: 6.50,
    stockQuantity: 16.200,
    minStockAlert: 3.0,
  ),
  ProductModel(
    id: 'd0000000-0000-4000-8000-000000000006',
    name: 'Camiseta Deportiva DryFit Azulito',
    categoryId: 'snacks',
    barcode: '759100100401',
    sku: 'VAR-001',
    type: ProductType.variant,
    priceUsd: 12.00,
    costUsd: 8.00,
    stockQuantity: 35.0,
    minStockAlert: 5.0,
    variants: [
      ProductVariantModel(
        id: 'var_m_azul',
        productId: 'd0000000-0000-4000-8000-000000000006',
        variantName: 'Talla M / Azul Rey',
        sku: 'VAR-001-M',
        additionalPriceUsd: 0.0,
        stockQuantity: 15.0,
      ),
      ProductVariantModel(
        id: 'var_l_azul',
        productId: 'd0000000-0000-4000-8000-000000000006',
        variantName: 'Talla L / Azul Rey',
        sku: 'VAR-001-L',
        additionalPriceUsd: 0.0,
        stockQuantity: 12.0,
      ),
      ProductVariantModel(
        id: 'var_xl_azul',
        productId: 'd0000000-0000-4000-8000-000000000006',
        variantName: 'Talla XL / Azul Rey',
        sku: 'VAR-001-XL',
        additionalPriceUsd: 1.50,
        stockQuantity: 8.0,
      ),
    ],
  ),
  ProductModel(
    id: 'd0000000-0000-4000-8000-000000000007',
    name: 'Detergente Las Llaves 1kg',
    categoryId: 'limpieza',
    barcode: '759100100501',
    sku: 'LIM-001',
    type: ProductType.unit,
    priceUsd: 2.40,
    costUsd: 1.80,
    stockQuantity: 32.0,
    minStockAlert: 8.0,
  ),
  ProductModel(
    id: 'd0000000-0000-4000-8000-000000000008',
    name: 'Café Fama de América 500g',
    categoryId: 'viveres',
    barcode: '759100100103',
    sku: 'VIV-003',
    type: ProductType.unit,
    priceUsd: 3.20,
    costUsd: 2.30,
    stockQuantity: 3.0, // Alerta stock bajo
    minStockAlert: 5.0,
  ),
];

// Instancia Provider de Riverpod
final posProvider = StateNotifierProvider<PosNotifier, PosState>((ref) {
  return PosNotifier();
});
