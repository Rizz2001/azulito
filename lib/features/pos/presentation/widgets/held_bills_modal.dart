import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../controllers/pos_controller.dart';

class HeldBillsModal extends ConsumerStatefulWidget {
  const HeldBillsModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const HeldBillsModal(),
    );
  }

  @override
  ConsumerState<HeldBillsModal> createState() => _HeldBillsModalState();
}

class _HeldBillsModalState extends ConsumerState<HeldBillsModal> {
  final TextEditingController _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _noteCtrl.dispose();
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
              Text('Cuentas en Espera (Hold Bills)', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700)),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 12),

          // Sección 1: Pausar cuenta actual si tiene items
          if (posState.cart.isNotEmpty) ...[
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
                  Text('Pausar la cuenta actual (${posState.cart.length} ítems - \$${posState.discountedSubtotalUsd.toStringAsFixed(2)})',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _noteCtrl,
                          decoration: const InputDecoration(
                            hintText: 'Nota o nombre (ej. Cliente camisa azul)...',
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(posProvider.notifier).holdCurrentBill(_noteCtrl.text);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cuenta pausada con éxito. Listo para atender al siguiente cliente.'),
                              backgroundColor: AppColors.warning,
                            ),
                          );
                        },
                        child: const Text('Pausar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Sección 2: Cuentas guardadas en espera
          Text('Cuentas pendientes por reanudar (${posState.heldBills.length}):',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          const SizedBox(height: 8),

          if (posState.heldBills.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text('No hay cuentas en espera en este momento.',
                    style: GoogleFonts.inter(color: AppColors.textSecondary)),
              ),
            )
          else
            SizedBox(
              height: 240,
              child: ListView.separated(
                itemCount: posState.heldBills.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final bill = posState.heldBills[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryColor.withOpacity(0.1),
                          child: Icon(Icons.pause, color: primaryColor, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(bill.note, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14)),
                              Text(
                                '${bill.items.length} ítems • \$${bill.subtotalUsd.toStringAsFixed(2)} • ${bill.customer != null ? bill.customer!.fullName : "Consumidor Final"}',
                                style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.danger, size: 20),
                          onPressed: () => ref.read(posProvider.notifier).deleteHeldBill(bill.id),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(posProvider.notifier).resumeHeldBill(bill.id);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Cuenta reanudada: ${bill.note}'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          ),
                          child: const Text('Reanudar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

