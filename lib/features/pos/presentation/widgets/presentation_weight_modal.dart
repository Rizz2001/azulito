import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/pos_models.dart';
import '../controllers/pos_controller.dart';

class PresentationWeightModal extends ConsumerStatefulWidget {
  final ProductModel product;

  const PresentationWeightModal({super.key, required this.product});

  static void show(BuildContext context, ProductModel product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => PresentationWeightModal(product: product),
    );
  }

  @override
  ConsumerState<PresentationWeightModal> createState() => _PresentationWeightModalState();
}

class _PresentationWeightModalState extends ConsumerState<PresentationWeightModal> {
  // Selección para Presentaciones / Variantes
  String _selectedOptionId = 'unit'; // 'unit', 'pres_xxx', 'var_xxx'
  double _quantity = 1.0;

  // Selección para Pesables / Fraccionados
  double _weightKg = 0.500;
  final TextEditingController _amountBsCtrl = TextEditingController();
  final TextEditingController _amountUsdCtrl = TextEditingController();
  bool _isManualMoneyMode = false;

  @override
  void dispose() {
    _amountBsCtrl.dispose();
    _amountUsdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posState = ref.watch(posProvider);
    final primaryColor = ref.watch(primaryColorProvider);
    final rate = posState.exchangeRate;

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
      child: widget.product.isWeightFraction
          ? _buildWeightFractionBody(context, posState, primaryColor, rate)
          : _buildPresentationsOrVariantsBody(context, posState, primaryColor, rate),
    );
  }

  // --------------------------------------------------------------------------
  // CUERPO PARA PRODUCTOS PESABLES / FRACCIONADOS (Quesos, Carnes, Víveres Kg)
  // --------------------------------------------------------------------------
  Widget _buildWeightFractionBody(
    BuildContext context,
    PosState posState,
    Color primaryColor,
    double rate,
  ) {
    final pricePerKgUsd = widget.product.priceUsd;
    final pricePerKgBs = pricePerKgUsd * rate;
    final currentSubtotalUsd = _weightKg * pricePerKgUsd;
    final currentSubtotalBs = currentSubtotalUsd * rate;
    final availableStock = posState.stockMap[widget.product.id] ?? 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Precio: \$${pricePerKgUsd.toStringAsFixed(2)} / Kg (Bs. ${pricePerKgBs.toStringAsFixed(2)}) • Disp: ${availableStock.toStringAsFixed(3)} Kg',
                    style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Display Central de Peso
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Text(
                  '${_weightKg.toStringAsFixed(3)} Kg',
                  style: GoogleFonts.inter(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  '≈ ${( _weightKg * 1000 ).toInt()} gramos',
                  style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Chips Rápidos de Peso (0.250kg, 0.500kg, 1.000kg, 2.000kg) - Layout Responsivo
        Center(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [0.250, 0.500, 1.000, 1.500, 2.000].map((kg) {
              final isSelected = (_weightKg - kg).abs() < 0.001 && !_isManualMoneyMode;
              return ChoiceChip(
                label: Text('${kg >= 1 ? kg.toStringAsFixed(0) : (kg * 1000).toInt()} ${kg >= 1 ? "Kg" : "g"}'),
                selected: isSelected,
                selectedColor: primaryColor,
                labelStyle: GoogleFonts.inter(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 12,
                ),
                onSelected: (_) {
                  setState(() {
                    _isManualMoneyMode = false;
                    _weightKg = kg;
                    _amountBsCtrl.clear();
                    _amountUsdCtrl.clear();
                  });
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // Alternativa: Pedir por Monto en Bolívares o Dólares (ej. "Dame 100 Bs de queso")
        ExpansionTile(
          title: Text(
            '¿El cliente pide por monto en dinero? (Bs / USD)',
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.accent),
          ),
          childrenPadding: const EdgeInsets.only(bottom: 12),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountBsCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Monto en Bs',
                      prefixText: 'Bs. ',
                    ),
                    onChanged: (val) {
                      final amountBs = double.tryParse(val) ?? 0.0;
                      if (amountBs > 0 && pricePerKgBs > 0) {
                        setState(() {
                          _isManualMoneyMode = true;
                          _weightKg = amountBs / pricePerKgBs;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _amountUsdCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Monto en USD',
                      prefixText: '\$ ',
                    ),
                    onChanged: (val) {
                      final amountUsd = double.tryParse(val) ?? 0.0;
                      if (amountUsd > 0 && pricePerKgUsd > 0) {
                        setState(() {
                          _isManualMoneyMode = true;
                          _weightKg = amountUsd / pricePerKgUsd;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Barra Inferior de Acción y Subtotal Dinámico
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subtotal Estimado', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                Text(
                  '\$${currentSubtotalUsd.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: primaryColor),
                ),
                Text('Bs. ${currentSubtotalBs.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    final success = ref.read(posProvider.notifier).addToCart(
                          product: widget.product,
                          quantity: _weightKg,
                          isWeight: true,
                        );

                    if (success) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Agregado: ${_weightKg.toStringAsFixed(3)} Kg de ${widget.product.name}'),
                          backgroundColor: AppColors.success,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('No hay suficiente stock disponible para ${_weightKg.toStringAsFixed(3)} Kg'),
                          backgroundColor: AppColors.danger,
                        ),
                      );
                    }
                  },
                  child: const Text('Agregar Peso al Carrito'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // CUERPO PARA PRODUCTOS CON PRESENTACIONES (Cajas/Bultos) O VARIANTES (Tallas/Colores)
  // --------------------------------------------------------------------------
  Widget _buildPresentationsOrVariantsBody(
    BuildContext context,
    PosState posState,
    Color primaryColor,
    double rate,
  ) {
    final product = widget.product;
    final availableStock = posState.stockMap[product.id] ?? 0.0;

    // Calcular precio y factor del item seleccionado
    double selectedPriceUsd = product.priceUsd;
    double factorEquivalent = 1.0;
    String selectedLabel = 'Unidad Suelta';

    ProductPresentationModel? selectedPres;
    ProductVariantModel? selectedVar;

    if (_selectedOptionId.startsWith('pres_')) {
      final presId = _selectedOptionId.replaceFirst('pres_', '');
      selectedPres = product.presentations.firstWhere((p) => p.id == presId);
      selectedPriceUsd = selectedPres.priceUsd;
      factorEquivalent = selectedPres.quantityEquivalent;
      selectedLabel = selectedPres.name;
    } else if (_selectedOptionId.startsWith('var_')) {
      final varId = _selectedOptionId.replaceFirst('var_', '');
      selectedVar = product.variants.firstWhere((v) => v.id == varId);
      selectedPriceUsd = product.priceUsd + selectedVar.additionalPriceUsd;
      selectedLabel = selectedVar.variantName;
    }

    final totalUnitsDeducted = _quantity * factorEquivalent;
    final totalUsd = selectedPriceUsd * _quantity;
    final totalBs = totalUsd * rate;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Stock Disponible en Almacén: ${availableStock.toInt()} unidades',
                    style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          product.hasPresentations ? 'Selecciona Presentación:' : 'Selecciona Variante:',
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 10),

        // Lista de Opciones tipo Radio
        // Opción 1: Unidad Base
        if (product.hasPresentations) ...[
          _buildOptionTile(
            id: 'unit',
            title: 'Unidad Individual',
            subtitle: 'Descuenta 1 unidad de stock',
            priceUsd: product.priceUsd,
            rate: rate,
            primaryColor: primaryColor,
          ),
          ...product.presentations.map(
            (pres) => _buildOptionTile(
              id: 'pres_${pres.id}',
              title: pres.name,
              subtitle: 'Equivale a ${pres.quantityEquivalent.toInt()} unidades de stock',
              priceUsd: pres.priceUsd,
              rate: rate,
              primaryColor: primaryColor,
            ),
          ),
        ] else if (product.hasVariants) ...[
          ...product.variants.map(
            (v) => _buildOptionTile(
              id: 'var_${v.id}',
              title: v.variantName,
              subtitle: 'Stock de esta variante: ${v.stockQuantity.toInt()} unid.',
              priceUsd: product.priceUsd + v.additionalPriceUsd,
              rate: rate,
              primaryColor: primaryColor,
            ),
          ),
        ],

        const SizedBox(height: 20),

        // Selector de Cantidad - 1 + y Descuento de Stock en Tiempo Real
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cantidad a llevar', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                Text(
                  'Descontará: ${totalUnitsDeducted.toInt()} unidades de stock',
                  style: GoogleFonts.inter(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                  ),
                  Text(
                    _quantity.toInt().toString(),
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: () => setState(() => _quantity++),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Botón de Agregar
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              final success = ref.read(posProvider.notifier).addToCart(
                    product: product,
                    presentation: selectedPres,
                    variant: selectedVar,
                    quantity: _quantity,
                  );

              if (success) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Agregado: ${_quantity.toInt()} $selectedLabel de ${product.name}'),
                    backgroundColor: AppColors.success,
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No hay suficiente stock para descontar ${totalUnitsDeducted.toInt()} unidades'),
                    backgroundColor: AppColors.danger,
                  ),
                );
              }
            },
            child: Text(
              'Agregar al Carrito • \$${totalUsd.toStringAsFixed(2)} (Bs. ${totalBs.toStringAsFixed(2)})',
              style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionTile({
    required String id,
    required String title,
    required String subtitle,
    required double priceUsd,
    required double rate,
    required Color primaryColor,
  }) {
    final isSelected = _selectedOptionId == id;
    final priceBs = priceUsd * rate;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => setState(() => _selectedOptionId = id),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withOpacity(0.08) : AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? primaryColor : AppColors.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: isSelected ? primaryColor : AppColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${priceUsd.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    'Bs. ${priceBs.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
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

