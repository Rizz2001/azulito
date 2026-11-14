import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/cash_session_models.dart';
import '../../../pos/domain/models/pos_models.dart';
import '../../../customers/domain/models/customer_models.dart';
import '../../../../core/database/sync_service.dart';

class CashSessionState {
  final CashSessionModel activeSession;
  final List<CashMovementModel> movements;
  final List<PaymentItemModel> sessionPayments;
  final List<CustomerDebtPaymentModel> debtPayments;
  final List<CashZReportModel> pastZReports;

  CashSessionState({
    required this.activeSession,
    this.movements = const [],
    this.sessionPayments = const [],
    this.debtPayments = const [],
    this.pastZReports = const [],
  });

  // -------------------------------------------------------------------------
  // DESGLOSE EN TIEMPO REAL POR MÉTODO DE PAGO
  // -------------------------------------------------------------------------

  // Efectivo en Ventas
  double get salesCashUsd => sessionPayments
      .where((p) => p.method == 'cash_usd')
      .fold(0.0, (acc, p) => acc + p.amountOriginal);

  double get salesCashBs => sessionPayments
      .where((p) => p.method == 'cash_bs')
      .fold(0.0, (acc, p) => acc + p.amountOriginal);

  // Efectivo en Abonos de Clientes CxC
  double get cxcCashUsd => debtPayments
      .where((p) => p.currency == 'USD' && p.paymentMethod == 'cash_usd')
      .fold(0.0, (acc, p) => acc + p.amountOriginal);

  double get cxcCashBs => debtPayments
      .where((p) => p.currency == 'VES' && p.paymentMethod == 'cash_bs')
      .fold(0.0, (acc, p) => acc + p.amountOriginal);

  // Movimientos de Caja Chica
  double get cashInsUsd => movements
      .where((m) => m.isIncome && m.currency == 'USD')
      .fold(0.0, (acc, m) => acc + m.amount);

  double get cashInsBs => movements
      .where((m) => m.isIncome && m.currency == 'VES')
      .fold(0.0, (acc, m) => acc + m.amount);

  double get cashOutsUsd => movements
      .where((m) => m.isExpense && m.currency == 'USD')
      .fold(0.0, (acc, m) => acc + m.amount);

  double get cashOutsBs => movements
      .where((m) => m.isExpense && m.currency == 'VES')
      .fold(0.0, (acc, m) => acc + m.amount);

  // Total Esperado en Gaveta
  double get expectedCashUsdInDrawer =>
      activeSession.openingCashUsd + salesCashUsd + cxcCashUsd + cashInsUsd - cashOutsUsd;

  double get expectedCashBsInDrawer =>
      activeSession.openingCashBs + salesCashBs + cxcCashBs + cashInsBs - cashOutsBs;

  // Medios Digitales
  double get pagoMovilTotalBs {
    final fromSales = sessionPayments
        .where((p) => p.method == 'pago_movil')
        .fold(0.0, (acc, p) => acc + p.amountOriginal);
    final fromCxc = debtPayments
        .where((p) => p.paymentMethod == 'pago_movil')
        .fold(0.0, (acc, p) => acc + p.amountOriginal);
    return fromSales + fromCxc;
  }

  double get posCardTotalBs {
    final fromSales = sessionPayments
        .where((p) => p.method == 'pos_card' || p.method == 'biopago')
        .fold(0.0, (acc, p) => acc + p.amountOriginal);
    final fromCxc = debtPayments
        .where((p) => p.paymentMethod == 'pos_card')
        .fold(0.0, (acc, p) => acc + p.amountOriginal);
    return fromSales + fromCxc;
  }

  double get zelleTotalUsd {
    final fromSales = sessionPayments
        .where((p) => p.method == 'zelle')
        .fold(0.0, (acc, p) => acc + p.amountOriginal);
    final fromCxc = debtPayments
        .where((p) => p.paymentMethod == 'zelle')
        .fold(0.0, (acc, p) => acc + p.amountOriginal);
    return fromSales + fromCxc;
  }

  double get creditSalesTotalUsd => sessionPayments
      .where((p) => p.method == 'store_credit' || p.method == 'cashea_financed')
      .fold(0.0, (acc, p) => acc + p.amountUsdEquivalent);

  int get totalSalesCount => sessionPayments.map((p) => p.id).toSet().length;

  CashSessionState copyWith({
    CashSessionModel? activeSession,
    List<CashMovementModel>? movements,
    List<PaymentItemModel>? sessionPayments,
    List<CustomerDebtPaymentModel>? debtPayments,
    List<CashZReportModel>? pastZReports,
  }) {
    return CashSessionState(
      activeSession: activeSession ?? this.activeSession,
      movements: movements ?? this.movements,
      sessionPayments: sessionPayments ?? this.sessionPayments,
      debtPayments: debtPayments ?? this.debtPayments,
      pastZReports: pastZReports ?? this.pastZReports,
    );
  }
}

class CashSessionNotifier extends StateNotifier<CashSessionState> {
  final Ref ref;
  static const _uuid = Uuid();

  CashSessionNotifier(this.ref)
      : super(
          CashSessionState(
            activeSession: CashSessionModel(
              id: 'e0000000-0000-4000-8000-000000000010',
              storeId: 'a0000000-0000-4000-8000-000000000001',
              cashierName: 'Cajero Principal',
              status: CashSessionStatus.open,
              openedAt: DateTime.now().subtract(const Duration(hours: 3)),
              openingCashUsd: 50.00,
              openingCashBs: 500.00,
              expectedCashUsd: 77.90,
              expectedCashBs: 500.00,
              notes: 'Turno Diurno',
            ),
            sessionPayments: [
              // Pago de la venta previa FAC-043201
              PaymentItemModel(
                id: 'fb000000-0000-4000-8000-000000000001',
                method: 'cash_usd',
                methodLabel: 'Efectivo USD',
                amountOriginal: 27.90,
                currency: 'USD',
                exchangeRate: 45.50,
                amountUsdEquivalent: 27.90,
              ),
              PaymentItemModel(
                id: 'fb000000-0000-4000-8000-000000000002',
                method: 'pago_movil',
                methodLabel: 'Pago Móvil (Banesco)',
                amountOriginal: 38.08,
                currency: 'VES',
                exchangeRate: 45.50,
                amountUsdEquivalent: 0.84,
                referenceNumber: 'PM-482910',
                bankName: 'Banesco',
              ),
            ],
          ),
        );

  /// Registra entrada o gasto menor de caja chica
  void registerMovement({
    required String type, // 'in' o 'out'
    required double amount,
    required String currency, // 'USD' o 'VES'
    required String reason,
    required double exchangeRate,
  }) {
    final movementId = _uuid.v4();
    final amountUsd = currency == 'USD' ? amount : (amount / exchangeRate);

    final movement = CashMovementModel(
      id: movementId,
      sessionId: state.activeSession.id,
      type: type,
      amount: amount,
      currency: currency,
      exchangeRate: exchangeRate,
      amountUsdEquivalent: amountUsd,
      reason: reason.trim(),
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      movements: [movement, ...state.movements],
    );

    // Encolar en SyncService (Offline-First)
    ref.read(syncProvider.notifier).enqueueOperation(
          targetTable: 'cash_movements',
          entityId: movementId,
          operation: 'INSERT',
          payload: {
            'id': movementId,
            'store_id': state.activeSession.storeId,
            'cash_session_id': state.activeSession.id,
            'movement_type': type,
            'amount': amount,
            'currency': currency,
            'exchange_rate': exchangeRate,
            'amount_usd_equivalent': amountUsd,
            'reason': reason.trim(),
            'created_at': DateTime.now().toIso8601String(),
          },
        );
  }

  /// Añade pagos de una venta cerrada en el POS
  void recordSalePayments(List<PaymentItemModel> payments) {
    state = state.copyWith(
      sessionPayments: [...state.sessionPayments, ...payments],
    );
  }

  /// Añade abono de deuda de cliente
  void recordCustomerDebtPayment(CustomerDebtPaymentModel payment) {
    state = state.copyWith(
      debtPayments: [payment, ...state.debtPayments],
    );
  }

  /// Realiza Arqueo (Corte X o Cierre Z)
  CashZReportModel generateZReport({
    required double declaredCashUsd,
    required double declaredCashBs,
    required double exchangeRate,
    bool isFinalClose = false,
  }) {
    final expUsd = state.expectedCashUsdInDrawer;
    final expBs = state.expectedCashBsInDrawer;
    final diffUsd = declaredCashUsd - expUsd;
    final diffBs = declaredCashBs - expBs;

    final reportNumber = 'Z-${DateTime.now().year}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';

    final report = CashZReportModel(
      sessionId: state.activeSession.id,
      reportNumber: reportNumber,
      generatedAt: DateTime.now(),
      storeName: 'Azulito Market & POS',
      storeRif: 'J-50123456-7',
      cashierName: state.activeSession.cashierName,
      openedAt: state.activeSession.openedAt,
      closedAt: DateTime.now(),
      exchangeRate: exchangeRate,
      openingCashUsd: state.activeSession.openingCashUsd,
      openingCashBs: state.activeSession.openingCashBs,
      salesCashUsd: state.salesCashUsd,
      salesCashBs: state.salesCashBs,
      cxcCashUsd: state.cxcCashUsd,
      cxcCashBs: state.cxcCashBs,
      cashInUsd: state.cashInsUsd,
      cashInBs: state.cashInsBs,
      cashOutUsd: state.cashOutsUsd,
      cashOutBs: state.cashOutsBs,
      expectedTotalCashUsd: expUsd,
      expectedTotalCashBs: expBs,
      declaredCashUsd: declaredCashUsd,
      declaredCashBs: declaredCashBs,
      differenceUsd: diffUsd,
      differenceBs: diffBs,
      pagoMovilTotalBs: state.pagoMovilTotalBs,
      posCardTotalBs: state.posCardTotalBs,
      zelleTotalUsd: state.zelleTotalUsd,
      creditSalesTotalUsd: state.creditSalesTotalUsd,
      totalSalesCount: state.totalSalesCount,
    );

    if (isFinalClose) {
      final updatedSession = state.activeSession.copyWith(
        status: CashSessionStatus.closed,
        closedAt: DateTime.now(),
        declaredCashUsd: declaredCashUsd,
        declaredCashBs: declaredCashBs,
        differenceUsd: diffUsd,
        differenceBs: diffBs,
      );

      state = state.copyWith(
        activeSession: updatedSession,
        pastZReports: [report, ...state.pastZReports],
      );

      // Sincronizar cierre en Supabase
      ref.read(syncProvider.notifier).enqueueOperation(
            targetTable: 'cash_sessions',
            entityId: updatedSession.id,
            operation: 'UPDATE',
            payload: {
              'status': 'closed',
              'closed_at': DateTime.now().toIso8601String(),
              'expected_cash_usd': expUsd,
              'expected_cash_bs': expBs,
              'declared_cash_usd': declaredCashUsd,
              'declared_cash_bs': declaredCashBs,
              'difference_usd': diffUsd,
              'difference_bs': diffBs,
              'updated_at': DateTime.now().toIso8601String(),
            },
          );
    }

    return report;
  }

  /// Abrir nuevo turno
  void openNewSession({
    required double openingUsd,
    required double openingBs,
    String? cashierName,
    String? notes,
  }) {
    final newId = _uuid.v4();
    final newSession = CashSessionModel(
      id: newId,
      storeId: 'a0000000-0000-4000-8000-000000000001',
      cashierName: cashierName ?? 'Cajero de Turno',
      status: CashSessionStatus.open,
      openedAt: DateTime.now(),
      openingCashUsd: openingUsd,
      openingCashBs: openingBs,
      expectedCashUsd: openingUsd,
      expectedCashBs: openingBs,
      notes: notes,
    );

    state = CashSessionState(
      activeSession: newSession,
      movements: const [],
      sessionPayments: const [],
      debtPayments: const [],
      pastZReports: state.pastZReports,
    );

    ref.read(syncProvider.notifier).enqueueOperation(
          targetTable: 'cash_sessions',
          entityId: newId,
          operation: 'INSERT',
          payload: {
            'id': newId,
            'store_id': 'a0000000-0000-4000-8000-000000000001',
            'user_id': 'f0000000-0000-4000-8000-000000000001',
            'status': 'open',
            'opened_at': DateTime.now().toIso8601String(),
            'opening_cash_usd': openingUsd,
            'opening_cash_bs': openingBs,
            'expected_cash_usd': openingUsd,
            'expected_cash_bs': openingBs,
            'notes': notes,
          },
        );
  }
}

final cashSessionProvider = StateNotifierProvider<CashSessionNotifier, CashSessionState>((ref) {
  return CashSessionNotifier(ref);
});

