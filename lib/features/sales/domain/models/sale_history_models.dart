// Modelos de Dominio para Historial de Ventas y Devoluciones Parciales por Ítem
// Inspirado en Desha29/Bayaa

class SaleHistoryItemModel {
  final String id;
  final String productId;
  final String? presentationId;
  final String? variantId;
  final String productName;
  final double quantity; // Cantidad originalmente vendida
  final double returnedQuantity; // Cantidad devuelta acumulada
  final double unitPriceUsd;
  final double subtotalUsd;
  final double quantityEquivalent; // Para cajas/bultos

  SaleHistoryItemModel({
    required this.id,
    required this.productId,
    this.presentationId,
    this.variantId,
    required this.productName,
    required this.quantity,
    this.returnedQuantity = 0.0,
    required this.unitPriceUsd,
    required this.subtotalUsd,
    this.quantityEquivalent = 1.0,
  });

  double get availableForReturn => (quantity - returnedQuantity).clamp(0.0, quantity);
  bool get isFullyReturned => returnedQuantity >= quantity;

  SaleHistoryItemModel copyWith({double? returnedQuantity}) {
    return SaleHistoryItemModel(
      id: id,
      productId: productId,
      presentationId: presentationId,
      variantId: variantId,
      productName: productName,
      quantity: quantity,
      returnedQuantity: returnedQuantity ?? this.returnedQuantity,
      unitPriceUsd: unitPriceUsd,
      subtotalUsd: subtotalUsd,
      quantityEquivalent: quantityEquivalent,
    );
  }
}

class SaleHistoryRecordModel {
  final String id;
  final String invoiceNumber;
  final DateTime date;
  final String customerName;
  final String? customerId;
  final double exchangeRate;
  final double subtotalUsd;
  final double discountUsd;
  final bool igtfApplied;
  final double igtfAmountUsd;
  final double totalUsd;
  final double totalBs;
  final String paymentStatus; // 'paid', 'partial', 'refunded'
  final List<SaleHistoryItemModel> items;
  final List<Map<String, dynamic>> payments;
  final String? notes;

  SaleHistoryRecordModel({
    required this.id,
    required this.invoiceNumber,
    required this.date,
    required this.customerName,
    this.customerId,
    required this.exchangeRate,
    required this.subtotalUsd,
    required this.discountUsd,
    required this.igtfApplied,
    required this.igtfAmountUsd,
    required this.totalUsd,
    required this.totalBs,
    required this.paymentStatus,
    required this.items,
    required this.payments,
    this.notes,
  });

  bool get hasReturns => items.any((i) => i.returnedQuantity > 0);
  double get totalReturnedUsd => items.fold(0.0, (acc, i) => acc + (i.returnedQuantity * i.unitPriceUsd));

  SaleHistoryRecordModel copyWith({
    String? paymentStatus,
    List<SaleHistoryItemModel>? items,
  }) {
    return SaleHistoryRecordModel(
      id: id,
      invoiceNumber: invoiceNumber,
      date: date,
      customerName: customerName,
      customerId: customerId,
      exchangeRate: exchangeRate,
      subtotalUsd: subtotalUsd,
      discountUsd: discountUsd,
      igtfApplied: igtfApplied,
      igtfAmountUsd: igtfAmountUsd,
      totalUsd: totalUsd,
      totalBs: totalBs,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      items: items ?? this.items,
      payments: payments,
      notes: notes,
    );
  }
}

