import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/inventory_models.dart';
import '../../../pos/domain/models/pos_models.dart';
import '../../../pos/presentation/controllers/pos_controller.dart';
import '../../../../core/database/sync_service.dart';

class InventoryState {
  final List<InventoryMovementModel> movements;
  final String searchQuery;
  final String selectedCategory; // 'all' o ID
  final bool showOnlyLowStock;

  InventoryState({
    this.movements = const [],
    this.searchQuery = '',
    this.selectedCategory = 'all',
    this.showOnlyLowStock = false,
  });

  InventoryState copyWith({
    List<InventoryMovementModel>? movements,
    String? searchQuery,
    String? selectedCategory,
    bool? showOnlyLowStock,
  }) {
    return InventoryState(
      movements: movements ?? this.movements,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      showOnlyLowStock: showOnlyLowStock ?? this.showOnlyLowStock,
    );
  }
}

class InventoryNotifier extends StateNotifier<InventoryState> {
  final Ref ref;
  static const _uuid = Uuid();

  InventoryNotifier(this.ref)
      : super(
          InventoryState(
            movements: _initialKardexMovements,
          ),
        );

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setSelectedCategory(String cat) {
    state = state.copyWith(selectedCategory: cat);
  }

  void toggleLowStockFilter() {
    state = state.copyWith(showOnlyLowStock: !state.showOnlyLowStock);
  }

  /// Calcula las métricas generales de valorización de inventario
  InventoryMetricsModel calculateMetrics(List<ProductModel> catalog, double exchangeRate) {
    double totalCost = 0.0;
    double totalRetail = 0.0;
    int lowStock = 0;

    for (final p in catalog) {
      totalCost += (p.costUsd * p.stockQuantity);
      totalRetail += (p.priceUsd * p.stockQuantity);
      if (p.stockQuantity <= p.minStockAlert) {
        lowStock++;
      }
    }

    return InventoryMetricsModel(
      totalSkus: catalog.length,
      totalCostUsd: totalCost,
      totalRetailUsd: totalRetail,
      totalRetailBs: totalRetail * exchangeRate,
      lowStockCount: lowStock,
    );
  }

  /// Filtra productos según búsqueda, categoría y stock bajo
  List<ProductModel> filterProducts(List<ProductModel> catalog, Map<String, double> stockMap) {
    return catalog.where((p) {
      final currentStock = stockMap[p.id] ?? p.stockQuantity;

      // Filtro Stock Bajo
      if (state.showOnlyLowStock && currentStock > p.minStockAlert) {
        return false;
      }

      // Filtro Categoría
      if (state.selectedCategory != 'all' && p.categoryId != state.selectedCategory) {
        return false;
      }

      // Filtro Búsqueda
      if (state.searchQuery.trim().isNotEmpty) {
        final q = state.searchQuery.toLowerCase().trim();
        final matchName = p.name.toLowerCase().contains(q);
        final matchSku = p.sku != null && p.sku!.toLowerCase().contains(q);
        final matchBarcode = p.barcode != null && p.barcode!.contains(q);
        if (!matchName && !matchSku && !matchBarcode) return false;
      }

      return true;
    }).toList();
  }

  /// 1. CREACIÓN DE NUEVO PRODUCTO
  ProductModel createProduct({
    required String name,
    required String categoryId,
    String? sku,
    String? barcode,
    required ProductType type,
    required double priceUsd,
    required double costUsd,
    required double initialStock,
    double minStockAlert = 5.0,
    List<ProductPresentationModel> presentations = const [],
    List<ProductVariantModel> variants = const [],
  }) {
    final productId = _uuid.v4();
    final newProduct = ProductModel(
      id: productId,
      name: name,
      categoryId: categoryId,
      sku: sku ?? 'SKU-${_uuid.v4().substring(0, 6).toUpperCase()}',
      barcode: barcode,
      type: type,
      priceUsd: priceUsd,
      costUsd: costUsd,
      stockQuantity: initialStock,
      minStockAlert: minStockAlert,
      presentations: presentations,
      variants: variants,
    );

    // 1. Agregar a PosNotifier
    ref.read(posProvider.notifier).addProduct(newProduct);

    // 2. Encolar producto en Supabase / Drift
    ref.read(syncProvider.notifier).enqueueOperation(
      targetTable: 'products',
      entityId: productId,
      operation: 'INSERT',
      payload: {
        'id': productId,
        'store_id': 'a0000000-0000-4000-8000-000000000001',
        'category_id': categoryId,
        'name': name,
        'sku': newProduct.sku,
        'barcode': barcode,
        'product_type': type.name,
        'price_usd': priceUsd,
        'cost_usd': costUsd,
        'stock_quantity': initialStock,
        'min_stock_alert': minStockAlert,
      },
    );

    // 3. Si tiene stock inicial > 0, registrar movimiento 'initial' en Kardex
    if (initialStock > 0) {
      final mov = InventoryMovementModel(
        id: _uuid.v4(),
        productId: productId,
        productName: name,
        movementType: 'initial',
        quantity: initialStock,
        previousStock: 0.0,
        newStock: initialStock,
        unitCostUsd: costUsd,
        notes: 'Carga de stock inicial',
        createdAt: DateTime.now(),
      );
      state = state.copyWith(movements: [mov, ...state.movements]);

      ref.read(syncProvider.notifier).enqueueOperation(
        targetTable: 'inventory_movements',
        entityId: mov.id,
        operation: 'INSERT',
        payload: {
          'id': mov.id,
          'product_id': productId,
          'movement_type': 'initial',
          'quantity': initialStock,
          'previous_stock': 0.0,
          'new_stock': initialStock,
          'cost_usd': costUsd,
          'notes': 'Carga de stock inicial',
        },
      );
    }

    return newProduct;
  }

  /// 2. CARGAR COMPRA / ENTRADA DE MERCANCÍA
  InventoryMovementModel recordPurchase({
    required ProductModel product,
    required double quantityUnits,
    required double newUnitCostUsd,
    ProductPresentationModel? presentation,
    String? notes,
  }) {
    final posState = ref.read(posProvider);
    final previousStock = posState.stockMap[product.id] ?? product.stockQuantity;
    final totalUnitsToAdd = presentation != null ? (quantityUnits * presentation.quantityEquivalent) : quantityUnits;
    final newStock = previousStock + totalUnitsToAdd;

    // Actualizar producto en POS
    ref.read(posProvider.notifier).adjustStock(
          product.id,
          totalUnitsToAdd,
          newCostUsd: newUnitCostUsd > 0 ? newUnitCostUsd : null,
        );

    // Registrar Movimiento de Compra
    final mov = InventoryMovementModel(
      id: _uuid.v4(),
      productId: product.id,
      productName: product.name,
      movementType: 'purchase',
      quantity: totalUnitsToAdd,
      previousStock: previousStock,
      newStock: newStock,
      unitCostUsd: newUnitCostUsd > 0 ? newUnitCostUsd : product.costUsd,
      notes: notes ?? (presentation != null ? 'Compra de ${quantityUnits.toInt()} x ${presentation.name}' : 'Compra directa de unidades'),
      createdAt: DateTime.now(),
    );

    state = state.copyWith(movements: [mov, ...state.movements]);

    // Encolar sincronización Drift / Supabase
    ref.read(syncProvider.notifier).enqueueOperation(
      targetTable: 'inventory_movements',
      entityId: mov.id,
      operation: 'INSERT',
      payload: {
        'id': mov.id,
        'product_id': product.id,
        'movement_type': 'purchase',
        'quantity': totalUnitsToAdd,
        'previous_stock': previousStock,
        'new_stock': newStock,
        'cost_usd': mov.unitCostUsd,
        'notes': mov.notes,
      },
    );

    return mov;
  }

  /// 3. AJUSTE DE STOCK (Merma / Conteo / Pérdida)
  InventoryMovementModel recordAdjustment({
    required ProductModel product,
    required double deltaUnits, // Positivo para ajuste a favor, negativo para merma
    required String reasonType, // 'adjustment' o 'waste'
    required String notes,
  }) {
    final posState = ref.read(posProvider);
    final previousStock = posState.stockMap[product.id] ?? product.stockQuantity;
    final newStock = (previousStock + deltaUnits).clamp(0.0, double.infinity);

    ref.read(posProvider.notifier).adjustStock(product.id, deltaUnits);

    final mov = InventoryMovementModel(
      id: _uuid.v4(),
      productId: product.id,
      productName: product.name,
      movementType: reasonType,
      quantity: deltaUnits,
      previousStock: previousStock,
      newStock: newStock,
      unitCostUsd: product.costUsd,
      notes: notes,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(movements: [mov, ...state.movements]);

    ref.read(syncProvider.notifier).enqueueOperation(
      targetTable: 'inventory_movements',
      entityId: mov.id,
      operation: 'INSERT',
      payload: {
        'id': mov.id,
        'product_id': product.id,
        'movement_type': reasonType,
        'quantity': deltaUnits,
        'previous_stock': previousStock,
        'new_stock': newStock,
        'cost_usd': product.costUsd,
        'notes': notes,
      },
    );

    return mov;
  }
}

// ---------------------------------------------------------------------------
// MOVIMIENTOS SEMILLA DE KARDEX (Auditoría previa del turno)
// ---------------------------------------------------------------------------
final List<InventoryMovementModel> _initialKardexMovements = [
  InventoryMovementModel(
    id: 'm0000000-0000-4000-8000-000000000001',
    productId: 'd0000000-0000-4000-8000-000000000003',
    productName: 'Refresco Pepsi Cola 1.5L',
    movementType: 'refund',
    quantity: 1.0,
    previousStock: 48.0,
    newStock: 49.0,
    unitCostUsd: 1.05,
    referenceId: 'FAC-043201',
    notes: 'Devolución parcial de cliente (1 unidad)',
    createdAt: DateTime.now().subtract(const Duration(minutes: 50)),
  ),
  InventoryMovementModel(
    id: 'm0000000-0000-4000-8000-000000000002',
    productId: 'd0000000-0000-4000-8000-000000000001',
    productName: 'Harina PAN Maíz Blanco 1kg',
    movementType: 'sale',
    quantity: -20.0,
    previousStock: 105.0,
    newStock: 85.0,
    unitCostUsd: 0.95,
    referenceId: 'FAC-043201',
    notes: 'Venta Caja x 20 Unidades',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  InventoryMovementModel(
    id: 'm0000000-0000-4000-8000-000000000003',
    productId: 'd0000000-0000-4000-8000-000000000008',
    productName: 'Café Fama de América 500g',
    movementType: 'waste',
    quantity: -2.0,
    previousStock: 5.0,
    newStock: 3.0,
    unitCostUsd: 2.40,
    notes: 'Merma por empaque roto en anaquel',
    createdAt: DateTime.now().subtract(const Duration(hours: 4)),
  ),
  InventoryMovementModel(
    id: 'm0000000-0000-4000-8000-000000000004',
    productId: 'd0000000-0000-4000-8000-000000000002',
    productName: 'Arroz Mary Tradicional 1kg',
    movementType: 'purchase',
    quantity: 30.0,
    previousStock: 30.0,
    newStock: 60.0,
    unitCostUsd: 0.85,
    notes: 'Recepción Factura Distribuidora Polar #4829',
    createdAt: DateTime.now().subtract(const Duration(hours: 8)),
  ),
];

final inventoryProvider = StateNotifierProvider<InventoryNotifier, InventoryState>((ref) {
  return InventoryNotifier(ref);
});
