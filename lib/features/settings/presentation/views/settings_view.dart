import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/clean_soft_pill.dart';
import '../../../../core/licensing/licensing_controller.dart';
import '../../../licensing/license_activation_modal.dart';
import '../../../licensing/saas_master_console_modal.dart';
import '../../../auth/domain/models/user_profile_model.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/widgets/pin_auth_modal.dart';
import '../../../pos/presentation/widgets/thermal_ticket_modal.dart';
import '../../domain/models/settings_models.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  late TextEditingController _nameCtrl;
  late TextEditingController _rifCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _footerCtrl;
  late TextEditingController _igtfCtrl;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    _nameCtrl = TextEditingController(text: settings.name);
    _rifCtrl = TextEditingController(text: settings.rif);
    _phoneCtrl = TextEditingController(text: settings.phone);
    _addressCtrl = TextEditingController(text: settings.address);
    _footerCtrl = TextEditingController(text: settings.ticketFooter);
    _igtfCtrl = TextEditingController(text: settings.igtfPercentage.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _rifCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _footerCtrl.dispose();
    _igtfCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final authState = ref.watch(authProvider);
    final primaryColor = ref.watch(primaryColorProvider);
    final licensingState = ref.watch(licensingProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header del Módulo
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Configuración General y Tienda',
                      style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Personalización de marca, datos fiscales, roles y hardware de punto de venta',
                      style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.print, size: 18),
                  label: const Text('🖨️ Probar Ticket Térmico'),
                  onPressed: () => ThermalTicketModal.show(context, isTest: true),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 1. PERSONALIZADOR DE MARCA Y COLOR DINÁMICO
            _buildThemeCustomizer(settings, primaryColor),
            const SizedBox(height: 24),

            // 1.5 LICENCIA SAAS & MULTI-NEGOCIO SUPABASE
            _buildSaaSConnectionCard(licensingState, primaryColor),
            const SizedBox(height: 24),

            // 2. FILA DE DOS COLUMNAS: DATOS FISCALES + CONFIGURACIÓN DE IMPRESORA
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 950;
                if (isNarrow) {
                  return Column(
                    children: [
                      _buildStoreFiscalForm(settings, primaryColor),
                      const SizedBox(height: 24),
                      _buildPrinterHardwareCard(settings, primaryColor),
                      const SizedBox(height: 24),
                      _buildRolesAndSecurityCard(authState, primaryColor),
                    ],
                  );
                }

                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildStoreFiscalForm(settings, primaryColor),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 5,
                          child: _buildPrinterHardwareCard(settings, primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildRolesAndSecurityCard(authState, primaryColor),
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
  // 1. PERSONALIZADOR DE MARCA Y PALETA DINÁMICA
  // --------------------------------------------------------------------------
  Widget _buildThemeCustomizer(StoreSettingsModel settings, Color primaryColor) {
    final presets = SettingsNotifier.presets;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.palette_outlined, color: primaryColor, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personalizador de Marca y Paleta Dinámica',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  Text(
                    'Cambia los colores de toda la aplicación en tiempo real (Persistencia en Supabase stores)',
                    style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Cuadrícula de Paletas Predefinidas
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: presets.map((p) {
              final isSelected = settings.primaryColorHex.toUpperCase() == p.primaryHex.toUpperCase();
              final pColor = SettingsNotifier.hexToColor(p.primaryHex);
              final sColor = SettingsNotifier.hexToColor(p.secondaryHex);

              return InkWell(
                onTap: () {
                  ref.read(settingsProvider.notifier).applyPalette(p);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Paleta aplicada: ${p.name} (${p.primaryHex})'),
                      backgroundColor: pColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 220,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected ? pColor.withOpacity(0.08) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? pColor : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Círculos duales de color
                      Stack(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: pColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: pColor.withOpacity(0.4), blurRadius: 4, offset: const Offset(0, 2)),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: sColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              style: GoogleFonts.inter(
                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                fontSize: 13,
                                color: isSelected ? pColor : AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${p.tag} • ${p.primaryHex}',
                              style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle, color: pColor, size: 20),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 1.5 LICENCIA SAAS & CONEXIÓN MULTI-NEGOCIO SUPABASE
  // --------------------------------------------------------------------------
  Widget _buildSaaSConnectionCard(LicensingState licensingState, Color primaryColor) {
    final active = licensingState.activeLicense;
    final isActive = active != null && active.isActive;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
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
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.hub_outlined, color: Color(0xFF0F172A), size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Licencia SaaS & Conexión Multi-Negocio', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16)),
                          const SizedBox(width: 8),
                          CleanSoftPill(
                            text: isActive ? '🟢 ACTIVA' : '🔴 SUSPENDIDA',
                            backgroundColor: isActive ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                            textColor: isActive ? const Color(0xFF065F46) : AppColors.danger,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          ),
                        ],
                      ),
                      Text('Un único APK conectado a múltiples cuentas independientes de Supabase', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: BorderSide(color: primaryColor.withOpacity(0.5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    icon: const Icon(Icons.swap_horiz, size: 18),
                    label: const Text('🔄 Cambiar Tienda / Re-vincular'),
                    onPressed: () => LicenseActivationModal.show(context),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    icon: const Icon(Icons.admin_panel_settings, size: 18),
                    label: const Text('🔐 Consola Maestro SaaS (PIN 9999)'),
                    onPressed: () => SaasMasterConsoleModal.show(context),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Detalles de la tienda activa y endpoint de Supabase
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 650;
                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLicenseInfoRow('Código de Tienda Activa:', active?.storeCode ?? 'N/A', isMono: true),
                      const SizedBox(height: 8),
                      _buildLicenseInfoRow('Nombre Comercial:', active?.businessName ?? 'N/A'),
                      const SizedBox(height: 8),
                      _buildLicenseInfoRow('RIF / Documento Fiscal:', active?.rif ?? 'N/A'),
                      const SizedBox(height: 8),
                      _buildLicenseInfoRow('Plan de Suscripción:', active?.plan ?? 'PRO_BIMONEDA'),
                      const SizedBox(height: 8),
                      _buildLicenseInfoRow('Endpoint Supabase:', active?.targetSupabaseUrl ?? 'N/A', isMono: true),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLicenseInfoRow('Código de Tienda Activa:', active?.storeCode ?? 'N/A', isMono: true),
                          const SizedBox(height: 8),
                          _buildLicenseInfoRow('Nombre Comercial:', active?.businessName ?? 'N/A'),
                          const SizedBox(height: 8),
                          _buildLicenseInfoRow('RIF / Documento Fiscal:', active?.rif ?? 'N/A'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLicenseInfoRow('Plan de Suscripción:', active?.plan ?? 'PRO_BIMONEDA'),
                          const SizedBox(height: 8),
                          _buildLicenseInfoRow('Endpoint Supabase:', active?.targetSupabaseUrl ?? 'N/A', isMono: true),
                          const SizedBox(height: 8),
                          _buildLicenseInfoRow('Servidor Maestro:', 'https://ujrwamckhqhhtdfbikhy.supabase.co', isMono: true),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseInfoRow(String label, String value, {bool isMono = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: isMono
                ? GoogleFonts.spaceMono(fontWeight: FontWeight.w700, fontSize: 11, color: AppColors.textPrimary)
                : GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // 2. DATOS FISCALES Y COMERCIALES
  // --------------------------------------------------------------------------
  Widget _buildStoreFiscalForm(StoreSettingsModel settings, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.storefront, color: primaryColor, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Datos Fiscales y Comerciales', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16)),
                  Text('Información impresa en facturas y reportes Z', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                flex: 6,
                child: TextField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre Comercial de la Tienda'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: _rifCtrl,
                  decoration: const InputDecoration(labelText: 'RIF / Identificación Fiscal'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _phoneCtrl,
                  decoration: const InputDecoration(labelText: 'Teléfono / WhatsApp de Contacto'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: _igtfCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Porcentaje IGTF (%)', suffixText: '%'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          TextField(
            controller: _addressCtrl,
            decoration: const InputDecoration(labelText: 'Dirección Fiscal Completa'),
          ),
          const SizedBox(height: 14),

          TextField(
            controller: _footerCtrl,
            decoration: const InputDecoration(labelText: 'Mensaje al Pie del Ticket'),
          ),
          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.save, size: 18),
                label: const Text('Guardar Datos Fiscales'),
                onPressed: () {
                  final igtfVal = double.tryParse(_igtfCtrl.text) ?? 3.0;
                  ref.read(settingsProvider.notifier).updateStoreDetails(
                        name: _nameCtrl.text.trim(),
                        rif: _rifCtrl.text.trim(),
                        phone: _phoneCtrl.text.trim(),
                        address: _addressCtrl.text.trim(),
                        ticketFooter: _footerCtrl.text.trim(),
                        igtfPercentage: igtfVal,
                        defaultIgtfEnabled: true,
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Datos fiscales del negocio actualizados correctamente.'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 3. CONFIGURACIÓN DE IMPRESORA TÉRMICA (58mm / 80mm)
  // --------------------------------------------------------------------------
  Widget _buildPrinterHardwareCard(StoreSettingsModel settings, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.print_outlined, color: AppColors.accent, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Impresora Térmica ESC/POS', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16)),
                  Text('Configuración de ancho y protocolo de emisión', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          Text('Ancho de Papel de Bobina:', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: _buildChoiceCard(
                  title: '80mm (Estándar POS)',
                  subtitle: 'Ideal para mostradores de supermercado',
                  isSelected: settings.paperWidth == '80mm',
                  onTap: () {
                    ref.read(settingsProvider.notifier).updatePrinterSettings(
                          paperWidth: '80mm',
                          connectionType: settings.connectionType,
                          autoPrintReceipt: settings.autoPrintReceipt,
                        );
                  },
                  primaryColor: primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildChoiceCard(
                  title: '58mm (Portátil)',
                  subtitle: 'Ideal para tablets y delivery móvil',
                  isSelected: settings.paperWidth == '58mm',
                  onTap: () {
                    ref.read(settingsProvider.notifier).updatePrinterSettings(
                          paperWidth: '58mm',
                          connectionType: settings.connectionType,
                          autoPrintReceipt: settings.autoPrintReceipt,
                        );
                  },
                  primaryColor: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text('Modo de Conexión:', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: settings.connectionType,
            decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
            items: const [
              DropdownMenuItem(value: 'browser_pdf', child: Text('Impresión Directa Navegador / Cuadro de Diálogo')),
              DropdownMenuItem(value: 'usb_desktop', child: Text('USB / Serial Desktop Directo (ESC/POS Raw)')),
              DropdownMenuItem(value: 'bluetooth', child: Text('Bluetooth Móvil / Tablet Android')),
            ],
            onChanged: (val) {
              if (val != null) {
                ref.read(settingsProvider.notifier).updatePrinterSettings(
                      paperWidth: settings.paperWidth,
                      connectionType: val,
                      autoPrintReceipt: settings.autoPrintReceipt,
                    );
              }
            },
          ),
          const SizedBox(height: 14),

          SwitchListTile(
            title: Text('Imprimir ticket automáticamente al cobrar', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
            subtitle: Text('Emite el comprobante sin pedir confirmación adicional', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
            value: settings.autoPrintReceipt,
            contentPadding: EdgeInsets.zero,
            activeColor: primaryColor,
            onChanged: (val) {
              ref.read(settingsProvider.notifier).updatePrinterSettings(
                    paperWidth: settings.paperWidth,
                    connectionType: settings.connectionType,
                    autoPrintReceipt: val,
                  );
            },
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                side: BorderSide(color: primaryColor.withOpacity(0.5)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.print, size: 18),
              label: Text('🖨️ Imprimir Ticket de Prueba (${settings.paperWidth})'),
              onPressed: () => ThermalTicketModal.show(context, isTest: true),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 4. GESTIÓN DE USUARIOS Y ROLES (PROFILES)
  // --------------------------------------------------------------------------
  Widget _buildRolesAndSecurityCard(AuthState authState, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.security, color: AppColors.warning, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Seguridad y Roles de Usuario (Profiles)', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16)),
                      Text('Cuentas activas con PIN rápido para control de operaciones sensibles', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.swap_horiz, size: 18),
                label: const Text('Cambiar Usuario Activo'),
                onPressed: () => PinAuthModal.showUserSwitcher(context),
              ),
            ],
          ),
          const SizedBox(height: 18),

          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 650;
              if (isNarrow) {
                return Column(
                  children: authState.users.map((user) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildUserCard(user, authState, primaryColor),
                  )).toList(),
                );
              }

              return Row(
                children: authState.users.map((user) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _buildUserCard(user, authState, primaryColor),
                  ),
                )).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(UserProfileModel user, AuthState authState, Color primaryColor) {
    final isCurrent = user.id == authState.currentUser.id;

    return InkWell(
      onTap: () => PinAuthModal.showUserSwitcher(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCurrent ? primaryColor.withOpacity(0.06) : AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCurrent ? primaryColor : AppColors.border,
            width: isCurrent ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: user.isAdmin ? primaryColor : AppColors.accent,
              child: Icon(user.isAdmin ? Icons.shield : Icons.person, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          user.fullName,
                          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 13),
                          maxLines: 1,
                          minFontSize: 11,
                        ),
                      ),
                      if (isCurrent) ...[
                        const SizedBox(width: 6),
                        CleanSoftPill(
                          text: 'ACTIVO',
                          backgroundColor: AppColors.success,
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rol: ${user.isAdmin ? "Administrador" : "Cajero"} • PIN: •••• (${user.quickPin})',
                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Icon(Icons.pin, size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceCard({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required Color primaryColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.1) : AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? primaryColor : AppColors.border, width: isSelected ? 2 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AutoSizeText(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      fontSize: 13,
                      color: isSelected ? primaryColor : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    minFontSize: 10,
                  ),
                ),
                if (isSelected) Icon(Icons.check_circle, size: 16, color: primaryColor),
              ],
            ),
            const SizedBox(height: 2),
            Text(subtitle, style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

