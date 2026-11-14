// Modelos de Dominio para Azulito POS Venezuela

enum ProductType { unit, weightFraction, variant, combo }

class ProductPresentationModel {
  final String id;
  final String productId;
  final String name;
  final String? barcode;
  final double quantityEquivalent; // Cuántas unidades descuenta del stock base
  final double priceUsd;

  ProductPresentationModel({
    required this.id,
    required this.productId,
    required this.name,
    this.barcode,
    required this.quantityEquivalent,
    required this.priceUsd,
  });
}

class ProductVariantModel {
  final String id;
  final String productId;
  final String variantName;
  final String? sku;
  final String? barcode;
  final double additionalPriceUsd;
  final double stockQuantity;

  ProductVariantModel({
    required this.id,
    required this.productId,
    required this.variantName,
    this.sku,
    this.barcode,
    required this.additionalPriceUsd,
    required this.stockQuantity,
  });
}

class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final String? barcode;
  final String? sku;
  final ProductType type;
  final double priceUsd;
  final double costUsd;
  final double stockQuantity;
  final double minStockAlert;
  final List<ProductPresentationModel> presentations;
  final List<ProductVariantModel> variants;

  ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    this.barcode,
    this.sku,
    required this.type,
    required this.priceUsd,
    this.costUsd = 0.0,
    required this.stockQuantity,
    this.minStockAlert = 5.0,
    this.presentations = const [],
    this.variants = const [],
  });

  bool get hasPresentations => presentations.isNotEmpty;
  bool get hasVariants => variants.isNotEmpty;
  bool get isWeightFraction => type == ProductType.weightFraction;
}

class CartItemModel {
  final String id; // Clave única en carrito (ej: prodId + presentationId)
  final String productId;
  final String? presentationId;
  final String? variantId;
  final String name;
  final String unitLabel;
  final double unitPriceUsd;
  final double quantity; // Cantidad solicitada (ej. 2 Cajas o 0.500 Kg)
  final double quantityEquivalent; // Factor de descuento del stock base (ej. 20 para Caja x20, 1.0 para unidad/kg)
  final bool isWeight;

  CartItemModel({
    required this.id,
    required this.productId,
    this.presentationId,
    this.variantId,
    required this.name,
    this.unitLabel = 'Unidad',
    required this.unitPriceUsd,
    required this.quantity,
    this.quantityEquivalent = 1.0,
    this.isWeight = false,
  });

  // Total de unidades del stock base que descuenta este ítem
  double get totalStockUnitsDeducted => quantity * quantityEquivalent;
  double get subtotalUsd => unitPriceUsd * quantity;

  CartItemModel copyWith({double? quantity}) {
    return CartItemModel(
      id: id,
      productId: productId,
      presentationId: presentationId,
      variantId: variantId,
      name: name,
      unitLabel: unitLabel,
      unitPriceUsd: unitPriceUsd,
      quantity: quantity ?? this.quantity,
      quantityEquivalent: quantityEquivalent,
      isWeight: isWeight,
    );
  }
}

class CustomerModel {
  final String id;
  final String fullName;
  final String idDocument; // Cédula o RIF (V-12345678)
  final String? phone;
  final String? email;
  final double creditLimitUsd;
  final double currentDebtUsd;

  CustomerModel({
    required this.id,
    required this.fullName,
    required this.idDocument,
    this.phone,
    this.email,
    this.creditLimitUsd = 0.0,
    this.currentDebtUsd = 0.0,
  });

  double get availableCreditUsd => creditLimitUsd - currentDebtUsd;
}

class PaymentItemModel {
  final String id;
  final String method; // 'cash_usd', 'cash_bs', 'pago_movil', 'pos_card', 'biopago', 'zelle', 'transfer_bs', 'cashea_initial', 'cashea_financed', 'store_credit'
  final String methodLabel;
  final double amountOriginal; // Monto en la moneda seleccionada
  final String currency; // 'USD' o 'VES'
  final double exchangeRate;
  final double amountUsdEquivalent;
  final String? referenceNumber;
  final String? bankName;
  final String? notes;

  PaymentItemModel({
    required this.id,
    required this.method,
    required this.methodLabel,
    required this.amountOriginal,
    required this.currency,
    required this.exchangeRate,
    required this.amountUsdEquivalent,
    this.referenceNumber,
    this.bankName,
    this.notes,
  });
}

class HeldBillModel {
  final String id;
  final String note;
  final List<CartItemModel> items;
  final CustomerModel? customer;
  final double discountPercent;
  final double discountFixedUsd;
  final bool igtfEnabled;
  final DateTime heldAt;

  HeldBillModel({
    required this.id,
    required this.note,
    required this.items,
    this.customer,
    this.discountPercent = 0.0,
    this.discountFixedUsd = 0.0,
    this.igtfEnabled = true,
    required this.heldAt,
  });

  double get subtotalUsd => items.fold(0.0, (acc, item) => acc + item.subtotalUsd);
}

class SaleReceiptModel {
  final String saleId;
  final String invoiceNumber;
  final DateTime date;
  final String storeName;
  final String storeRif;
  final String cashierName;
  final CustomerModel? customer;
  final List<CartItemModel> items;
  final double exchangeRate;
  final double subtotalUsd;
  final double discountUsd;
  final bool igtfApplied;
  final double igtfAmountUsd;
  final double totalUsd;
  final double totalBs;
  final List<PaymentItemModel> payments;

  SaleReceiptModel({
    required this.saleId,
    required this.invoiceNumber,
    required this.date,
    required this.storeName,
    required this.storeRif,
    required this.cashierName,
    this.customer,
    required this.items,
    required this.exchangeRate,
    required this.subtotalUsd,
    required this.discountUsd,
    required this.igtfApplied,
    required this.igtfAmountUsd,
    required this.totalUsd,
    required this.totalBs,
    required this.payments,
  });
}

