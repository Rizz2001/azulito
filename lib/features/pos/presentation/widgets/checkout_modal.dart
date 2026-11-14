import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/database/sync_service.dart';
import '../../domain/models/pos_models.dart';
import '../controllers/pos_controller.dart';
import 'receipt_dialog.dart';
import '../../../cash_session/presentation/controllers/cash_session_controller.dart';
import '../../../sales/presentation/controllers/sales_history_controller.dart';
import '../../../sales/domain/models/sale_history_models.dart';

class CheckoutModal extends ConsumerStatefulWidget {
  const CheckoutModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const CheckoutModal(),
    );
  }

  @override
  ConsumerState<CheckoutModal> createState() => _CheckoutModalState();
}

class _CheckoutModalState extends ConsumerState<CheckoutModal> {
  final List<PaymentItemModel> _payments = [];
  String _activePaymentTab = 'cash_usd'; // cash_usd, pago_movil, pos_card, zelle, cashea, store_credit, cash_bs, biopago

  // Controladores para entradas
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _refCtrl = TextEditingController();
  final TextEditingController _bankCtrl = TextEditingController(text: 'Banesco');
  final TextEditingController _zelleHolderCtrl = TextEditingController();

  // Calculadora de Vuelto Dual
  final TextEditingController _receivedCashCtrl = TextEditingController();

  // Cashea
  int _casheaInitialPercent = 40; // 40%, 50%, 60%
  String _casheaInitialMethod = 'pago_movil';

  final List<String> _banks = [
    'Banesco',
    'Banco de Venezuela (BDV)',
    'Mercantil',
    'BBVA Provincial',
    'Bancamiga',
    'BNC (Banco Nacional de Crédito)',
    'Bancaribe',
  ];

  @override
  void dispose() {
    _amountCtrl.dispose();
    _refCtrl.dispose();
    _bankCtrl.dispose();
    _zelleHolderCtrl.dispose();
    _receivedCashCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posState = ref.watch(posProvider);
    final primaryColor = ref.watch(primaryColorProvider);
    final rate = posState.exchangeRate;

    // LÓGICA EXACTA DE IGTF (3% sólo sobre montos en divisas: cash_usd y zelle)
    double divisasTotalUsd = 0.0;
    for (final p in _payments) {
      if (p.method == 'cash_usd' || p.method == 'zelle') {
        divisasTotalUsd += p.amountUsdEquivalent;
      }
    }
    final igtfAmountUsd = posState.igtfEnabled ? (divisasTotalUsd * 0.03) : 0.0;
    final totalFinalUsd = posState.discountedSubtotalUsd + igtfAmountUsd;
    final totalFinalBs = totalFinalUsd * rate;

    // Cobertura de Pagos
    final coveredUsd = _payments.fold<double>(0.0, (acc, p) => acc + p.amountUsdEquivalent);
    final remainingUsd = (totalFinalUsd - coveredUsd).clamp(0.0, totalFinalUsd);
    final remainingBs = remainingUsd * rate;
    final isFullyCovered = remainingUsd <= 0.009;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. CABECERA MAESTRA DEL CHECKOUT
          _buildCheckoutHeader(context, posState, primaryColor, rate, totalFinalUsd, totalFinalBs, igtfAmountUsd),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 16),

          // 2. CUERPO: CONSTRUCTOR DE PAGOS MIXTOS (Izquierda Métodos, Derecha Pagos Aplicados)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Panel Izquierdo: Formulario de Adición de Método
                Expanded(
                  flex: 3,
                  child: _buildPaymentMethodForm(context, posState, primaryColor, rate, remainingUsd, remainingBs),
                ),
                const SizedBox(width: 20),
                const VerticalDivider(width: 1, color: AppColors.border),
                const SizedBox(width: 20),

                // Panel Derecho: Resumen de Pagos Aplicados y Vuelto
                Expanded(
                  flex: 2,
                  child: _buildPaymentsSummaryPanel(
                    context,
                    primaryColor,
                    rate,
                    coveredUsd,
                    remainingUsd,
                    remainingBs,
                    isFullyCovered,
                    totalFinalUsd,
                    totalFinalBs,
                    igtfAmountUsd,
                    posState.igtfEnabled && igtfAmountUsd > 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 1. CABECERA DEL CHECKOUT
  // --------------------------------------------------------------------------
  Widget _buildCheckoutHeader(
    BuildContext context,
    PosState posState,
    Color primaryColor,
    double rate,
    double totalFinalUsd,
    double totalFinalBs,
    double igtfAmountUsd,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Cobro Bimoneda y Pagos Mixtos',
                  style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                  ),
                  child: Text(
                    'Tasa: ${rate.toStringAsFixed(2)} Bs/\$',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Cliente: ${posState.customer?.fullName ?? "Consumidor Final"} • Subtotal: \$${posState.discountedSubtotalUsd.toStringAsFixed(2)}',
              style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),

        // Total Prominente y Switch IGTF
        Row(
          children: [
            // Switch IGTF
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('IGTF (3% en Divisas)', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)),
                      Text(
                        igtfAmountUsd > 0 ? '+\$${igtfAmountUsd.toStringAsFixed(2)}' : 'Inactivo',
                        style: GoogleFonts.inter(fontSize: 11, color: igtfAmountUsd > 0 ? AppColors.warning : AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Switch.adaptive(
                    value: posState.igtfEnabled,
                    activeColor: primaryColor,
                    onChanged: (val) => ref.read(posProvider.notifier).setIgtfEnabled(val),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Totales
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${totalFinalUsd.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w900, color: primaryColor),
                ),
                Text(
                  'Bs. ${totalFinalBs.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
          ],
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // 2. PANEL IZQUIERDO: FORMULARIO DE MÉTODOS DE PAGO
  // --------------------------------------------------------------------------
  Widget _buildPaymentMethodForm(
    BuildContext context,
    PosState posState,
    Color primaryColor,
    double rate,
    double remainingUsd,
    double remainingBs,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selecciona Método de Pago a Registrar:', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),

        // Pestañas de Métodos
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTabChip('cash_usd', '💵 Efectivo USD', primaryColor),
              _buildTabChip('pago_movil', '📱 Pago Móvil', primaryColor),
              _buildTabChip('pos_card', '💳 Punto de Venta', primaryColor),
              _buildTabChip('zelle', '⚡ Zelle', primaryColor),
              _buildTabChip('cashea', '🟡 Cashea (BNPL)', primaryColor),
              _buildTabChip('store_credit', '📋 Crédito Tienda', primaryColor),
              _buildTabChip('cash_bs', '🇻🇪 Efectivo Bs', primaryColor),
              _buildTabChip('biopago', '👆 Biopago BDV', primaryColor),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Formulario Específico según la pestaña seleccionada
        Expanded(
          child: SingleChildScrollView(
            child: _buildFormContentForTab(context, posState, primaryColor, rate, remainingUsd, remainingBs),
          ),
        ),
      ],
    );
  }

  Widget _buildTabChip(String key, String label, Color primaryColor) {
    final isSelected = _activePaymentTab == key;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          fontSize: 12,
        ),
        onSelected: (_) {
          setState(() {
            _activePaymentTab = key;
            _amountCtrl.clear();
            _receivedCashCtrl.clear();
          });
        },
      ),
    );
  }

  Widget _buildFormContentForTab(
    BuildContext context,
    PosState posState,
    Color primaryColor,
    double rate,
    double remainingUsd,
    double remainingBs,
  ) {
    switch (_activePaymentTab) {
      // ----------------------------------------------------------------------
      // EFECTIVO USD CON CALCULADORA DE VUELTO DUAL
      // ----------------------------------------------------------------------
      case 'cash_usd':
        final payingAmountUsd = double.tryParse(_amountCtrl.text) ?? remainingUsd;
        final receivedCash = double.tryParse(_receivedCashCtrl.text) ?? payingAmountUsd;
        final changeUsd = (receivedCash - payingAmountUsd).clamp(0.0, double.infinity);
        final changeBs = changeUsd * rate;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cobro en Efectivo Dólares (USD):', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Monto a abonar a la cuenta',
                      prefixText: '\$ ',
                      hintText: remainingUsd.toStringAsFixed(2),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => setState(() => _amountCtrl.text = remainingUsd.toStringAsFixed(2)),
                  child: const Text('Monto Exacto'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Calculadora de Vuelto
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Calculadora de Vuelto Dual (Anti-Falta de Cambio)',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: primaryColor)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _receivedCashCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Billete entregado por cliente',
                            prefixText: '\$ ',
                            hintText: 'ej. 20 o 50',
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Billetes rápidos ($5, $10, $20, $50, $100)
                      Wrap(
                        spacing: 6,
                        children: [10, 20, 50, 100].map((b) {
                          return OutlinedButton(
                            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                            onPressed: () => setState(() => _receivedCashCtrl.text = b.toString()),
                            child: Text('\$$b'),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  if (receivedCash > payingAmountUsd) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vuelto a dar:', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
                        Row(
                          children: [
                            Text(
                              '\$${changeUsd.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.success),
                            ),
                            const Text('  ó  '),
                            Text(
                              'Bs. ${changeBs.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildAddPaymentButton(
              label: 'Abonar Efectivo USD',
              onPressed: () {
                final amt = double.tryParse(_amountCtrl.text) ?? remainingUsd;
                if (amt <= 0) return;
                _addPayment(
                  method: 'cash_usd',
                  methodLabel: 'Efectivo USD',
                  amountOriginal: amt,
                  currency: 'USD',
                  exchangeRate: rate,
                  amountUsdEquivalent: amt,
                  notes: receivedCash > amt ? 'Billete: \$$receivedCash (Vuelto: \$${changeUsd.toStringAsFixed(2)})' : null,
                );
              },
            ),
          ],
        );

      // ----------------------------------------------------------------------
      // PAGO MÓVIL (VES) CON BANCO Y REFERENCIA
      // ----------------------------------------------------------------------
      case 'pago_movil':
        final payingAmountBs = double.tryParse(_amountCtrl.text) ?? remainingBs;
        final payingUsdEquiv = payingAmountBs / rate;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registro de Pago Móvil Interbancario (≈ \$${payingUsdEquiv.toStringAsFixed(2)}):', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Monto en Bolívares (VES)',
                      prefixText: 'Bs. ',
                      hintText: remainingBs.toStringAsFixed(2),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => setState(() => _amountCtrl.text = remainingBs.toStringAsFixed(2)),
                  child: const Text('Monto Exacto'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _bankCtrl.text,
                    decoration: const InputDecoration(labelText: 'Banco Emisor'),
                    items: _banks.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                    onChanged: (val) => setState(() => _bankCtrl.text = val ?? 'Banesco'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _refCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Últimos 4-6 dígitos Ref. *',
                      hintText: 'ej. 123456',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAddPaymentButton(
              label: 'Abonar Pago Móvil (Bs. ${payingAmountBs.toStringAsFixed(2)})',
              onPressed: () {
                final amtBs = double.tryParse(_amountCtrl.text) ?? remainingBs;
                if (amtBs <= 0) return;
                _addPayment(
                  method: 'pago_movil',
                  methodLabel: 'Pago Móvil (${_bankCtrl.text})',
                  amountOriginal: amtBs,
                  currency: 'VES',
                  exchangeRate: rate,
                  amountUsdEquivalent: amtBs / rate,
                  referenceNumber: _refCtrl.text.trim().isEmpty ? 'PM-0000' : _refCtrl.text.trim(),
                  bankName: _bankCtrl.text,
                );
              },
            ),
          ],
        );

      // ----------------------------------------------------------------------
      // PUNTO DE VENTA (TARJETAS) Y BIOPAGO
      // ----------------------------------------------------------------------
      case 'pos_card':
      case 'biopago':
        final isBiopago = _activePaymentTab == 'biopago';
        final payingAmountBs = double.tryParse(_amountCtrl.text) ?? remainingBs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isBiopago ? 'Cobro Biopago BDV:' : 'Punto de Venta (Tarjeta Débito/Crédito):', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Monto en Bolívares (VES)',
                      prefixText: 'Bs. ',
                      hintText: remainingBs.toStringAsFixed(2),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => setState(() => _amountCtrl.text = remainingBs.toStringAsFixed(2)),
                  child: const Text('Monto Exacto'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _refCtrl,
              decoration: const InputDecoration(
                labelText: 'Número de Lote / Aprobación (Opcional)',
                hintText: 'ej. 004521',
              ),
            ),
            const SizedBox(height: 16),
            _buildAddPaymentButton(
              label: 'Abonar ${isBiopago ? "Biopago" : "Punto de Venta"} (Bs. ${payingAmountBs.toStringAsFixed(2)})',
              onPressed: () {
                final amtBs = double.tryParse(_amountCtrl.text) ?? remainingBs;
                if (amtBs <= 0) return;
                _addPayment(
                  method: isBiopago ? 'biopago' : 'pos_card',
                  methodLabel: isBiopago ? 'Biopago BDV' : 'Punto de Venta',
                  amountOriginal: amtBs,
                  currency: 'VES',
                  exchangeRate: rate,
                  amountUsdEquivalent: amtBs / rate,
                  referenceNumber: _refCtrl.text.trim().isEmpty ? null : _refCtrl.text.trim(),
                );
              },
            ),
          ],
        );

      // ----------------------------------------------------------------------
      // ZELLE (USD)
      // ----------------------------------------------------------------------
      case 'zelle':
        final payingAmountUsd = double.tryParse(_amountCtrl.text) ?? remainingUsd;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transferencia Zelle (USD):', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Monto en USD',
                      prefixText: '\$ ',
                      hintText: remainingUsd.toStringAsFixed(2),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => setState(() => _amountCtrl.text = remainingUsd.toStringAsFixed(2)),
                  child: const Text('Monto Exacto'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _zelleHolderCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Titular de la Cuenta *',
                      hintText: 'ej. María Pérez',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _refCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Número de Confirmación / Ref *',
                      hintText: 'ej. ZEL-9948',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAddPaymentButton(
              label: 'Abonar Zelle (\$${payingAmountUsd.toStringAsFixed(2)})',
              onPressed: () {
                final amt = double.tryParse(_amountCtrl.text) ?? remainingUsd;
                if (amt <= 0) return;
                _addPayment(
                  method: 'zelle',
                  methodLabel: 'Zelle (${_zelleHolderCtrl.text.trim().isEmpty ? "Titular" : _zelleHolderCtrl.text.trim()})',
                  amountOriginal: amt,
                  currency: 'USD',
                  exchangeRate: rate,
                  amountUsdEquivalent: amt,
                  referenceNumber: _refCtrl.text.trim().isEmpty ? 'ZEL-000' : _refCtrl.text.trim(),
                );
              },
            ),
          ],
        );

      // ----------------------------------------------------------------------
      // CASHEA (BNPL VENEZUELA: 2 MODOS)
      // ----------------------------------------------------------------------
      case 'cashea':
        final totalOrderToFinanceUsd = remainingUsd;
        final initialAmountUsd = totalOrderToFinanceUsd * (_casheaInitialPercent / 100);
        final financedAmountUsd = totalOrderToFinanceUsd - initialAmountUsd;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(8)),
                  child: const Text('CASHEA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                Text('Modalidad Compra Ahora Paga Después (BNPL):', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 12),

            // Selector de % de Inicial
            Text('Porcentaje de Pago Inicial en Caja:', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 6),
            Row(
              children: [40, 50, 60].map((pct) {
                final isSelected = _casheaInitialPercent == pct;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text('Inicial $pct%'),
                    selected: isSelected,
                    selectedColor: Colors.amber,
                    onSelected: (_) => setState(() => _casheaInitialPercent = pct),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            // Desglose de Cuotas Cashea
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1. Pago Inicial en Caja hoy:', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(
                        '\$${initialAmountUsd.toStringAsFixed(2)} (Bs. ${(initialAmountUsd * rate).toStringAsFixed(2)})',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w900, color: Colors.amber.shade900),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2. Financiado en 3 cuotas quincenales:', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                      Text(
                        '\$${financedAmountUsd.toStringAsFixed(2)} (3 x \$${(financedAmountUsd / 3).toStringAsFixed(2)})',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ¿Cómo cancela la inicial hoy?
            DropdownButtonFormField<String>(
              value: _casheaInitialMethod,
              decoration: const InputDecoration(labelText: '¿Cómo paga el cliente la inicial hoy?'),
              items: const [
                DropdownMenuItem(value: 'pago_movil', child: Text('Pago Móvil (VES)')),
                DropdownMenuItem(value: 'pos_card', child: Text('Punto de Venta / Tarjeta')),
                DropdownMenuItem(value: 'cash_usd', child: Text('Efectivo USD')),
              ],
              onChanged: (val) => setState(() => _casheaInitialMethod = val ?? 'pago_movil'),
            ),
            const SizedBox(height: 16),
            _buildAddPaymentButton(
              label: 'Registrar Venta por Cashea (Inicial + 3 Cuotas)',
              onPressed: () {
                if (totalOrderToFinanceUsd <= 0) return;
                // Agrega pago de la inicial
                _addPayment(
                  method: 'cashea_initial',
                  methodLabel: 'Cashea Inicial ($_casheaInitialPercent% vía $_casheaInitialMethod)',
                  amountOriginal: initialAmountUsd,
                  currency: 'USD',
                  exchangeRate: rate,
                  amountUsdEquivalent: initialAmountUsd,
                  notes: 'Inicial cancelada en caja',
                );
                // Agrega saldo financiado por la plataforma
                _addPayment(
                  method: 'cashea_financed',
                  methodLabel: 'Cashea Financiado (3 Cuotas Quincenales)',
                  amountOriginal: financedAmountUsd,
                  currency: 'USD',
                  exchangeRate: rate,
                  amountUsdEquivalent: financedAmountUsd,
                  notes: 'Por cobrar a Cashea C.A.',
                );
              },
            ),
          ],
        );

      // ----------------------------------------------------------------------
      // CRÉDITO DE TIENDA (FIADO / CUENTA POR COBRAR)
      // ----------------------------------------------------------------------
      case 'store_credit':
        final customer = posState.customer;
        final payingAmountUsd = double.tryParse(_amountCtrl.text) ?? remainingUsd;

        if (customer == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.person_off_outlined, size: 40, color: AppColors.warning),
                  const SizedBox(height: 8),
                  Text(
                    'Para vender a crédito debes seleccionar un cliente registrado.',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        final hasEnoughCredit = customer.availableCreditUsd >= payingAmountUsd;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Crédito de Tienda para: ${customer.fullName}', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Límite: \$${customer.creditLimitUsd.toStringAsFixed(2)}'),
                  Text('Deuda Actual: \$${customer.currentDebtUsd.toStringAsFixed(2)}'),
                  Text(
                    'Disponible: \$${customer.availableCreditUsd.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: hasEnoughCredit ? AppColors.success : AppColors.danger),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Monto a cargar a la cuenta de crédito (USD)',
                prefixText: '\$ ',
                hintText: remainingUsd.toStringAsFixed(2),
              ),
            ),
            const SizedBox(height: 16),
            _buildAddPaymentButton(
              label: 'Cargar a Crédito de Tienda',
              onPressed: !hasEnoughCredit
                  ? null
                  : () {
                      final amt = double.tryParse(_amountCtrl.text) ?? remainingUsd;
                      if (amt <= 0 || amt > customer.availableCreditUsd) return;
                      _addPayment(
                        method: 'store_credit',
                        methodLabel: 'Crédito CxC (${customer.fullName})',
                        amountOriginal: amt,
                        currency: 'USD',
                        exchangeRate: rate,
                        amountUsdEquivalent: amt,
                        notes: 'Facturado a crédito',
                      );
                    },
            ),
          ],
        );

      // ----------------------------------------------------------------------
      // EFECTIVO BOLÍVARES
      // ----------------------------------------------------------------------
      case 'cash_bs':
      default:
        final payingAmountBs = double.tryParse(_amountCtrl.text) ?? remainingBs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Efectivo en Bolívares (VES):', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Monto en Bolívares (VES)',
                      prefixText: 'Bs. ',
                      hintText: remainingBs.toStringAsFixed(2),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => setState(() => _amountCtrl.text = remainingBs.toStringAsFixed(2)),
                  child: const Text('Monto Exacto'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAddPaymentButton(
              label: 'Abonar Efectivo Bs (Bs. ${payingAmountBs.toStringAsFixed(2)})',
              onPressed: () {
                final amtBs = double.tryParse(_amountCtrl.text) ?? remainingBs;
                if (amtBs <= 0) return;
                _addPayment(
                  method: 'cash_bs',
                  methodLabel: 'Efectivo Bs',
                  amountOriginal: amtBs,
                  currency: 'VES',
                  exchangeRate: rate,
                  amountUsdEquivalent: amtBs / rate,
                );
              },
            ),
          ],
        );
    }
  }

  Widget _buildAddPaymentButton({required String label, required VoidCallback? onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add, size: 20),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }

  void _addPayment({
    required String method,
    required String methodLabel,
    required double amountOriginal,
    required String currency,
    required double exchangeRate,
    required double amountUsdEquivalent,
    String? referenceNumber,
    String? bankName,
    String? notes,
  }) {
    setState(() {
      _payments.add(
        PaymentItemModel(
          id: const Uuid().v4(),
          method: method,
          methodLabel: methodLabel,
          amountOriginal: amountOriginal,
          currency: currency,
          exchangeRate: exchangeRate,
          amountUsdEquivalent: amountUsdEquivalent,
          referenceNumber: referenceNumber,
          bankName: bankName,
          notes: notes,
        ),
      );
      _amountCtrl.clear();
      _refCtrl.clear();
      _receivedCashCtrl.clear();
    });
  }

  // --------------------------------------------------------------------------
  // 3. PANEL DERECHO: PAGOS APLICADOS Y BOTÓN DE CONFIRMACIÓN
  // --------------------------------------------------------------------------
  Widget _buildPaymentsSummaryPanel(
    BuildContext context,
    Color primaryColor,
    double rate,
    double coveredUsd,
    double remainingUsd,
    double remainingBs,
    bool isFullyCovered,
    double totalFinalUsd,
    double totalFinalBs,
    double igtfAmountUsd,
    bool igtfApplied,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pagos Registrados (${_payments.length}):', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
        const SizedBox(height: 8),

        // Lista de Pagos Parciales
        Expanded(
          child: _payments.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment, size: 36, color: AppColors.textSecondary.withOpacity(0.4)),
                      const SizedBox(height: 8),
                      Text('No has registrado abonos', style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 13)),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: _payments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final p = _payments[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.methodLabel, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                                if (p.referenceNumber != null)
                                  Text('Ref: ${p.referenceNumber}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${p.amountUsdEquivalent.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13, color: primaryColor),
                              ),
                              if (p.currency == 'VES')
                                Text('Bs. ${p.amountOriginal.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary)),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                            onPressed: () => setState(() => _payments.removeAt(index)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),

        const Divider(height: 16),

        // Estado de Cobertura
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isFullyCovered ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isFullyCovered ? AppColors.success : AppColors.danger),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isFullyCovered ? 'TOTAL CUBIERTO' : 'FALTA POR COBRAR:',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12, color: isFullyCovered ? AppColors.success : AppColors.danger),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isFullyCovered ? 'Listo para emitir' : '\$${remainingUsd.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 15, color: isFullyCovered ? AppColors.success : AppColors.danger),
                  ),
                  if (!isFullyCovered)
                    Text('Bs. ${remainingBs.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.danger)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Botón Maestro de Confirmación
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.check_circle, size: 20),
            label: const Text('CONFIRMAR Y EMITIR RECIBO'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isFullyCovered ? AppColors.success : AppColors.border,
              foregroundColor: Colors.white,
            ),
            onPressed: !isFullyCovered
                ? null
                : () {
                    // Confirmación atómica y generación del ticket
                    final receipt = ref.read(posProvider.notifier).completeSale(
                          payments: _payments,
                          totalUsdFinal: totalFinalUsd,
                          totalBsFinal: totalFinalBs,
                          igtfAmountUsdFinal: igtfAmountUsd,
                          igtfAppliedFinal: igtfApplied,
                        );

                    // 1. Impactar sesión de caja activa
                    ref.read(cashSessionProvider.notifier).recordSalePayments(receipt.payments);

                    // 2. Agregar a Historial de Ventas
                    ref.read(salesHistoryProvider.notifier).addCompletedSale(
                          SaleHistoryRecordModel(
                            id: receipt.saleId,
                            invoiceNumber: receipt.invoiceNumber,
                            date: receipt.date,
                            customerName: receipt.customer?.fullName ?? 'Consumidor Final',
                            customerId: receipt.customer?.id,
                            exchangeRate: receipt.exchangeRate,
                            subtotalUsd: receipt.subtotalUsd,
                            discountUsd: receipt.discountUsd,
                            igtfApplied: receipt.igtfApplied,
                            igtfAmountUsd: receipt.igtfAmountUsd,
                            totalUsd: receipt.totalUsd,
                            totalBs: receipt.totalBs,
                            paymentStatus: 'paid',
                            items: receipt.items
                                .map((i) => SaleHistoryItemModel(
                                      id: i.id,
                                      productId: i.productId,
                                      presentationId: i.presentationId,
                                      variantId: i.variantId,
                                      productName: i.name,
                                      quantity: i.quantity,
                                      returnedQuantity: 0,
                                      unitPriceUsd: i.unitPriceUsd,
                                      subtotalUsd: i.subtotalUsd,
                                      quantityEquivalent: i.quantityEquivalent,
                                    ))
                                .toList(),
                            payments: receipt.payments
                                .map((p) => {
                                      'method': p.method,
                                      'methodLabel': p.methodLabel,
                                      'amountOriginal': p.amountOriginal,
                                      'currency': p.currency,
                                      'amountUsdEquivalent': p.amountUsdEquivalent,
                                      'referenceNumber': p.referenceNumber,
                                      'bankName': p.bankName,
                                    })
                                .toList(),
                          ),
                        );

                    // 3. Encolar en SyncService (Offline-First)
                    ref.read(syncProvider.notifier).enqueueOperation(
                          targetTable: 'sales',
                          entityId: receipt.saleId,
                          operation: 'INSERT',
                          payload: {
                            'id': receipt.saleId,
                            'store_id': 'a0000000-0000-4000-8000-000000000001',
                            'invoice_number': receipt.invoiceNumber,
                            'total_usd': receipt.totalUsd,
                            'total_bs': receipt.totalBs,
                            'payment_status': 'paid',
                            'created_at': DateTime.now().toIso8601String(),
                          },
                        );

                    Navigator.pop(context); // Cierra modal de checkout
                    ReceiptDialog.show(context, receipt); // Abre diálogo de recibo
                  },
          ),
        ),
      ],
    );
  }
}
