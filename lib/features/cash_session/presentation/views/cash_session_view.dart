import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/clean_soft_pill.dart';
import '../../domain/models/cash_session_models.dart';
import '../controllers/cash_session_controller.dart';
import '../../../pos/presentation/controllers/pos_controller.dart';

class CashSessionView extends ConsumerStatefulWidget {
  const CashSessionView({super.key});

  @override
  ConsumerState<CashSessionView> createState() => _CashSessionViewState();
}

class _CashSessionViewState extends ConsumerState<CashSessionView> {
  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(cashSessionProvider);
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
            // 1. TARJETA CABECERA DE SESIÓN ACTIVA
            _buildSessionHeaderCard(context, sessionState, primaryColor, rate),
            const SizedBox(height: 24),

            // 2. CUADRÍCULA DE 4 TARJETAS DE BALANCES ESPERADOS (Clean Soft UI)
            _buildBalanceCardsGrid(context, sessionState, primaryColor, rate),
            const SizedBox(height: 28),

            // 3. SECCIÓN DE AUDITORÍA Y MOVIMIENTOS DEL TURNO
            _buildMovementsSection(context, sessionState, primaryColor),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 1. CABECERA DE SESIÓN ACTIVA (Layout Responsivo)
  // --------------------------------------------------------------------------
  Widget _buildSessionHeaderCard(
    BuildContext context,
    CashSessionState sessionState,
    Color primaryColor,
    double rate,
  ) {
    final session = sessionState.activeSession;
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 14,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Info del Turno
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.point_of_sale, color: primaryColor, size: 26),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Sesión: ${session.cashierName}',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CleanSoftPill(
                        text: session.isOpen ? 'Turno Abierto' : 'Turno Cerrado',
                        prefix: Icon(
                          session.isOpen ? Icons.check_circle : Icons.cancel,
                          size: 13,
                          color: session.isOpen ? AppColors.success : AppColors.danger,
                        ),
                        backgroundColor: session.isOpen ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                        textColor: session.isOpen ? AppColors.success : AppColors.danger,
                        borderColor: session.isOpen ? AppColors.success.withOpacity(0.5) : AppColors.danger.withOpacity(0.5),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Apertura: ${dateFormat.format(session.openedAt)} • Base: \$${session.openingCashUsd.toStringAsFixed(2)} / Bs. ${session.openingCashBs.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),

          // Botones de Acción
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.swap_horiz, size: 18),
                label: const Text('Entrada / Gasto Menor'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: BorderSide(color: primaryColor.withOpacity(0.4)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _showMovementDialog(context, rate),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.assessment, size: 18),
                label: const Text('Arqueo de Caja (Corte X / Z)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _showArqueoDialog(context, sessionState, rate),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 2. CUADRÍCULA DE TARJETAS DE BALANCES (AlignedGridView - letsar/flutter_staggered_grid_view)
  // --------------------------------------------------------------------------
  Widget _buildBalanceCardsGrid(
    BuildContext context,
    CashSessionState sessionState,
    Color primaryColor,
    double rate,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        final isUltraNarrow = constraints.maxWidth < 500;
        final crossCount = isUltraNarrow ? 1 : (isNarrow ? 2 : 4);

        return AlignedGridView.count(
          crossAxisCount: crossCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return _buildStatCard(
                  title: 'Efectivo USD en Gaveta',
                  mainValue: '\$${sessionState.expectedCashUsdInDrawer.toStringAsFixed(2)}',
                  subtitle: 'Base: \$${sessionState.activeSession.openingCashUsd.toStringAsFixed(2)} + Ventas: \$${sessionState.salesCashUsd.toStringAsFixed(2)}',
                  icon: Icons.attach_money,
                  iconColor: primaryColor,
                  bgColor: const Color(0xFFEFF6FF),
                );
              case 1:
                return _buildStatCard(
                  title: 'Efectivo Bs en Gaveta',
                  mainValue: 'Bs. ${sessionState.expectedCashBsInDrawer.toStringAsFixed(2)}',
                  subtitle: 'Base: Bs. ${sessionState.activeSession.openingCashBs.toStringAsFixed(2)} + Ventas: Bs. ${sessionState.salesCashBs.toStringAsFixed(2)}',
                  icon: Icons.payments,
                  iconColor: const Color(0xFF0EA5E9),
                  bgColor: const Color(0xFFF0F9FF),
                );
              case 2:
                return _buildStatCard(
                  title: 'Pago Móvil & Bancos (Bs)',
                  mainValue: 'Bs. ${sessionState.pagoMovilTotalBs.toStringAsFixed(2)}',
                  subtitle: '≈ \$${(sessionState.pagoMovilTotalBs / rate).toStringAsFixed(2)} USD cobrados',
                  icon: Icons.phone_android,
                  iconColor: const Color(0xFF8B5CF6),
                  bgColor: const Color(0xFFF5F3FF),
                );
              case 3:
              default:
                return _buildStatCard(
                  title: 'Punto de Venta / Cashea',
                  mainValue: 'Bs. ${sessionState.posCardTotalBs.toStringAsFixed(2)}',
                  subtitle: 'Crédito/Cashea: \$${sessionState.creditSalesTotalUsd.toStringAsFixed(2)} USD',
                  icon: Icons.credit_card,
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFECFDF5),
                );
            }
          },
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String mainValue,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      constraints: const BoxConstraints(minHeight: 110),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AutoSizeText(
                  title,
                  maxLines: 1,
                  minFontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, size: 18, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              mainValue,
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 4),
          AutoSizeText(
            subtitle,
            maxLines: 1,
            minFontSize: 9,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 3. AUDITORÍA DE MOVIMIENTOS DE LA CAJA
  // --------------------------------------------------------------------------
  Widget _buildMovementsSection(
    BuildContext context,
    CashSessionState sessionState,
    Color primaryColor,
  ) {
    final dateFormat = DateFormat('hh:mm a');

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
                'Movimientos y Auditoría del Turno (${sessionState.sessionPayments.length + sessionState.movements.length + sessionState.debtPayments.length} registros)',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 8),

          // Lista de Pagos de Ventas, Gastos y Abonos
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // 1. Pagos de Ventas
              ...sessionState.sessionPayments.map((p) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFEFF6FF),
                    child: Icon(
                      p.method == 'cash_usd' ? Icons.attach_money : Icons.phone_android,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  title: Text('Venta POS: ${p.methodLabel}', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: Text(
                    p.referenceNumber != null ? 'Ref: ${p.referenceNumber} • Banco: ${p.bankName ?? "N/A"}' : 'Cobro directo en caja',
                    style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '+${p.currency == "USD" ? "\$" : "Bs. "}${p.amountOriginal.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.success),
                      ),
                      if (p.currency == 'VES')
                        Text('≈ \$${p.amountUsdEquivalent.toStringAsFixed(2)} USD', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                );
              }),

              // 2. Gastos Menores / Aportes
              ...sessionState.movements.map((m) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: m.isExpense ? const Color(0xFFFEF2F2) : const Color(0xFFECFDF5),
                    child: Icon(
                      m.isExpense ? Icons.arrow_outward : Icons.arrow_downward,
                      color: m.isExpense ? AppColors.danger : AppColors.success,
                      size: 20,
                    ),
                  ),
                  title: Text(m.isExpense ? 'Gasto de Caja Chica: ${m.reason}' : 'Aporte de Efectivo: ${m.reason}', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: Text('Hora: ${dateFormat.format(m.createdAt)}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                  trailing: Text(
                    '${m.isExpense ? "-" : "+"}${m.currency == "USD" ? "\$" : "Bs. "}${m.amount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15, color: m.isExpense ? AppColors.danger : AppColors.success),
                  ),
                );
              }),

              // 3. Abonos de Clientes CxC
              ...sessionState.debtPayments.map((dp) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFF5F3FF),
                    child: Icon(Icons.receipt_long, color: Color(0xFF8B5CF6), size: 20),
                  ),
                  title: Text('Abono CxC: ${dp.customerName}', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: Text('Método: ${dp.paymentMethodLabel} ${dp.referenceNumber != null ? "(Ref: ${dp.referenceNumber})" : ""}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                  trailing: Text(
                    '+${dp.currency == "USD" ? "\$" : "Bs. "}${dp.amountOriginal.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.success),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // MODAL REGISTRO DE GASTO MENOR O ENTRADA DE CAJA CHICA
  // --------------------------------------------------------------------------
  void _showMovementDialog(BuildContext context, double rate) {
    String type = 'out'; // 'out' = gasto, 'in' = entrada
    String currency = 'USD';
    final amountCtrl = TextEditingController();
    final reasonCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final primaryColor = ref.watch(primaryColorProvider);

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 440,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Entrada / Salida de Caja Chica', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 16),

                  // Tipo de Movimiento
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text('Salida / Gasto')),
                          selected: type == 'out',
                          selectedColor: const Color(0xFFFEE2E2),
                          labelStyle: TextStyle(color: type == 'out' ? AppColors.danger : AppColors.textPrimary, fontWeight: FontWeight.bold),
                          onSelected: (_) => setDialogState(() => type = 'out'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text('Entrada / Aporte')),
                          selected: type == 'in',
                          selectedColor: const Color(0xFFD1FAE5),
                          labelStyle: TextStyle(color: type == 'in' ? AppColors.success : AppColors.textPrimary, fontWeight: FontWeight.bold),
                          onSelected: (_) => setDialogState(() => type = 'in'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Moneda
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text('Dólares (USD)')),
                          selected: currency == 'USD',
                          selectedColor: primaryColor.withOpacity(0.15),
                          labelStyle: TextStyle(color: currency == 'USD' ? primaryColor : AppColors.textPrimary, fontWeight: FontWeight.bold),
                          onSelected: (_) => setDialogState(() => currency = 'USD'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text('Bolívares (VES)')),
                          selected: currency == 'VES',
                          selectedColor: primaryColor.withOpacity(0.15),
                          labelStyle: TextStyle(color: currency == 'VES' ? primaryColor : AppColors.textPrimary, fontWeight: FontWeight.bold),
                          onSelected: (_) => setDialogState(() => currency = 'VES'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Monto',
                      prefixText: currency == 'USD' ? '\$ ' : 'Bs. ',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: reasonCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Motivo / Concepto',
                      hintText: 'Ej. Botellón de agua, Compra bolsas, Avance',
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
                        onPressed: () {
                          final amt = double.tryParse(amountCtrl.text) ?? 0.0;
                          final rsn = reasonCtrl.text.trim();
                          if (amt <= 0 || rsn.isEmpty) return;

                          ref.read(cashSessionProvider.notifier).registerMovement(
                                type: type,
                                amount: amt,
                                currency: currency,
                                reason: rsn,
                                exchangeRate: rate,
                              );

                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Movimiento registrado: ${type == "out" ? "Gasto" : "Entrada"} ${currency == "USD" ? "\$" : "Bs."}$amt ($rsn)'),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        },
                        child: const Text('Guardar Movimiento'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --------------------------------------------------------------------------
  // MODAL ARQUEO DE CAJA (CORTE X / CIERRE Z)
  // --------------------------------------------------------------------------
  void _showArqueoDialog(
    BuildContext context,
    CashSessionState sessionState,
    double rate,
  ) {
    final usdCtrl = TextEditingController(text: sessionState.expectedCashUsdInDrawer.toStringAsFixed(2));
    final bsCtrl = TextEditingController(text: sessionState.expectedCashBsInDrawer.toStringAsFixed(2));

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final primaryColor = ref.watch(primaryColorProvider);
          final declaredUsd = double.tryParse(usdCtrl.text) ?? 0.0;
          final declaredBs = double.tryParse(bsCtrl.text) ?? 0.0;
          final diffUsd = declaredUsd - sessionState.expectedCashUsdInDrawer;
          final diffBs = declaredBs - sessionState.expectedCashBsInDrawer;

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 520,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Arqueo de Caja y Cierre de Turno', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800)),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text('Ingresa el monto físico contado en gaveta:', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: usdCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (_) => setDialogState(() {}),
                          decoration: InputDecoration(
                            labelText: 'Efectivo USD Contado',
                            prefixText: '\$ ',
                            helperText: 'Esperado: \$${sessionState.expectedCashUsdInDrawer.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: bsCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (_) => setDialogState(() {}),
                          decoration: InputDecoration(
                            labelText: 'Efectivo Bs Contado',
                            prefixText: 'Bs. ',
                            helperText: 'Esperado: Bs. ${sessionState.expectedCashBsInDrawer.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Cuadre en Vivo
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Cuadre Efectivo USD:'),
                            Text(
                              diffUsd.abs() < 0.01
                                  ? '🟢 Cuadre Exacto (\$0.00)'
                                  : (diffUsd > 0 ? '🔵 Sobrante (+\$${diffUsd.toStringAsFixed(2)})' : '🔴 Faltante (-\$${diffUsd.abs().toStringAsFixed(2)})'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: diffUsd.abs() < 0.01 ? AppColors.success : (diffUsd > 0 ? primaryColor : AppColors.danger),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Cuadre Efectivo Bs:'),
                            Text(
                              diffBs.abs() < 0.01
                                  ? '🟢 Cuadre Exacto (Bs. 0.00)'
                                  : (diffBs > 0 ? '🔵 Sobrante (+Bs. ${diffBs.toStringAsFixed(2)})' : '🔴 Faltante (-Bs. ${diffBs.abs().toStringAsFixed(2)})'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: diffBs.abs() < 0.01 ? AppColors.success : (diffBs > 0 ? primaryColor : AppColors.danger),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        icon: const Icon(Icons.print, size: 18),
                        label: const Text('Corte X (Parcial)'),
                        onPressed: () {
                          final report = ref.read(cashSessionProvider.notifier).generateZReport(
                                declaredCashUsd: declaredUsd,
                                declaredCashBs: declaredBs,
                                exchangeRate: rate,
                                isFinalClose: false,
                              );
                          Navigator.pop(ctx);
                          _showZReportModal(context, report, isXReport: true);
                        },
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.lock, size: 18),
                        label: const Text('Cierre Z Final (Cerrar Turno)'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger, foregroundColor: Colors.white),
                        onPressed: () {
                          final report = ref.read(cashSessionProvider.notifier).generateZReport(
                                declaredCashUsd: declaredUsd,
                                declaredCashBs: declaredBs,
                                exchangeRate: rate,
                                isFinalClose: true,
                              );
                          Navigator.pop(ctx);
                          _showZReportModal(context, report, isXReport: false);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --------------------------------------------------------------------------
  // MODAL TICKET REPORTE X / Z
  // --------------------------------------------------------------------------
  void _showZReportModal(BuildContext context, CashZReportModel report, {required bool isXReport}) {
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isXReport ? 'REPORTE CORTE X (PARCIAL)' : 'REPORTE DE CIERRE DE CAJA Z',
                style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 16),
              ),
              Text(report.storeName, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              Text('RIF: ${report.storeRif}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
              const Divider(height: 20),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Nº Reporte:'),
                Text(report.reportNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Fecha/Hora:'),
                Text(dateFormat.format(report.generatedAt), style: const TextStyle(fontSize: 12)),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Cajero:'),
                Text(report.cashierName, style: const TextStyle(fontWeight: FontWeight.bold)),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Tasa Activa:'),
                Text('${report.exchangeRate.toStringAsFixed(2)} Bs/\$', style: const TextStyle(fontWeight: FontWeight.bold)),
              ]),
              const Divider(height: 20),

              // Balances
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Base Inicial USD:'),
                Text('\$${report.openingCashUsd.toStringAsFixed(2)}'),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Ventas Efectivo USD:'),
                Text('+\$${report.salesCashUsd.toStringAsFixed(2)}'),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Gastos Caja Chica USD:'),
                Text('-\$${report.cashOutUsd.toStringAsFixed(2)}'),
              ]),
              const Divider(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('TOTAL ESPERADO USD:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${report.expectedTotalCashUsd.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('TOTAL DECLARADO USD:'),
                Text('\$${report.declaredCashUsd.toStringAsFixed(2)}'),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('DIFERENCIA USD:'),
                Text(
                  '\$${report.differenceUsd.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: report.differenceUsd.abs() < 0.01 ? AppColors.success : (report.differenceUsd > 0 ? Colors.blue : AppColors.danger),
                  ),
                ),
              ]),
              const Divider(height: 20),

              // Medios Digitales
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Pago Móvil (Bs):'),
                Text('Bs. ${report.pagoMovilTotalBs.toStringAsFixed(2)}'),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Punto de Venta (Bs):'),
                Text('Bs. ${report.posCardTotalBs.toStringAsFixed(2)}'),
              ]),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Aceptar'),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

