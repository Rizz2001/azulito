import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/sale_history_models.dart';
import '../../../pos/presentation/controllers/pos_controller.dart';
import '../../../cash_session/presentation/controllers/cash_session_controller.dart';
import '../../../../core/database/sync_service.dart';

class SalesHistoryState {
  final List<SaleHistoryRecordModel> sales;
  final String searchQuery;
  final SaleHistoryRecordModel? selectedSale;

  SalesHistoryState({
    required this.sales,
    this.searchQuery = '',
    this.selectedSale,
  });

  List<SaleHistoryRecordModel> get filteredSales {
    if (searchQuery.trim().isEmpty) return sales;
    final q = searchQuery.toLowerCase().trim();
    return sales.where((s) {
      return s.invoiceNumber.toLowerCase().contains(q) ||
          s.customerName.toLowerCase().contains(q) ||
          s.payments.any((p) => (p['methodLabel'] as String? ?? '').toLowerCase().contains(q));
    }).toList();
  }

  SalesHistoryState copyWith({
    List<SaleHistoryRecordModel>? sales,
    String? searchQuery,
    SaleHistoryRecordModel? selectedSale,
    bool clearSelectedSale = false,
  }) {
    return SalesHistoryState(
      sales: sales ?? this.sales,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedSale: clearSelectedSale ? null : (selectedSale ?? this.selectedSale),
    );
  }
}

class SalesHistoryNotifier extends StateNotifier<SalesHistoryState> {
  final Ref ref;
  static const _uuid = Uuid();

  SalesHistoryNotifier(this.ref)
      : super(
          SalesHistoryState(
            sales: [
              SaleHistoryRecordModel(
                id: 'f0000000-0000-4000-8000-000000000001',
                invoiceNumber: 'FAC-043201',
                date: DateTime.now().subtract(const Duration(hours: 1)),
                customerName: 'Juan Pérez',
                customerId: 'b0000000-0000-4000-8000-000000000001',
                exchangeRate: 45.50,
                subtotalUsd: 27.90,
                discountUsd: 0.0,
                igtfApplied: true,
                igtfAmountUsd: 0.84,
                totalUsd: 28.74,
                totalBs: 1307.53,
                paymentStatus: 'paid',
                items: [
                  SaleHistoryItemModel(
                    id: 'fa000000-0000-4000-8000-000000000001',
                    productId: 'd0000000-0000-4000-8000-000000000001',
                    presentationId: 'ddd2e61f-db98-4212-9f3c-6827baa8c299',
                    productName: 'Harina PAN Maíz Blanco 1kg (Caja x 20 Unidades)',
                    quantity: 1,
                    returnedQuantity: 0,
                    unitPriceUsd: 23.50,
                    subtotalUsd: 23.50,
                    quantityEquivalent: 20.0,
                  ),
                  SaleHistoryItemModel(
                    id: 'fa000000-0000-4000-8000-000000000002',
                    productId: 'd0000000-0000-4000-8000-000000000004',
                    productName: 'Queso Blanco Llanero (Kg)',
                    quantity: 0.500,
                    returnedQuantity: 0,
                    unitPriceUsd: 5.80,
                    subtotalUsd: 2.90,
                    quantityEquivalent: 1.0,
                  ),
                  SaleHistoryItemModel(
                    id: 'fa000000-0000-4000-8000-000000000003',
                    productId: 'd0000000-0000-4000-8000-000000000003',
                    productName: 'Refresco Pepsi Cola 1.5L',
                    quantity: 1,
                    returnedQuantity: 0,
                    unitPriceUsd: 1.50,
                    subtotalUsd: 1.50,
                    quantityEquivalent: 1.0,
                  ),
                ],
                payments: [
                  {
                    'method': 'cash_usd',
                    'methodLabel': 'Efectivo USD',
                    'amountOriginal': 27.90,
                    'currency': 'USD',
                    'amountUsdEquivalent': 27.90,
                  },
                  {
                    'method': 'pago_movil',
                    'methodLabel': 'Pago Móvil (Banesco)',
                    'amountOriginal': 38.08,
                    'currency': 'VES',
                    'amountUsdEquivalent': 0.84,
                    'referenceNumber': 'PM-482910',
                  },
                ],
                notes: 'Venta completada en Fase 2',
              ),
            ],
          ),
        );

  void setSearchQuery(String q) {
    state = state.copyWith(searchQuery: q);
  }

  void selectSale(SaleHistoryRecordModel? sale) {
    state = state.copyWith(selectedSale: sale, clearSelectedSale: sale == null);
  }

  /// Añade una venta recién completada desde el POS
  void addCompletedSale(SaleHistoryRecordModel sale) {
    state = state.copyWith(
      sales: [sale, ...state.sales],
    );
  }

  /// Procesa la devolución parcial o total de un ítem de factura
  void processItemReturn({
    required String saleId,
    required String itemId,
    required double returnQuantity,
    required String refundMethod, // 'cash_usd', 'cash_bs'
    String? reason,
  }) {
    final saleIndex = state.sales.indexWhere((s) => s.id == saleId);
    if (saleIndex < 0) return;

    final sale = state.sales[saleIndex];
    final itemIndex = sale.items.indexWhere((i) => i.id == itemId);
    if (itemIndex < 0) return;

    final item = sale.items[itemIndex];
    if (returnQuantity <= 0 || returnQuantity > item.availableForReturn) return;

    // 1. Actualizar returnedQuantity en el ítem de la factura
    final newReturnedQty = item.returnedQuantity + returnQuantity;
    final updatedItem = item.copyWith(returnedQuantity: newReturnedQty);

    final updatedItems = List<SaleHistoryItemModel>.from(sale.items);
    updatedItems[itemIndex] = updatedItem;

    final isAllReturned = updatedItems.every((i) => i.isFullyReturned);
    final updatedSale = sale.copyWith(
      paymentStatus: isAllReturned ? 'refunded' : 'partial_return',
      items: updatedItems,
    );

    final updatedSales = List<SaleHistoryRecordModel>.from(state.sales);
    updatedSales[saleIndex] = updatedSale;

    state = state.copyWith(
      sales: updatedSales,
      selectedSale: updatedSale,
    );

    // 2. Restaurar stock en memoria (_stockMap) y en POS
    final unitsToRestore = returnQuantity * item.quantityEquivalent;
    ref.read(posProvider.notifier).restoreStock(item.productId, unitsToRestore);

    // 3. Registrar egreso de reembolso en la sesión de caja si aplica
    final refundAmountUsd = returnQuantity * item.unitPriceUsd;
    if (refundMethod == 'cash_usd') {
      ref.read(cashSessionProvider.notifier).registerMovement(
            type: 'out',
            amount: refundAmountUsd,
            currency: 'USD',
            reason: 'Devolución parcial $returnQuantity x ${item.productName} (Factura ${sale.invoiceNumber})',
            exchangeRate: sale.exchangeRate,
          );
    } else if (refundMethod == 'cash_bs') {
      final refundAmountBs = refundAmountUsd * sale.exchangeRate;
      ref.read(cashSessionProvider.notifier).registerMovement(
            type: 'out',
            amount: refundAmountBs,
            currency: 'VES',
            reason: 'Devolución parcial $returnQuantity x ${item.productName} (Factura ${sale.invoiceNumber})',
            exchangeRate: sale.exchangeRate,
          );
    }

    // 4. Encolar mutaciones en SyncService (Offline-First)
    final movementId = _uuid.v4();
    ref.read(syncProvider.notifier).enqueueOperation(
          targetTable: 'sale_items',
          entityId: item.id,
          operation: 'UPDATE',
          payload: {
            'returned_quantity': newReturnedQty,
          },
        );

    ref.read(syncProvider.notifier).enqueueOperation(
          targetTable: 'inventory_movements',
          entityId: movementId,
          operation: 'INSERT',
          payload: {
            'id': movementId,
            'store_id': 'a0000000-0000-4000-8000-000000000001',
            'product_id': item.productId,
            'movement_type': 'refund',
            'quantity': unitsToRestore,
            'previous_stock': 0.0,
            'new_stock': unitsToRestore,
            'notes': 'Devolución parcial $returnQuantity x ${item.productName} (Factura ${sale.invoiceNumber})',
            'created_at': DateTime.now().toIso8601String(),
          },
        );
  }
}

final salesHistoryProvider = StateNotifierProvider<SalesHistoryNotifier, SalesHistoryState>((ref) {
  return SalesHistoryNotifier(ref);
});

