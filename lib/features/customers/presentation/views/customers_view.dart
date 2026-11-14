import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/customer_models.dart';
import '../controllers/customers_controller.dart';
import '../../../pos/presentation/controllers/pos_controller.dart';

class CustomersView extends ConsumerStatefulWidget {
  const CustomersView({super.key});

  @override
  ConsumerState<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends ConsumerState<CustomersView> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersState = ref.watch(customersProvider);
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
            // 1. TARJETAS DE RESUMEN SUPERIORES (CxC y Cashea)
            _buildStatCardsRow(context, customersState, primaryColor, rate),
            const SizedBox(height: 24),

            // 2. BUSCADOR Y LISTA DE CLIENTES
            _buildCustomersListSection(context, customersState, primaryColor, rate),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 1. TARJETAS DE RESUMEN SUPERIORES
  // --------------------------------------------------------------------------
  Widget _buildStatCardsRow(
    BuildContext context,
    CustomersState customersState,
    Color primaryColor,
    double rate,
  ) {
    final totalUsd = customersState.totalDebtUsd;
    final totalBs = totalUsd * rate;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 800;
        return GridView.count(
          crossAxisCount: isNarrow ? 1 : 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: isNarrow ? 2.8 : 2.2,
          children: [
            _buildStatCard(
              title: 'Total Cuentas por Cobrar (CxC)',
              mainValue: '\$${totalUsd.toStringAsFixed(2)}',
              subtitle: 'Equivalente: Bs. ${totalBs.toStringAsFixed(2)} (Tasa $rate)',
              icon: Icons.account_balance_wallet,
              iconColor: primaryColor,
              bgColor: const Color(0xFFEFF6FF),
            ),
            _buildStatCard(
              title: 'Clientes con Saldo Pendiente',
              mainValue: '${customersState.customersWithDebtCount} Clientes',
              subtitle: 'De un total de ${customersState.customers.length} registrados',
              icon: Icons.people,
              iconColor: const Color(0xFFF59E0B),
              bgColor: const Color(0xFFFFFBEB),
            ),
            _buildStatCard(
              title: 'Saldo Financiado por Cashea',
              mainValue: '\$${customersState.casheaPendingDebtUsd.toStringAsFixed(2)}',
              subtitle: 'Equivalente: Bs. ${(customersState.casheaPendingDebtUsd * rate).toStringAsFixed(2)}',
              icon: Icons.credit_score,
              iconColor: const Color(0xFF10B981),
              bgColor: const Color(0xFFECFDF5),
            ),
          ],
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, size: 20, color: iconColor),
              ),
            ],
          ),
          Text(
            mainValue,
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
          ),
          Text(
            subtitle,
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 2. DIRECTORIO DE CLIENTES
  // --------------------------------------------------------------------------
  Widget _buildCustomersListSection(
    BuildContext context,
    CustomersState customersState,
    Color primaryColor,
    double rate,
  ) {
    final customers = customersState.filteredCustomers;

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
          // Barra de Búsqueda
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (val) => ref.read(customersProvider.notifier).setSearchQuery(val),
                  decoration: InputDecoration(
                    hintText: 'Buscar cliente por nombre, cédula (V-...) o WhatsApp...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchCtrl.clear();
                              ref.read(customersProvider.notifier).setSearchQuery('');
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Lista de Tarjetas de Clientes
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: customers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final c = customers[index];
              return _buildCustomerItemCard(context, c, primaryColor, rate);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerItemCard(
    BuildContext context,
    CustomerRecordModel customer,
    Color primaryColor,
    double rate,
  ) {
    final debtBs = customer.currentDebtUsd * rate;
    final hasDebt = customer.hasDebt;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasDebt ? AppColors.warning.withOpacity(0.5) : AppColors.border,
          width: hasDebt ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          CircleAvatar(
            radius: 26,
            backgroundColor: primaryColor.withOpacity(0.12),
            child: Text(
              customer.fullName.substring(0, 2).toUpperCase(),
              style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: primaryColor, fontSize: 16),
            ),
          ),
          const SizedBox(width: 16),

          // Datos del Cliente
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      customer.fullName,
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 8),
                    if (customer.isCasheaUser)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Cashea',
                          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Cédula/RIF: ${customer.idDocument} • WhatsApp: ${customer.phone ?? "N/A"}',
                  style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),

          // Barra de Crédito
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Límite: \$${customer.creditLimitUsd.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    Text(
                      'Disponible: \$${customer.availableCreditUsd.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.success),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: customer.creditUsedPercentage,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      customer.creditUsedPercentage > 0.8 ? AppColors.danger : primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),

          // Deuda Actual y Botón de Abono
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${customer.currentDebtUsd.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: hasDebt ? AppColors.danger : AppColors.success,
                ),
              ),
              Text(
                hasDebt ? 'Bs. ${debtBs.toStringAsFixed(2)}' : 'Al día',
                style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              if (hasDebt)
                ElevatedButton.icon(
                  icon: const Icon(Icons.payment, size: 16),
                  label: const Text('Registrar Abono'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _showPaymentModal(context, customer, rate),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // MODAL REGISTRO DE ABONO A DEUDA
  // --------------------------------------------------------------------------
  void _showPaymentModal(BuildContext context, CustomerRecordModel customer, double rate) {
    final amountUsdCtrl = TextEditingController(text: customer.currentDebtUsd.toStringAsFixed(2));
    final amountBsCtrl = TextEditingController(text: (customer.currentDebtUsd * rate).toStringAsFixed(2));
    String currency = 'USD';
    String method = 'cash_usd';
    String methodLabel = 'Efectivo USD';
    final refCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final primaryColor = ref.watch(primaryColorProvider);

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 480,
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
                          Text('Abonar Cuenta por Cobrar', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800)),
                          Text('Cliente: ${customer.fullName}', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                        ],
                      ),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Caja de Deuda Pendiente
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
                        const Text('Deuda Pendiente Actual:'),
                        Text(
                          '\$${customer.currentDebtUsd.toStringAsFixed(2)} (Bs. ${(customer.currentDebtUsd * rate).toStringAsFixed(2)})',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.danger),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Selector de Moneda de Abono
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text(r'Abono en USD ($)')),
                          selected: currency == 'USD',
                          selectedColor: primaryColor.withOpacity(0.15),
                          labelStyle: TextStyle(color: currency == 'USD' ? primaryColor : AppColors.textPrimary, fontWeight: FontWeight.bold),
                          onSelected: (_) => setDialogState(() {
                            currency = 'USD';
                            method = 'cash_usd';
                            methodLabel = 'Efectivo USD';
                          }),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text('Abono en Bolívares (Bs)')),
                          selected: currency == 'VES',
                          selectedColor: primaryColor.withOpacity(0.15),
                          labelStyle: TextStyle(color: currency == 'VES' ? primaryColor : AppColors.textPrimary, fontWeight: FontWeight.bold),
                          onSelected: (_) => setDialogState(() {
                            currency = 'VES';
                            method = 'pago_movil';
                            methodLabel = 'Pago Móvil';
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Input de Monto
                  TextField(
                    controller: currency == 'USD' ? amountUsdCtrl : amountBsCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: currency == 'USD' ? 'Monto a Abonar (USD)' : 'Monto a Abonar (Bs. VES)',
                      prefixText: currency == 'USD' ? '\$ ' : 'Bs. ',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Selector de Método
                  DropdownButtonFormField<String>(
                    value: method,
                    decoration: const InputDecoration(labelText: 'Forma de Pago'),
                    items: currency == 'USD'
                        ? const [
                            DropdownMenuItem(value: 'cash_usd', child: Text('Efectivo USD')),
                            DropdownMenuItem(value: 'zelle', child: Text('Zelle')),
                          ]
                        : const [
                            DropdownMenuItem(value: 'pago_movil', child: Text('Pago Móvil (VES)')),
                            DropdownMenuItem(value: 'pos_card', child: Text('Punto de Venta (Tarjeta)')),
                            DropdownMenuItem(value: 'cash_bs', child: Text('Efectivo Bs')),
                          ],
                    onChanged: (val) {
                      setDialogState(() {
                        method = val ?? 'cash_usd';
                        if (method == 'cash_usd') methodLabel = 'Efectivo USD';
                        if (method == 'zelle') methodLabel = 'Zelle';
                        if (method == 'pago_movil') methodLabel = 'Pago Móvil';
                        if (method == 'pos_card') methodLabel = 'Punto de Venta';
                        if (method == 'cash_bs') methodLabel = 'Efectivo Bs';
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  if (method == 'pago_movil' || method == 'zelle' || method == 'pos_card')
                    TextField(
                      controller: refCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Número de Referencia',
                        hintText: 'Ej. PM-894712',
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Botón Confirmar
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.success, foregroundColor: Colors.white),
                      onPressed: () {
                        final amt = currency == 'USD'
                            ? (double.tryParse(amountUsdCtrl.text) ?? 0.0)
                            : (double.tryParse(amountBsCtrl.text) ?? 0.0);

                        if (amt <= 0) return;

                        final payment = ref.read(customersProvider.notifier).recordDebtPayment(
                              customerId: customer.id,
                              amountOriginal: amt,
                              currency: currency,
                              exchangeRate: rate,
                              paymentMethod: method,
                              paymentMethodLabel: methodLabel,
                              referenceNumber: refCtrl.text.trim().isNotEmpty ? refCtrl.text.trim() : null,
                            );

                        Navigator.pop(ctx);
                        _showPaymentReceiptDialog(context, payment);
                      },
                      child: const Text('Confirmar Abono y Emitir Comprobante'),
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

  // --------------------------------------------------------------------------
  // MODAL COMPROBANTE DE ABONO
  // --------------------------------------------------------------------------
  void _showPaymentReceiptDialog(BuildContext context, CustomerDebtPaymentModel payment) {
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 48),
              const SizedBox(height: 12),
              Text('¡Abono Registrado!', style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 18)),
              Text('Comprobante de Pago a Cuenta', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              const Divider(height: 24),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Cliente:'),
                Text(payment.customerName, style: const TextStyle(fontWeight: FontWeight.bold)),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Fecha:'),
                Text(dateFormat.format(payment.createdAt), style: const TextStyle(fontSize: 12)),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Método de Pago:'),
                Text(payment.paymentMethodLabel),
              ]),
              if (payment.referenceNumber != null)
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Referencia:'),
                  Text(payment.referenceNumber!, style: const TextStyle(fontWeight: FontWeight.bold)),
                ]),
              const Divider(height: 16),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Deuda Anterior:'),
                Text('\$${payment.previousDebtUsd.toStringAsFixed(2)}'),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Monto Abonado:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '-${payment.currency == "USD" ? "\$" : "Bs. "}${payment.amountOriginal.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.success, fontSize: 15),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Nuevo Saldo Pendiente:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '\$${payment.remainingDebtUsd.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.danger, fontSize: 16),
                ),
              ]),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.share, size: 16),
                      label: const Text('WhatsApp'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enlace de WhatsApp generado con el comprobante.')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cerrar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

