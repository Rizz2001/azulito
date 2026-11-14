import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/clean_soft_pill.dart';
import '../../../../core/widgets/sweet_crumb_progress_pill.dart';
import '../../../pos/presentation/controllers/pos_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(dashboardMetricsProvider);
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
            // 1. HERO CARD CON DEGRADADO (Estilo Sweet Crumb: Azul Rey a Azul Cielo)
            _buildHeroCard(context, metrics, primaryColor),
            const SizedBox(height: 20),

            // 2. CUADRÍCULA DE 4 KPIS EN BLANCO PURO (Radius 20px)
            _buildKpisGrid(metrics, rate, primaryColor),
            const SizedBox(height: 24),

            // 3. SECCIÓN INFERIOR: TOP SELLING PRODUCTS + DESGLOSE DE MÉTODOS DE PAGO
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 950;
                if (isNarrow) {
                  return Column(
                    children: [
                      _buildTopSellingSection(metrics),
                      const SizedBox(height: 20),
                      _buildPaymentBreakdownSection(metrics, rate, primaryColor),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Columna Izquierda: Top Selling Products con Barras Tipo Píldora (~60%)
                    Expanded(
                      flex: 6,
                      child: _buildTopSellingSection(metrics),
                    ),
                    const SizedBox(width: 20),

                    // Columna Derecha: Desglose de Métodos de Pago (~40%)
                    Expanded(
                      flex: 4,
                      child: _buildPaymentBreakdownSection(metrics, rate, primaryColor),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 1. HERO CARD CON DEGRADADO
  // --------------------------------------------------------------------------
  Widget _buildHeroCard(BuildContext context, DashboardMetricsState metrics, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E40AF), // Azul Rey Profundo
            Color(0xFF0EA5E9), // Azul Cielo Vibrante
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E40AF).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CleanSoftPill(
                    text: '+${metrics.weeklyGrowthPercent}% esta semana',
                    prefix: const Icon(Icons.trending_up, color: Colors.white, size: 16),
                    backgroundColor: Colors.white.withOpacity(0.2),
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  Text(
                    'Azulito Market & POS • Reporte Ejecutivo',
                    style: GoogleFonts.inter(color: Colors.white.withOpacity(0.85), fontSize: 13),
                  ),
                ],
              ),
              CleanSoftPill(
                text: 'Turno Activo',
                prefix: const Icon(Icons.check_circle, color: Colors.white, size: 14),
                backgroundColor: const Color(0xFF10B981),
                textColor: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          const SizedBox(height: 20),

          Text(
            'Total Facturado en Tienda',
            style: GoogleFonts.inter(color: Colors.white.withOpacity(0.85), fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '\$${metrics.totalRevenueUsd.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5),
                ),
                const SizedBox(width: 12),
                Text(
                  '≈ Bs. ${metrics.totalRevenueBs.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.9)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Incluye ventas en mostrador + abonos a cuentas por cobrar recaudados en caja.',
            style: GoogleFonts.inter(color: Colors.white.withOpacity(0.75), fontSize: 12),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 2. CUADRÍCULA DE 4 KPIS EN BLANCO PURO (AlignedGridView)
  // --------------------------------------------------------------------------
  Widget _buildKpisGrid(DashboardMetricsState metrics, double rate, Color primaryColor) {
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
                return _buildKpiCard(
                  title: 'Ingresos Totales',
                  value: '\$${metrics.totalRevenueUsd.toStringAsFixed(2)}',
                  subtitle: 'Bs. ${metrics.totalRevenueBs.toStringAsFixed(2)}',
                  badgeText: '+24.8%',
                  badgeColor: AppColors.success,
                  icon: Icons.monetization_on_outlined,
                  iconColor: primaryColor,
                );
              case 1:
                return _buildKpiCard(
                  title: 'Utilidad Neta Estimada',
                  value: '\$${metrics.netProfitUsd.toStringAsFixed(2)}',
                  subtitle: 'Ventas menos Costos (COGS)',
                  badgeText: 'Margen ~${metrics.profitMarginPercent.toStringAsFixed(0)}%',
                  badgeColor: const Color(0xFF0EA5E9),
                  icon: Icons.savings_outlined,
                  iconColor: const Color(0xFF0EA5E9),
                );
              case 2:
                return _buildKpiCard(
                  title: 'Productos Vendidos',
                  value: '${metrics.totalUnitsSold.toInt()} Unidades',
                  subtitle: 'Despachadas en el turno',
                  badgeText: 'Alta rotación',
                  badgeColor: const Color(0xFF8B5CF6),
                  icon: Icons.shopping_bag_outlined,
                  iconColor: const Color(0xFF8B5CF6),
                );
              case 3:
              default:
                return _buildKpiCard(
                  title: 'Ticket Promedio',
                  value: '\$${metrics.averageTicketUsd.toStringAsFixed(2)}',
                  subtitle: 'Por transacción realizada',
                  badgeText: 'Óptimo',
                  badgeColor: AppColors.success,
                  icon: Icons.receipt_long_outlined,
                  iconColor: AppColors.success,
                );
            }
          },
        );
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String subtitle,
    required String badgeText,
    required Color badgeColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      constraints: const BoxConstraints(minHeight: 120),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AutoSizeText(
                  title,
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: 8),
              CleanSoftPill(
                text: badgeText,
                backgroundColor: badgeColor.withOpacity(0.12),
                textColor: badgeColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 4),
              Expanded(
                child: AutoSizeText(
                  subtitle,
                  maxLines: 1,
                  minFontSize: 9,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 3. TOP SELLING PRODUCTS CON BARRAS TIPO PÍLDORA (Sweet Crumb Style - Ley 2)
  // --------------------------------------------------------------------------
  Widget _buildTopSellingSection(DashboardMetricsState metrics) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.amber, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Top Selling Products',
                    style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                ],
              ),
              CleanSoftPill(
                text: 'Sweet Crumb Style',
                backgroundColor: const Color(0xFFF1F5F9),
                textColor: AppColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Productos con mayor impacto en ventas durante el turno:',
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 18),

          ...metrics.topSellingProducts.map((item) {
            final pillColor = Color(item.colorHex);
            final qtyDisplay = item.quantitySold == item.quantitySold.toInt()
                ? item.quantitySold.toInt().toString()
                : item.quantitySold.toString();

            return SweetCrumbProgressPill(
              title: '${item.rank}. ${item.productName}',
              subtitle: '\$${item.revenueUsd.toStringAsFixed(2)} • $qtyDisplay ${item.unitLabel}',
              percentage: item.percentageShare,
              progressColor: pillColor,
              avatar: Text(
                item.initials,
                style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 13, color: pillColor),
              ),
            );
          }),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 4. DESGLOSE DE MÉTODOS DE PAGO
  // --------------------------------------------------------------------------
  Widget _buildPaymentBreakdownSection(DashboardMetricsState metrics, double rate, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pie_chart_outline, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              Text(
                'Ingresos por Método de Pago',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Desglose auditado de cobros bimoneda:',
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),

          ...metrics.paymentMethodsRevenueUsd.entries.map((entry) {
            final isZero = entry.value <= 0;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isZero ? const Color(0xFFF8FAFC) : const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isZero ? AppColors.border : AppColors.accent.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        entry.key.contains('USD')
                            ? Icons.attach_money
                            : (entry.key.contains('Móvil')
                                ? Icons.phone_android
                                : (entry.key.contains('Punto') ? Icons.credit_card : Icons.account_balance_wallet)),
                        size: 18,
                        color: isZero ? AppColors.textSecondary : primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        entry.key,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: isZero ? AppColors.textSecondary : AppColors.textPrimary),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          '\$${entry.value.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: isZero ? AppColors.textSecondary : primaryColor),
                        ),
                      ),
                      if (entry.key.contains('VES') && entry.value > 0)
                        Text(
                          '≈ Bs. ${(entry.value * rate).toStringAsFixed(2)}',
                          style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
