import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.trending_up, color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          '+${metrics.weeklyGrowthPercent}% esta semana',
                          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Azulito Market & POS • Reporte Ejecutivo',
                    style: GoogleFonts.inter(color: Colors.white.withOpacity(0.85), fontSize: 13),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Turno Activo',
                      style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Text(
            'Total Facturado en Tienda',
            style: GoogleFonts.inter(color: Colors.white.withOpacity(0.85), fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Row(
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
  // 2. CUADRÍCULA DE 4 KPIS EN BLANCO PURO
  // --------------------------------------------------------------------------
  Widget _buildKpisGrid(DashboardMetricsState metrics, double rate, Color primaryColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        return GridView.count(
          crossAxisCount: isNarrow ? 2 : 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: isNarrow ? 1.7 : 1.8,
          children: [
            _buildKpiCard(
              title: 'Ingresos Totales',
              value: '\$${metrics.totalRevenueUsd.toStringAsFixed(2)}',
              subtitle: 'Bs. ${metrics.totalRevenueBs.toStringAsFixed(2)}',
              badgeText: '+24.8%',
              badgeColor: AppColors.success,
              icon: Icons.monetization_on_outlined,
              iconColor: primaryColor,
            ),
            _buildKpiCard(
              title: 'Utilidad Neta Estimada',
              value: '\$${metrics.netProfitUsd.toStringAsFixed(2)}',
              subtitle: 'Ventas menos Costos (COGS)',
              badgeText: 'Margen ~${metrics.profitMarginPercent.toStringAsFixed(0)}%',
              badgeColor: const Color(0xFF0EA5E9),
              icon: Icons.savings_outlined,
              iconColor: const Color(0xFF0EA5E9),
            ),
            _buildKpiCard(
              title: 'Productos Vendidos',
              value: '${metrics.totalUnitsSold.toInt()} Unidades',
              subtitle: 'Despachadas en el turno',
              badgeText: 'Alta rotación',
              badgeColor: const Color(0xFF8B5CF6),
              icon: Icons.shopping_bag_outlined,
              iconColor: const Color(0xFF8B5CF6),
            ),
            _buildKpiCard(
              title: 'Ticket Promedio',
              value: '\$${metrics.averageTicketUsd.toStringAsFixed(2)}',
              subtitle: 'Por transacción realizada',
              badgeText: 'Óptimo',
              badgeColor: AppColors.success,
              icon: Icons.receipt_long_outlined,
              iconColor: AppColors.success,
            ),
          ],
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
              Text(title, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  badgeText,
                  style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: badgeColor),
                ),
              ),
            ],
          ),
          Text(value, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 4),
              Expanded(
                child: Text(subtitle, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 3. TOP SELLING PRODUCTS CON BARRAS TIPO PÍLDORA (Sweet Crumb Style)
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(9999)),
                child: Text('Sweet Crumb Style', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
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

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Encabezado del Producto
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.rank}. ${item.productName}',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textPrimary),
                      ),
                      Text(
                        '\$${item.revenueUsd.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 13, color: pillColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // BARRA TIPO PÍLDORA REDONDEADA (Inspirada en Imagen 2 Sweet Crumb)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final totalWidth = constraints.maxWidth;
                      final pillWidth = (totalWidth * item.percentageShare).clamp(160.0, totalWidth);

                      return Stack(
                        children: [
                          // Fondo gris suave de la barra completa
                          Container(
                            height: 38,
                            width: totalWidth,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                          ),

                          // Barra de progreso de color con la foto adentro
                          Container(
                            height: 38,
                            width: pillWidth,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: pillColor,
                              borderRadius: BorderRadius.circular(9999),
                              boxShadow: [
                                BoxShadow(
                                  color: pillColor.withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Foto circular o avatar con iniciales dentro de la píldora
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    item.initials,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11,
                                      color: pillColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // Etiqueta dentro de la píldora
                                Expanded(
                                  child: Text(
                                    '\$${item.revenueUsd.toStringAsFixed(2)} • ${item.quantitySold == item.quantitySold.toInt() ? item.quantitySold.toInt() : item.quantitySold} ${item.unitLabel}',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
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
                      Text(
                        '\$${entry.value.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: isZero ? AppColors.textSecondary : primaryColor),
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
