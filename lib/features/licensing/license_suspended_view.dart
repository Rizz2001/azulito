import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/clean_soft_pill.dart';
import '../../core/licensing/licensing_controller.dart';
import 'license_activation_modal.dart';
import 'saas_master_console_modal.dart';

class LicenseSuspendedView extends ConsumerWidget {
  const LicenseSuspendedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final licensingState = ref.watch(licensingProvider);
    final active = licensingState.activeLicense;
    final primaryColor = ref.watch(primaryColorProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 580,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.danger.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icono animado de alerta Kill-Switch
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.danger.withOpacity(0.4), width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lock_clock_outlined,
                      size: 42,
                      color: AppColors.danger,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Badge de estado
                CleanSoftPill(
                  text: 'SUSPENSIÓN DE SERVICIO SAAS',
                  prefix: const Icon(Icons.block, size: 14, color: AppColors.danger),
                  backgroundColor: const Color(0xFFFEF2F2),
                  textColor: AppColors.danger,
                  borderColor: AppColors.danger.withOpacity(0.4),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                ),
                const SizedBox(height: 16),

                // Título y Razón
                Text(
                  'Servicio Temporalmente Suspendido',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                Text(
                  active?.businessName ?? 'Negocio Vinculado',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.danger,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (active?.rif != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'RIF: ${active!.rif} • Terminal: ${active.storeCode}',
                    style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.amber.shade900, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Motivo de Bloqueo:',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.amber.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        active?.supportNotes ??
                            'La suscripción de este establecimiento se encuentra vencida o en revisión administrativa. El acceso al punto de venta y base de datos ha sido pausado de forma remota.',
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.amber.shade900),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Botón de Contacto Soporte WhatsApp
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: const Icon(Icons.chat, size: 18),
                    label: Text(
                      'Contactar a Soporte y Renovar por WhatsApp',
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Abriendo canal de soporte WhatsApp (+58 412 1234567)...'),
                          backgroundColor: Color(0xFF25D366),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Botones secundarios
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.swap_horiz, size: 18),
                        label: const AutoSizeText('Ingresar Otro Código', maxLines: 1),
                        onPressed: () => LicenseActivationModal.show(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryColor,
                          side: BorderSide(color: primaryColor.withOpacity(0.5)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.admin_panel_settings, size: 18),
                        label: const AutoSizeText('SuperAdmin (9999)', maxLines: 1),
                        onPressed: () => SaasMasterConsoleModal.show(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
