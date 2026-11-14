import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/sale_history_models.dart';
import '../controllers/sales_history_controller.dart';
import '../../../pos/presentation/controllers/pos_controller.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/widgets/pin_auth_modal.dart';

class SalesHistoryView extends ConsumerStatefulWidget {
  const SalesHistoryView({super.key});

  @override
  ConsumerState<SalesHistoryView> createState() => _SalesHistoryViewState();
}

class _SalesHistoryViewState extends ConsumerState<SalesHistoryView> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(salesHistoryProvider);
    final posState = ref.watch(posProvider);
    final primaryColor = ref.watch(primaryColorProvider);
    final rate = posState.exchangeRate;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CABECERA Y BUSCADOR DE FACTURAS
            _buildSearchHeader(context, primaryColor),
            const SizedBox(height: 20),

            // 2. TABLA / LISTA DE VENTAS REGISTRADAS
            _buildSalesList(context, historyState, primaryColor, rate),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader(BuildContext context, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Historial de Ventas y Devoluciones',
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchCtrl,
            onChanged: (val) => ref.read(salesHistoryProvider.notifier).setSearchQuery(val),
            decoration: InputDecoration(
              hintText: 'Buscar por factura (ej. FAC-043201), cliente o método de pago...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchCtrl.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchCtrl.clear();
                        ref.read(salesHistoryProvider.notifier).setSearchQuery('');
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesList(
    BuildContext context,
    SalesHistoryState historyState,
    Color primaryColor,
    double rate,
  ) {
    final sales = historyState.filteredSales;
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');

    if (sales.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            const Icon(Icons.receipt_long, size: 48, color: AppColors.textSecondary),
            const SizedBox(height: 12),
            Text('No se encontraron ventas', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sales.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final sale = sales[index];
        final isRefunded = sale.paymentStatus == 'refunded';
        final isPartialReturn = sale.paymentStatus == 'partial_return';

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isRefunded ? AppColors.danger.withOpacity(0.4) : AppColors.border,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fila Superior: Factura, Estado y Fecha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.receipt, color: primaryColor, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                sale.invoiceNumber,
                                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isRefunded
                                      ? const Color(0xFFFEF2F2)
                                      : (isPartialReturn ? const Color(0xFFFFFBEB) : const Color(0xFFECFDF5)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  isRefunded ? 'Devuelta Total' : (isPartialReturn ? 'Devolución Parcial' : 'Pagada'),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isRefunded
                                        ? AppColors.danger
                                        : (isPartialReturn ? Colors.amber.shade900 : AppColors.success),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${dateFormat.format(sale.date)} • Cliente: ${sale.customerName} • Tasa: ${sale.exchangeRate.toStringAsFixed(2)} Bs/\$',
                            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Total y Botón de Devolución
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${sale.totalUsd.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w900, color: primaryColor),
                          ),
                          Text(
                            'Bs. ${sale.totalBs.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.keyboard_return, size: 16),
                        label: const Text('Procesar Devolución'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isRefunded ? Colors.grey : const Color(0xFFEFF6FF),
                          foregroundColor: isRefunded ? Colors.white : primaryColor,
                          elevation: 0,
                          side: BorderSide(color: isRefunded ? Colors.transparent : primaryColor.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: isRefunded ? null : () => _showPartialReturnModal(context, sale),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: 12),

              // Lista de Ítems Vendidos
              Text('Ítems Facturados:', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
              const SizedBox(height: 6),
              ...sale.items.map((item) {
                final isItemReturned = item.returnedQuantity > 0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${item.quantity.toStringAsFixed(item.quantity % 1 == 0 ? 0 : 3)} x ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(item.productName),
                          if (isItemReturned)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                'Devuelto: ${item.returnedQuantity.toStringAsFixed(item.quantity % 1 == 0 ? 0 : 3)}',
                                style: const TextStyle(fontSize: 11, color: AppColors.danger, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                      Text('\$${item.subtotalUsd.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  // --------------------------------------------------------------------------
  // MODAL DE DEVOLUCIÓN PARCIAL / TOTAL POR ÍTEM
  // --------------------------------------------------------------------------
  void _showPartialReturnModal(BuildContext context, SaleHistoryRecordModel sale) async {
    final authState = ref.read(authProvider);
    if (authState.currentUser.isCashier) {
      final authorized = await PinAuthModal.requestSupervisorAuth(
        context,
        actionName: 'Procesar Devolución de Factura ${sale.invoiceNumber}',
      );
      if (!authorized) return;
    }
    if (!context.mounted) return;

    final Map<String, double> returnQuantities = {};
    for (final i in sale.items) {
      returnQuantities[i.id] = 0.0;
    }
    String refundMethod = 'cash_usd'; // 'cash_usd' o 'cash_bs'
    final reasonCtrl = TextEditingController(text: 'Producto defectuoso / cambio de opinión');

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final primaryColor = ref.watch(primaryColorProvider);

          // Calcular total a reembolsar
          double totalRefundUsd = 0.0;
          for (final item in sale.items) {
            final qtyToReturn = returnQuantities[item.id] ?? 0.0;
            totalRefundUsd += qtyToReturn * item.unitPriceUsd;
          }
          final totalRefundBs = totalRefundUsd * sale.exchangeRate;

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 540,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Devolución Parcial por Ítem', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800)),
                          Text('Factura: ${sale.invoiceNumber} • Cliente: ${sale.customerName}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text('Selecciona qué cantidad devuelve el cliente:', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),

                  // Lista de Ítems para Devolución
                  ...sale.items.map((item) {
                    final available = item.availableForReturn;
                    final currentReturnQty = returnQuantities[item.id] ?? 0.0;
                    final isFraction = item.quantity % 1 != 0;
                    final step = isFraction ? 0.250 : 1.0;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: currentReturnQty > 0 ? primaryColor : AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                Text(
                                  'Vendidos: ${item.quantity.toStringAsFixed(isFraction ? 3 : 0)} • Disp. p/ devolución: ${available.toStringAsFixed(isFraction ? 3 : 0)} (\$${item.unitPriceUsd.toStringAsFixed(2)} c/u)',
                                  style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),

                          // Contador de Devolución
                          if (available > 0)
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, size: 20),
                                  onPressed: currentReturnQty > 0
                                      ? () => setDialogState(() {
                                            returnQuantities[item.id] = (currentReturnQty - step).clamp(0.0, available);
                                          })
                                      : null,
                                ),
                                Text(
                                  currentReturnQty.toStringAsFixed(isFraction ? 3 : 0),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline, size: 20),
                                  onPressed: currentReturnQty + step <= available + 0.001
                                      ? () => setDialogState(() {
                                            returnQuantities[item.id] = (currentReturnQty + step).clamp(0.0, available);
                                          })
                                      : null,
                                ),
                              ],
                            )
                          else
                            const Text('Totalmente devuelto', style: TextStyle(fontSize: 11, color: AppColors.danger)),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 12),

                  // Método de Reembolso
                  Row(
                    children: [
                      const Text('Reembolsar dinero vía:', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: refundMethod,
                        items: const [
                          DropdownMenuItem(value: 'cash_usd', child: Text('Efectivo USD (\$)')),
                          DropdownMenuItem(value: 'cash_bs', child: Text('Efectivo Bolívares (Bs)')),
                        ],
                        onChanged: (val) => setDialogState(() => refundMethod = val ?? 'cash_usd'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Resumen de Reembolso
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total a Reembolsar al Cliente:'),
                        Text(
                          '\$${totalRefundUsd.toStringAsFixed(2)} (Bs. ${totalRefundBs.toStringAsFixed(2)})',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.danger),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón de Confirmación
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text('Confirmar Devolución y Restaurar Stock'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: totalRefundUsd > 0 ? AppColors.danger : Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: totalRefundUsd <= 0
                          ? null
                          : () {
                              for (final entry in returnQuantities.entries) {
                                if (entry.value > 0) {
                                  ref.read(salesHistoryProvider.notifier).processItemReturn(
                                        saleId: sale.id,
                                        itemId: entry.key,
                                        returnQuantity: entry.value,
                                        refundMethod: refundMethod,
                                        reason: reasonCtrl.text.trim(),
                                      );
                                }
                              }

                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Devolución procesada exitosamente. Stock restaurado y caja ajustada (-\$${totalRefundUsd.toStringAsFixed(2)}).'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

