import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../controllers/pos_controller.dart';

class DiscountModal extends ConsumerStatefulWidget {
  const DiscountModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const DiscountModal(),
    );
  }

  @override
  ConsumerState<DiscountModal> createState() => _DiscountModalState();
}

class _DiscountModalState extends ConsumerState<DiscountModal> {
  bool _isPercent = true;
  final TextEditingController _valCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = ref.read(posProvider);
    if (state.discountPercent > 0) {
      _isPercent = true;
      _valCtrl.text = state.discountPercent.toStringAsFixed(0);
    } else if (state.discountFixedUsd > 0) {
      _isPercent = false;
      _valCtrl.text = state.discountFixedUsd.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _valCtrl.dispose();
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
              Text('Aplicar Descuento Global', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700)),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Subtotal de la orden: \$${posState.rawSubtotalUsd.toStringAsFixed(2)}',
            style: GoogleFonts.inter(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          // Selector % vs $
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('Porcentaje (%)')),
                  selected: _isPercent,
                  selectedColor: primaryColor,
                  labelStyle: TextStyle(color: _isPercent ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold),
                  onSelected: (val) => setState(() => _isPercent = true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('Monto Fijo en USD (\$)')),
                  selected: !_isPercent,
                  selectedColor: primaryColor,
                  labelStyle: TextStyle(color: !_isPercent ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold),
                  onSelected: (val) => setState(() => _isPercent = false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
            decoration: InputDecoration(
              labelText: _isPercent ? 'Porcentaje de descuento' : 'Monto a descontar en USD',
              prefixText: _isPercent ? '% ' : '\$ ',
            ),
          ),
          const SizedBox(height: 16),
          // Botones rápidos de porcentaje
          if (_isPercent)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [5, 10, 15, 20, 50].map((pct) {
                return OutlinedButton(
                  onPressed: () => setState(() => _valCtrl.text = pct.toString()),
                  child: Text('$pct%'),
                );
              }).toList(),
            ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (posState.calculatedDiscountUsd > 0)
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      ref.read(posProvider.notifier).setDiscount(percent: 0, fixedUsd: 0);
                      Navigator.pop(context);
                    },
                    child: const Text('Quitar Descuento', style: TextStyle(color: AppColors.danger)),
                  ),
                ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final val = double.tryParse(_valCtrl.text) ?? 0.0;
                    if (_isPercent) {
                      ref.read(posProvider.notifier).setDiscount(percent: val, fixedUsd: 0);
                    } else {
                      ref.read(posProvider.notifier).setDiscount(percent: 0, fixedUsd: val);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Aplicar Descuento'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
