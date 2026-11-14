import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/user_profile_model.dart';
import '../controllers/auth_controller.dart';

enum PinModalMode {
  switchUser,
  supervisorAuth,
}

class PinAuthModal extends ConsumerStatefulWidget {
  final PinModalMode mode;
  final String? restrictedActionName;
  final VoidCallback? onAuthorized;

  const PinAuthModal({
    super.key,
    this.mode = PinModalMode.switchUser,
    this.restrictedActionName,
    this.onAuthorized,
  });

  static Future<bool> requestSupervisorAuth(
    BuildContext context, {
    required String actionName,
    VoidCallback? onApproved,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => PinAuthModal(
        mode: PinModalMode.supervisorAuth,
        restrictedActionName: actionName,
        onAuthorized: onApproved,
      ),
    );
    return result ?? false;
  }

  static void showUserSwitcher(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const PinAuthModal(mode: PinModalMode.switchUser),
    );
  }

  @override
  ConsumerState<PinAuthModal> createState() => _PinAuthModalState();
}

class _PinAuthModalState extends ConsumerState<PinAuthModal> {
  String _pin = '';
  UserProfileModel? _selectedTargetUser;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider);
    // Para cambio de usuario, preseleccionar el otro usuario para mayor comodidad
    if (widget.mode == PinModalMode.switchUser) {
      final other = authState.users.firstWhere(
        (u) => u.id != authState.currentUser.id,
        orElse: () => authState.users.first,
      );
      _selectedTargetUser = other;
    }
  }

  void _onDigitPressed(String digit) {
    if (_pin.length < 4) {
      setState(() {
        _pin += digit;
        _errorMessage = null;
      });

      if (_pin.length == 4) {
        _submitPin();
      }
    }
  }

  void _onClear() {
    setState(() {
      _pin = '';
      _errorMessage = null;
    });
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _errorMessage = null;
      });
    }
  }

  void _submitPin() {
    final authNotifier = ref.read(authProvider.notifier);

    if (widget.mode == PinModalMode.supervisorAuth) {
      final isValid = authNotifier.verifySupervisorPin(_pin);
      if (isValid) {
        widget.onAuthorized?.call();
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Acción autorizada por el Supervisor.'),
            backgroundColor: AppColors.success,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'PIN de Supervisor incorrecto (Use: 1234)';
          _pin = '';
        });
      }
    } else {
      if (_selectedTargetUser == null) return;
      final success = authNotifier.switchUser(_selectedTargetUser!.id, _pin);
      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sesión iniciada como ${_selectedTargetUser!.fullName}'),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'PIN incorrecto. (Admin: 1234 / Cajero: 0000)';
          _pin = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final primaryColor = ref.watch(primaryColorProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.surface,
      elevation: 24,
      child: Container(
        width: 380,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header del Modal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.mode == PinModalMode.supervisorAuth
                            ? AppColors.warning.withOpacity(0.12)
                            : primaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.mode == PinModalMode.supervisorAuth
                            ? Icons.admin_panel_settings
                            : Icons.lock_person,
                        color: widget.mode == PinModalMode.supervisorAuth
                            ? AppColors.warning
                            : primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.mode == PinModalMode.supervisorAuth
                          ? 'Autorización de Supervisor'
                          : 'Cambio Rápido de Usuario',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20, color: AppColors.textSecondary),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Selector de usuario objetivo si es modo switchUser
            if (widget.mode == PinModalMode.switchUser) ...[
              Text(
                'Seleccione el perfil para iniciar turno:',
                style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 10),
              Row(
                children: authState.users.map((u) {
                  final isSelected = _selectedTargetUser?.id == u.id;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap: () => setState(() {
                          _selectedTargetUser = u;
                          _pin = '';
                          _errorMessage = null;
                        }),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (u.isAdmin ? primaryColor.withOpacity(0.15) : AppColors.accent.withOpacity(0.15))
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? primaryColor : AppColors.border,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                u.isAdmin ? Icons.shield : Icons.badge_outlined,
                                size: 22,
                                color: isSelected ? primaryColor : AppColors.textSecondary,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                u.fullName.split(' ').first,
                                style: GoogleFonts.inter(
                                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                  fontSize: 12,
                                  color: isSelected ? primaryColor : AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                u.isAdmin ? 'Admin (1234)' : 'Cajero (0000)',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.warning, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Acción protegida: "${widget.restrictedActionName ?? 'Acción Sensible'}". Ingrese el PIN de Supervisor (1234) para autorizar.',
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.amber.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Indicador visual de 4 Puntos PIN
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isFilled = index < _pin.length;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled ? primaryColor : AppColors.background,
                    border: Border.all(
                      color: isFilled ? primaryColor : AppColors.border,
                      width: 2,
                    ),
                  ),
                );
              }),
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: GoogleFonts.inter(fontSize: 12, color: AppColors.danger, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],

            const SizedBox(height: 20),

            // Teclado Numérico Estilo Cajero / POS (3x4)
            _buildKeypad(primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad(Color primaryColor) {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['C', '0', '⌫'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((key) {
              final isSpecial = key == 'C' || key == '⌫';
              return InkWell(
                onTap: () {
                  if (key == 'C') {
                    _onClear();
                  } else if (key == '⌫') {
                    _onBackspace();
                  } else {
                    _onDigitPressed(key);
                  }
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 72,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSpecial ? const Color(0xFFF1F5F9) : AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    key,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: isSpecial ? FontWeight.bold : FontWeight.w600,
                      color: key == 'C' ? AppColors.danger : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
