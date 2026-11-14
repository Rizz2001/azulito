// Modelos de Dominio para Gestión de Clientes y Cuentas por Cobrar (CxC / Cashea)

class CustomerRecordModel {
  final String id;
  final String fullName;
  final String idDocument; // V-18765432 o J-12345678-9
  final String? phone;
  final String? email;
  final String? address;
  final double creditLimitUsd;
  final double currentDebtUsd;
  final bool isCasheaUser;
  final DateTime createdAt;

  CustomerRecordModel({
    required this.id,
    required this.fullName,
    required this.idDocument,
    this.phone,
    this.email,
    this.address,
    this.creditLimitUsd = 0.0,
    this.currentDebtUsd = 0.0,
    this.isCasheaUser = false,
    required this.createdAt,
  });

  double get availableCreditUsd => (creditLimitUsd - currentDebtUsd).clamp(0.0, double.infinity);
  double get creditUsedPercentage => creditLimitUsd > 0 ? (currentDebtUsd / creditLimitUsd).clamp(0.0, 1.0) : 0.0;
  bool get hasDebt => currentDebtUsd > 0.01;

  CustomerRecordModel copyWith({
    String? fullName,
    String? idDocument,
    String? phone,
    String? email,
    String? address,
    double? creditLimitUsd,
    double? currentDebtUsd,
    bool? isCasheaUser,
  }) {
    return CustomerRecordModel(
      id: id,
      fullName: fullName ?? this.fullName,
      idDocument: idDocument ?? this.idDocument,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      creditLimitUsd: creditLimitUsd ?? this.creditLimitUsd,
      currentDebtUsd: currentDebtUsd ?? this.currentDebtUsd,
      isCasheaUser: isCasheaUser ?? this.isCasheaUser,
      createdAt: createdAt,
    );
  }
}

class CustomerDebtPaymentModel {
  final String id;
  final String customerId;
  final String customerName;
  final String? cashSessionId;
  final String paymentMethod; // 'cash_usd', 'cash_bs', 'pago_movil', 'pos_card', 'zelle'
  final String paymentMethodLabel;
  final double amountOriginal;
  final String currency; // 'USD' o 'VES'
  final double exchangeRate;
  final double amountUsdEquivalent;
  final double previousDebtUsd;
  final double remainingDebtUsd;
  final String? referenceNumber;
  final String? bankName;
  final String? notes;
  final DateTime createdAt;

  CustomerDebtPaymentModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    this.cashSessionId,
    required this.paymentMethod,
    required this.paymentMethodLabel,
    required this.amountOriginal,
    required this.currency,
    required this.exchangeRate,
    required this.amountUsdEquivalent,
    required this.previousDebtUsd,
    required this.remainingDebtUsd,
    this.referenceNumber,
    this.bankName,
    this.notes,
    required this.createdAt,
  });
}

