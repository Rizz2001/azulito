import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/customer_models.dart';
import '../../../cash_session/presentation/controllers/cash_session_controller.dart';
import '../../../../core/database/sync_service.dart';

class CustomersState {
  final List<CustomerRecordModel> customers;
  final List<CustomerDebtPaymentModel> payments;
  final String searchQuery;

  CustomersState({
    required this.customers,
    this.payments = const [],
    this.searchQuery = '',
  });

  double get totalDebtUsd =>
      customers.fold(0.0, (acc, c) => acc + c.currentDebtUsd);

  int get customersWithDebtCount =>
      customers.where((c) => c.hasDebt).length;

  double get casheaPendingDebtUsd => customers
      .where((c) => c.isCasheaUser)
      .fold(0.0, (acc, c) => acc + c.currentDebtUsd);

  List<CustomerRecordModel> get filteredCustomers {
    if (searchQuery.trim().isEmpty) return customers;
    final q = searchQuery.toLowerCase().trim();
    return customers.where((c) {
      return c.fullName.toLowerCase().contains(q) ||
          c.idDocument.toLowerCase().contains(q) ||
          (c.phone != null && c.phone!.contains(q));
    }).toList();
  }

  CustomersState copyWith({
    List<CustomerRecordModel>? customers,
    List<CustomerDebtPaymentModel>? payments,
    String? searchQuery,
  }) {
    return CustomersState(
      customers: customers ?? this.customers,
      payments: payments ?? this.payments,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class CustomersNotifier extends StateNotifier<CustomersState> {
  final Ref ref;
  static const _uuid = Uuid();

  CustomersNotifier(this.ref)
      : super(
          CustomersState(
            customers: [
              CustomerRecordModel(
                id: 'b0000000-0000-4000-8000-000000000001',
                fullName: 'Juan Pérez',
                idDocument: 'V-18765432',
                phone: '+58 414 7654321',
                creditLimitUsd: 150.00,
                currentDebtUsd: 45.00,
                isCasheaUser: false,
                createdAt: DateTime.now().subtract(const Duration(days: 30)),
              ),
              CustomerRecordModel(
                id: 'b0000000-0000-4000-8000-000000000002',
                fullName: 'María Gómez (Cashea)',
                idDocument: 'V-22345678',
                phone: '+58 424 9876543',
                creditLimitUsd: 200.00,
                currentDebtUsd: 85.00,
                isCasheaUser: true,
                createdAt: DateTime.now().subtract(const Duration(days: 15)),
              ),
              CustomerRecordModel(
                id: 'b0000000-0000-4000-8000-000000000003',
                fullName: 'Inversiones Los Andes, C.A.',
                idDocument: 'J-40987654-1',
                phone: '+58 412 5551234',
                creditLimitUsd: 500.00,
                currentDebtUsd: 0.00,
                isCasheaUser: false,
                createdAt: DateTime.now().subtract(const Duration(days: 60)),
              ),
            ],
          ),
        );

  void setSearchQuery(String q) {
    state = state.copyWith(searchQuery: q);
  }

  /// Registra un abono a la cuenta por cobrar de un cliente
  CustomerDebtPaymentModel recordDebtPayment({
    required String customerId,
    required double amountOriginal,
    required String currency, // 'USD' o 'VES'
    required double exchangeRate,
    required String paymentMethod, // 'cash_usd', 'pago_movil', etc.
    required String paymentMethodLabel,
    String? referenceNumber,
    String? bankName,
    String? notes,
  }) {
    final customerIndex = state.customers.indexWhere((c) => c.id == customerId);
    if (customerIndex < 0) {
      throw Exception('Cliente no encontrado');
    }

    final customer = state.customers[customerIndex];
    final amountUsd = currency == 'USD' ? amountOriginal : (amountOriginal / exchangeRate);
    final previousDebt = customer.currentDebtUsd;
    final remainingDebt = (previousDebt - amountUsd).clamp(0.0, double.infinity);

    final paymentId = _uuid.v4();
    final payment = CustomerDebtPaymentModel(
      id: paymentId,
      customerId: customer.id,
      customerName: customer.fullName,
      cashSessionId: ref.read(cashSessionProvider).activeSession.id,
      paymentMethod: paymentMethod,
      paymentMethodLabel: paymentMethodLabel,
      amountOriginal: amountOriginal,
      currency: currency,
      exchangeRate: exchangeRate,
      amountUsdEquivalent: amountUsd,
      previousDebtUsd: previousDebt,
      remainingDebtUsd: remainingDebt,
      referenceNumber: referenceNumber,
      bankName: bankName,
      notes: notes,
      createdAt: DateTime.now(),
    );

    // 1. Actualizar deuda del cliente en memoria
    final updatedCustomers = List<CustomerRecordModel>.from(state.customers);
    updatedCustomers[customerIndex] = customer.copyWith(currentDebtUsd: remainingDebt);

    state = state.copyWith(
      customers: updatedCustomers,
      payments: [payment, ...state.payments],
    );

    // 2. Notificar e impactar la sesión de caja activa
    ref.read(cashSessionProvider.notifier).recordCustomerDebtPayment(payment);

    // 3. Encolar mutaciones en SyncService (Offline-First)
    ref.read(syncProvider.notifier).enqueueOperation(
          targetTable: 'customers',
          entityId: customer.id,
          operation: 'UPDATE',
          payload: {
            'current_debt_usd': remainingDebt,
            'updated_at': DateTime.now().toIso8601String(),
          },
        );

    ref.read(syncProvider.notifier).enqueueOperation(
          targetTable: 'customer_debt_payments',
          entityId: paymentId,
          operation: 'INSERT',
          payload: {
            'id': paymentId,
            'store_id': 'a0000000-0000-4000-8000-000000000001',
            'customer_id': customer.id,
            'cash_session_id': ref.read(cashSessionProvider).activeSession.id,
            'payment_method': paymentMethod,
            'amount_original': amountOriginal,
            'currency': currency,
            'exchange_rate': exchangeRate,
            'amount_usd_equivalent': amountUsd,
            'reference_number': referenceNumber,
            'bank_name': bankName,
            'notes': notes,
            'created_at': DateTime.now().toIso8601String(),
          },
        );

    return payment;
  }
}

final customersProvider = StateNotifierProvider<CustomersNotifier, CustomersState>((ref) {
  return CustomersNotifier(ref);
});

