import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/pos_models.dart';
import '../controllers/pos_controller.dart';

class CustomerSelectorModal extends ConsumerStatefulWidget {
  const CustomerSelectorModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const CustomerSelectorModal(),
    );
  }

  @override
  ConsumerState<CustomerSelectorModal> createState() => _CustomerSelectorModalState();
}

class _CustomerSelectorModalState extends ConsumerState<CustomerSelectorModal> {
  final TextEditingController _searchCtrl = TextEditingController();
  bool _isCreatingNew = false;

  // Formulario de creación rápida
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _docCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _creditCtrl = TextEditingController(text: '100');

  // Clientes de demostración en memoria
  final List<CustomerModel> _customers = [
    CustomerModel(
      id: 'b0000000-4000-8000-0000-000000000001',
      fullName: 'Juan Pérez (Cliente Frecuente)',
      idDocument: 'V-18765432',
      phone: '+58 414 7654321',
      creditLimitUsd: 150.0,
      currentDebtUsd: 0.0,
    ),
    CustomerModel(
      id: 'b0000000-4000-8000-0000-000000000002',
      fullName: 'María González',
      idDocument: 'V-22123456',
      phone: '+58 412 9876543',
      creditLimitUsd: 80.0,
      currentDebtUsd: 25.0,
    ),
    CustomerModel(
      id: 'b0000000-4000-8000-0000-000000000003',
      fullName: 'Inversiones El Sol C.A.',
      idDocument: 'J-40987654-1',
      phone: '+58 212 5551234',
      creditLimitUsd: 500.0,
      currentDebtUsd: 120.0,
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    _nameCtrl.dispose();
    _docCtrl.dispose();
    _phoneCtrl.dispose();
    _creditCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posState = ref.watch(posProvider);
    final primaryColor = ref.watch(primaryColorProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isCreatingNew ? 'Registrar Nuevo Cliente' : 'Asignar Cliente a la Factura',
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!_isCreatingNew) ...[
            TextField(
              controller: _searchCtrl,
              decoration: const InputDecoration(
                hintText: 'Buscar por Cédula, RIF o Nombre...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            // Opción Consumidor Final
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.border,
                child: Icon(Icons.person_off_outlined, color: AppColors.textSecondary),
              ),
              title: const Text('Consumidor Final (Sin Datos)'),
              subtitle: const Text('Venta rápida estándar sin crédito'),
              trailing: posState.customer == null ? const Icon(Icons.check, color: AppColors.success) : null,
              onTap: () {
                ref.read(posProvider.notifier).setCustomer(null);
                Navigator.pop(context);
              },
            ),
            const Divider(height: 1),
            // Lista de Clientes filtrada
            SizedBox(
              height: 220,
              child: ListView.separated(
                itemCount: _filteredCustomers.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final cust = _filteredCustomers[index];
                  final isSelected = posState.customer?.id == cust.id;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: primaryColor.withOpacity(0.12),
                      child: Text(
                        cust.fullName.substring(0, 1),
                        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(cust.fullName, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: Text('${cust.idDocument} • Crédito Disp: \$${cust.availableCreditUsd.toStringAsFixed(2)}'),
                    trailing: isSelected ? const Icon(Icons.check_circle, color: AppColors.success) : null,
                    onTap: () {
                      ref.read(posProvider.notifier).setCustomer(cust);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.person_add),
                label: const Text('+ Crear Nuevo Cliente Rápido'),
                onPressed: () => setState(() => _isCreatingNew = true),
              ),
            ),
          ] else ...[
            // Formulario Rápido
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Nombre y Apellido / Razón Social *'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _docCtrl,
                    decoration: const InputDecoration(labelText: 'Cédula / RIF (ej. V-12345678) *'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _phoneCtrl,
                    decoration: const InputDecoration(labelText: 'WhatsApp / Teléfono'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _creditCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Límite de Crédito Permitido (\$)',
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _isCreatingNew = false),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameCtrl.text.trim().isEmpty || _docCtrl.text.trim().isEmpty) {
                        return;
                      }
                      final newCust = CustomerModel(
                        id: const Uuid().v4(),
                        fullName: _nameCtrl.text.trim(),
                        idDocument: _docCtrl.text.trim().toUpperCase(),
                        phone: _phoneCtrl.text.trim(),
                        creditLimitUsd: double.tryParse(_creditCtrl.text) ?? 100.0,
                        currentDebtUsd: 0.0,
                      );
                      ref.read(posProvider.notifier).setCustomer(newCust);
                      Navigator.pop(context);
                    },
                    child: const Text('Guardar y Asignar'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  List<CustomerModel> get _filteredCustomers {
    final query = _searchCtrl.text.toLowerCase().trim();
    if (query.isEmpty) return _customers;
    return _customers.where((c) {
      return c.fullName.toLowerCase().contains(query) ||
          c.idDocument.toLowerCase().contains(query) ||
          (c.phone != null && c.phone!.contains(query));
    }).toList();
  }
}

