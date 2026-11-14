// Modelos de Dominio para Sesiones de Caja, Arqueos y Movimientos de Caja Chica
// Inspirado en Desha29/Bayaa y Reglas Venezuela

enum CashSessionStatus { open, closed }

class CashMovementModel {
  final String id;
  final String sessionId;
  final String type; // 'in' (ingreso/aporte), 'out' (gasto menor/retiro)
  final double amount;
  final String currency; // 'USD' o 'VES'
  final double exchangeRate;
  final double amountUsdEquivalent;
  final String reason;
  final DateTime createdAt;

  CashMovementModel({
    required this.id,
    required this.sessionId,
    required this.type,
    required this.amount,
    required this.currency,
    required this.exchangeRate,
    required this.amountUsdEquivalent,
    required this.reason,
    required this.createdAt,
  });

  bool get isIncome => type == 'in';
  bool get isExpense => type == 'out';
}

class CashSessionModel {
  final String id;
  final String storeId;
  final String cashierName;
  final CashSessionStatus status;
  final DateTime openedAt;
  final DateTime? closedAt;
  final double openingCashUsd;
  final double openingCashBs;
  final double expectedCashUsd;
  final double expectedCashBs;
  final double? declaredCashUsd;
  final double? declaredCashBs;
  final double? differenceUsd;
  final double? differenceBs;
  final String? notes;

  CashSessionModel({
    required this.id,
    required this.storeId,
    required this.cashierName,
    required this.status,
    required this.openedAt,
    this.closedAt,
    required this.openingCashUsd,
    required this.openingCashBs,
    required this.expectedCashUsd,
    required this.expectedCashBs,
    this.declaredCashUsd,
    this.declaredCashBs,
    this.differenceUsd,
    this.differenceBs,
    this.notes,
  });

  bool get isOpen => status == CashSessionStatus.open;

  CashSessionModel copyWith({
    CashSessionStatus? status,
    DateTime? closedAt,
    double? expectedCashUsd,
    double? expectedCashBs,
    double? declaredCashUsd,
    double? declaredCashBs,
    double? differenceUsd,
    double? differenceBs,
    String? notes,
  }) {
    return CashSessionModel(
      id: id,
      storeId: storeId,
      cashierName: cashierName,
      status: status ?? this.status,
      openedAt: openedAt,
      closedAt: closedAt ?? this.closedAt,
      openingCashUsd: openingCashUsd,
      openingCashBs: openingCashBs,
      expectedCashUsd: expectedCashUsd ?? this.expectedCashUsd,
      expectedCashBs: expectedCashBs ?? this.expectedCashBs,
      declaredCashUsd: declaredCashUsd ?? this.declaredCashUsd,
      declaredCashBs: declaredCashBs ?? this.declaredCashBs,
      differenceUsd: differenceUsd ?? this.differenceUsd,
      differenceBs: differenceBs ?? this.differenceBs,
      notes: notes ?? this.notes,
    );
  }
}

class CashZReportModel {
  final String sessionId;
  final String reportNumber; // ej. Z-20261114-01
  final DateTime generatedAt;
  final String storeName;
  final String storeRif;
  final String cashierName;
  final DateTime openedAt;
  final DateTime closedAt;
  final double exchangeRate;
  final double openingCashUsd;
  final double openingCashBs;
  final double salesCashUsd;
  final double salesCashBs;
  final double cxcCashUsd;
  final double cxcCashBs;
  final double cashInUsd;
  final double cashInBs;
  final double cashOutUsd;
  final double cashOutBs;
  final double expectedTotalCashUsd;
  final double expectedTotalCashBs;
  final double declaredCashUsd;
  final double declaredCashBs;
  final double differenceUsd;
  final double differenceBs;
  final double pagoMovilTotalBs;
  final double posCardTotalBs;
  final double zelleTotalUsd;
  final double creditSalesTotalUsd;
  final int totalSalesCount;

  CashZReportModel({
    required this.sessionId,
    required this.reportNumber,
    required this.generatedAt,
    required this.storeName,
    required this.storeRif,
    required this.cashierName,
    required this.openedAt,
    required this.closedAt,
    required this.exchangeRate,
    required this.openingCashUsd,
    required this.openingCashBs,
    required this.salesCashUsd,
    required this.salesCashBs,
    required this.cxcCashUsd,
    required this.cxcCashBs,
    required this.cashInUsd,
    required this.cashInBs,
    required this.cashOutUsd,
    required this.cashOutBs,
    required this.expectedTotalCashUsd,
    required this.expectedTotalCashBs,
    required this.declaredCashUsd,
    required this.declaredCashBs,
    required this.differenceUsd,
    required this.differenceBs,
    required this.pagoMovilTotalBs,
    required this.posCardTotalBs,
    required this.zelleTotalUsd,
    required this.creditSalesTotalUsd,
    required this.totalSalesCount,
  });
}

