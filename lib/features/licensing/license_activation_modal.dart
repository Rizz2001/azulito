import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../core/theme/app_theme.dart';
import '../../core/licensing/licensing_controller.dart';

class LicenseActivationModal extends ConsumerStatefulWidget {
  const LicenseActivationModal({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const LicenseActivationModal(),
    );
  }

  @override
  ConsumerState<LicenseActivationModal> createState() => _LicenseActivationModalState();
}

class _LicenseActivationModalState extends ConsumerState<LicenseActivationModal> {
  late TextEditingController _codeCtrl;
  late TextEditingController _pinCtrl;
  String? _localError;
  bool _isLoading = false;

  final List<Map<String, String>> _sampleStores = const [
    {
      'code': 'AZUL-BODEGON-01',
      'pin': '8842',
      'name': 'Bodegón Principal',
      'status': '🟢 Activa',
    },
    {
      'code': 'AZUL-LICORERIA-02',
      'pin': '2026',
      'name': 'Licorería El Llano',
      'status': '🟢 Activa',
    },
    {
      'code': 'AZUL-FERRETERIA-03',
      'pin': '3030',
      'name': 'Ferretería Barinas',
      'status': '🟢 Activa',
    },
    {
      'code': 'AZUL-REPUESTOS-04',
      'pin': '4040',
      'name': 'Moto Repuestos',
      'status': '🟢 Activa',
    },
    {
      'code': 'AZUL-MOROSO-05',
      'pin': '5050',
      'name': 'Minimarket Moroso',
      'status': '🔴 Suspendida',
    },
  ];

  @override
  void initState() {
    super.initState();
    final active = ref.read(licensingProvider).activeLicense;
    _codeCtrl = TextEditingController(text: active?.storeCode ?? 'AZUL-BODEGON-01');
    _pinCtrl = TextEditingController(text: active?.activationPin ?? '8842');
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    _pinCtrl.dispose();
    super.dispose();
  }

  void _autofill(String code, String pin) {
    setState(() {
      _codeCtrl.text = code;
      _pinCtrl.text = pin;
      _localError = null;
    });
  }

  Future<void> _handleActivation() async {
    final code = _codeCtrl.text.trim();
    final pin = _pinCtrl.text.trim();

    if (code.isEmpty || pin.isEmpty) {
      setState(() {
        _localError = 'Por favor complete el Código de Tienda y el PIN.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _localError = null;
    });

    final success = await ref.read(licensingProvider.notifier).activateTerminal(
          storeCode: code,
          pin: pin,
        );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      final state = ref.read(licensingProvider);
      Navigator.pop(context, true);

      if (state.isSuspended) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⚠️ Licencia verificada: El terminal se encuentra SUSPENDIDO por el Administrador.'),
            backgroundColor: AppColors.danger,
            duration: Duration(seconds: 4),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡Terminal activado con éxito en: ${state.activeLicense?.businessName}!'),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      final errorMsg = ref.read(licensingProvider).errorMessage ?? 'Código de tienda o PIN inválido.';
      setState(() {
        _localError = errorMsg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = ref.watch(primaryColorProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.surface,
      elevation: 24,
      child: Container(
        width: 540,
        padding: const EdgeInsets.all(26),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(Icons.hub_outlined, color: primaryColor, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vinculación de Terminal SaaS',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          Text(
                            'Conecta este APK a la cuenta Supabase propia de tu negocio',
                            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Chips de prueba rápida para los 5 negocios
              Text(
                'NEGOCIOS REGISTRADOS EN SERVIDOR MAESTRO (TEST RÁPIDO):',
                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.6),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _sampleStores.map((s) {
                  final isCurrent = _codeCtrl.text.toUpperCase() == s['code']!.toUpperCase();
                  final isSuspended = s['status']!.contains('Suspendida');

                  return InkWell(
                    onTap: () => _autofill(s['code']!, s['pin']!),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? (isSuspended ? AppColors.danger.withOpacity(0.12) : primaryColor.withOpacity(0.12))
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isCurrent
                              ? (isSuspended ? AppColors.danger : primaryColor)
                              : AppColors.border,
                          width: isCurrent ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(s['status']!.split(' ').first, style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 6),
                          Text(
                            s['name']!,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                              color: isCurrent
                                  ? (isSuspended ? AppColors.danger : primaryColor)
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Inputs
              TextField(
                controller: _codeCtrl,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Código de Tienda (Store Code)',
                  hintText: 'Ej: AZUL-BODEGON-01',
                  prefixIcon: Icon(Icons.storefront_outlined),
                ),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _pinCtrl,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'PIN de Activación (4 Dígitos)',
                  hintText: '••••',
                  prefixIcon: Icon(Icons.key_outlined),
                ),
              ),

              if (_localError != null) ...[
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.danger.withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.danger, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _localError!,
                          style: GoogleFonts.inter(color: AppColors.danger, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 22),

              // Botón de activación
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                        )
                      : const Icon(Icons.rocket_launch, size: 20),
                  label: AutoSizeText(
                    _isLoading ? 'Validando con Servidor Maestro...' : '🚀 Validar Licencia y Conectar Base de Datos',
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700),
                    maxLines: 1,
                  ),
                  onPressed: _isLoading ? null : _handleActivation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
