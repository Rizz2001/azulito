import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/clean_soft_pill.dart';
import '../../../pos/domain/models/pos_models.dart';
import '../../../pos/presentation/controllers/pos_controller.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/widgets/pin_auth_modal.dart';
import '../controllers/inventory_controller.dart';
import '../../domain/models/inventory_models.dart';

class InventoryView extends ConsumerStatefulWidget {
  const InventoryView({super.key});

  @override
  ConsumerState<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends ConsumerState<InventoryView> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posState = ref.watch(posProvider);
    final inventoryState = ref.watch(inventoryProvider);
    final primaryColor = ref.watch(primaryColorProvider);
    final rate = posState.exchangeRate;

    final metrics = ref.read(inventoryProvider.notifier).calculateMetrics(posState.catalog, rate);
    final filteredProducts = ref.read(inventoryProvider.notifier).filterProducts(posState.catalog, posState.stockMap);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CABECERA: ACCIONES PRINCIPALES Y TÍTULO (Layout Responsivo)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gestión de Inventario y Catálogo',
                      style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Control multi-tipo, calculadora de márgenes, compras y Kardex auditable',
                      style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.list_alt, size: 18),
                      label: const Text('📋 Ver Kardex'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => _showKardexModal(context),
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: const Text('📦 Cargar Compra'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.success,
                        side: const BorderSide(color: AppColors.success),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => _showPurchaseModal(context, posState.catalog),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('+ Nuevo Producto'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => _showProductFormModal(context),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 2. CUADRÍCULA DE MÉTRICAS DE VALORIZACIÓN
            _buildMetricsCards(metrics, inventoryState, primaryColor),
            const SizedBox(height: 20),

            // 3. BUSCADOR Y FILTROS
            _buildSearchAndFilters(inventoryState, primaryColor),
            const SizedBox(height: 16),

            // 4. TABLA AUDITABLE DE PRODUCTOS
            _buildProductsTable(filteredProducts, posState.stockMap, rate, primaryColor),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 1. TARJETAS DE MÉTRICAS SUPERIORES (AlignedGridView - letsar/flutter_staggered_grid_view)
  // --------------------------------------------------------------------------
  Widget _buildMetricsCards(InventoryMetricsModel metrics, InventoryState invState, Color primaryColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        final isUltraNarrow = constraints.maxWidth < 500;
        final crossCount = isUltraNarrow ? 1 : (isNarrow ? 2 : 4);

        return AlignedGridView.count(
          crossAxisCount: crossCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return _buildStatCard(
                  title: 'Total SKUs Activos',
                  mainValue: '${metrics.totalSkus} Productos',
                  subtitle: 'Catálogo disponible en tienda',
                  icon: Icons.inventory_2,
                  iconColor: primaryColor,
                  bgColor: const Color(0xFFEFF6FF),
                );
              case 1:
                return _buildStatCard(
                  title: 'Valor Inventario (Costo)',
                  mainValue: '\$${metrics.totalCostUsd.toStringAsFixed(2)}',
                  subtitle: 'Costo total de adquisición USD',
                  icon: Icons.monetization_on,
                  iconColor: const Color(0xFF0EA5E9),
                  bgColor: const Color(0xFFF0F9FF),
                );
              case 2:
                return _buildStatCard(
                  title: 'Valor Inventario (Venta)',
                  mainValue: '\$${metrics.totalRetailUsd.toStringAsFixed(2)}',
                  subtitle: 'Bs. ${metrics.totalRetailBs.toStringAsFixed(2)}',
                  icon: Icons.point_of_sale,
                  iconColor: AppColors.success,
                  bgColor: const Color(0xFFECFDF5),
                );
              case 3:
              default:
                return InkWell(
                  onTap: () => ref.read(inventoryProvider.notifier).toggleLowStockFilter(),
                  borderRadius: BorderRadius.circular(20),
                  child: _buildStatCard(
                    title: 'Alertas Stock Bajo',
                    mainValue: '${metrics.lowStockCount} Críticos',
                    subtitle: invState.showOnlyLowStock ? 'Filtrando solo críticos (Toca p/ ver todos)' : '≤ Stock Mínimo (Toca p/ filtrar)',
                    icon: Icons.warning_amber_rounded,
                    iconColor: metrics.lowStockCount > 0 ? AppColors.danger : AppColors.success,
                    bgColor: metrics.lowStockCount > 0 ? const Color(0xFFFEF2F2) : const Color(0xFFECFDF5),
                    isHighlighted: invState.showOnlyLowStock,
                  ),
                );
            }
          },
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
    bool isHighlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      constraints: const BoxConstraints(minHeight: 110),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted ? AppColors.danger : AppColors.border,
          width: isHighlighted ? 2 : 1,
        ),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AutoSizeText(
                  title,
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, size: 18, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              mainValue,
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 4),
          AutoSizeText(
            subtitle,
            maxLines: 1,
            minFontSize: 9,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(fontSize: 11, color: isHighlighted ? AppColors.danger : AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 2. BUSCADOR Y CHIPS DE CATEGORÍA
  // --------------------------------------------------------------------------
  Widget _buildSearchAndFilters(InventoryState invState, Color primaryColor) {
    final categories = [
      {'id': 'all', 'label': 'Todos'},
      {'id': 'viveres', 'label': 'Víveres y Granos'},
      {'id': 'bebidas', 'label': 'Bebidas y Refrescos'},
      {'id': 'charcuteria', 'label': 'Charcutería y Carnes'},
      {'id': 'snacks', 'label': 'Snacks y Ropa'},
      {'id': 'limpieza', 'label': 'Limpieza y Hogar'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (val) => ref.read(inventoryProvider.notifier).setSearchQuery(val),
                  decoration: InputDecoration(
                    hintText: 'Buscar por Nombre, SKU o Código de Barras...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchCtrl.clear();
                              ref.read(inventoryProvider.notifier).setSearchQuery('');
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              if (invState.showOnlyLowStock)
                FilterChip(
                  label: const Text('⚠️ Mostrando solo Stock Bajo'),
                  selected: true,
                  selectedColor: const Color(0xFFFEE2E2),
                  labelStyle: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.bold),
                  onSelected: (_) => ref.read(inventoryProvider.notifier).toggleLowStockFilter(),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((cat) {
                final isSelected = invState.selectedCategory == cat['id'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat['label']!),
                    selected: isSelected,
                    selectedColor: primaryColor.withOpacity(0.15),
                    labelStyle: TextStyle(
                      color: isSelected ? primaryColor : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                      fontSize: 12,
                    ),
                    onSelected: (_) => ref.read(inventoryProvider.notifier).setSelectedCategory(cat['id']!),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 3. TABLA DE PRODUCTOS
  // --------------------------------------------------------------------------
  Widget _buildProductsTable(List<ProductModel> products, Map<String, double> stockMap, double rate, Color primaryColor) {
    if (products.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.search_off, size: 48, color: AppColors.textSecondary),
              const SizedBox(height: 12),
              Text('No se encontraron productos coincidentes', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border),
        itemBuilder: (context, index) {
          final p = products[index];
          final currentStock = stockMap[p.id] ?? p.stockQuantity;
          final isLowStock = currentStock <= p.minStockAlert;
          final isOutOfStock = currentStock <= 0;
          final marginPercent = p.costUsd > 0 ? (((p.priceUsd - p.costUsd) / p.costUsd) * 100) : 0.0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                // Avatar con iniciales
                CircleAvatar(
                  radius: 22,
                  backgroundColor: primaryColor.withOpacity(0.12),
                  child: Text(
                    p.name.length >= 2 ? p.name.substring(0, 2).toUpperCase() : 'PR',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: primaryColor, fontSize: 13),
                  ),
                ),
                const SizedBox(width: 14),

                // Nombre y Códigos
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                            child: Text(p.sku ?? 'S/SKU', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            p.barcode != null ? 'BAR: ${p.barcode}' : 'Sin código',
                            style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          const SizedBox(width: 8),
                          _buildTypeBadge(p.type),
                        ],
                      ),
                    ],
                  ),
                ),

                // Costo, Margen y Precio
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Costo Compra', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                          Text('\$${p.costUsd.toStringAsFixed(2)}', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Margen', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: marginPercent >= 30 ? const Color(0xFFECFDF5) : const Color(0xFFFFFBEB),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '+${marginPercent.toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: marginPercent >= 30 ? AppColors.success : Colors.amber.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('\$${p.priceUsd.toStringAsFixed(2)}', style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 15, color: primaryColor)),
                          Text('Bs. ${(p.priceUsd * rate).toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // Stock Actual con Badge de Alerta (Ley 1 CleanSoftPill)
                CleanSoftPill(
                  text: isOutOfStock
                      ? 'Agotado (0)'
                      : (isLowStock
                          ? 'Crítico (${p.isWeightFraction ? currentStock.toStringAsFixed(1) : currentStock.toInt()})'
                          : (p.isWeightFraction ? '${currentStock.toStringAsFixed(2)} Kg' : '${currentStock.toInt()} Unid.')),
                  backgroundColor: isOutOfStock
                      ? const Color(0xFFFEF2F2)
                      : (isLowStock ? const Color(0xFFFFFBEB) : const Color(0xFFECFDF5)),
                  textColor: isOutOfStock
                      ? AppColors.danger
                      : (isLowStock ? Colors.amber.shade900 : AppColors.success),
                  borderColor: isOutOfStock
                      ? AppColors.danger
                      : (isLowStock ? AppColors.warning : AppColors.success),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),

                const SizedBox(width: 14),

                // Botones de Acción (Ajuste de Stock y Editar)
                IconButton(
                  icon: const Icon(Icons.tune, size: 20, color: AppColors.textSecondary),
                  tooltip: 'Ajuste de Stock (Merma/Conteo)',
                  onPressed: () => _showAdjustmentModal(context, p),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.accent),
                  tooltip: 'Editar Producto',
                  onPressed: () => _showProductFormModal(context, productToEdit: p),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeBadge(ProductType type) {
    String label = 'Unidad';
    Color color = const Color(0xFF0EA5E9);
    switch (type) {
      case ProductType.weightFraction:
        label = 'Pesable';
        color = const Color(0xFF8B5CF6);
        break;
      case ProductType.variant:
        label = 'Variantes';
        color = const Color(0xFFF59E0B);
        break;
      case ProductType.combo:
        label = 'Combo';
        color = const Color(0xFF10B981);
        break;
      default:
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }

  // --------------------------------------------------------------------------
  // 4. MODAL CREACIÓN / EDICIÓN DE PRODUCTO CON CALCULADORA DE RENTABILIDAD
  // --------------------------------------------------------------------------
  void _showProductFormModal(BuildContext context, {ProductModel? productToEdit}) async {
    final authState = ref.read(authProvider);
    if (authState.currentUser.isCashier) {
      final authorized = await PinAuthModal.requestSupervisorAuth(
        context,
        actionName: productToEdit != null ? 'Modificar Producto / Costos' : 'Crear Nuevo Producto en Inventario',
      );
      if (!authorized) return;
    }
    if (!context.mounted) return;

    final posState = ref.read(posProvider);
    final rate = posState.exchangeRate;
    final primaryColor = ref.read(primaryColorProvider);

    final nameCtrl = TextEditingController(text: productToEdit?.name ?? '');
    final skuCtrl = TextEditingController(text: productToEdit?.sku ?? 'SKU-${Random().nextInt(899999) + 100000}');
    final barcodeCtrl = TextEditingController(text: productToEdit?.barcode ?? '759${Random().nextInt(899999999) + 100000000}');
    String categoryId = productToEdit?.categoryId ?? 'viveres';
    ProductType selectedType = productToEdit?.type ?? ProductType.unit;

    // Calculadora interactiva
    double cost = productToEdit?.costUsd ?? 0.80;
    double price = productToEdit?.priceUsd ?? 1.04;
    double margin = cost > 0 ? (((price - cost) / cost) * 100) : 30.0;
    double stock = productToEdit?.stockQuantity ?? 25.0;
    double minAlert = productToEdit?.minStockAlert ?? 5.0;

    final costCtrl = TextEditingController(text: cost.toStringAsFixed(2));
    final marginCtrl = TextEditingController(text: margin.toStringAsFixed(1));
    final priceCtrl = TextEditingController(text: price.toStringAsFixed(2));
    final stockCtrl = TextEditingController(text: stock.toString());
    final minAlertCtrl = TextEditingController(text: minAlert.toString());

    // Presentaciones dinámicas
    final presentations = <ProductPresentationModel>[...(productToEdit?.presentations ?? [])];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          void updateFromCostOrMargin() {
            final c = double.tryParse(costCtrl.text) ?? 0.0;
            final m = double.tryParse(marginCtrl.text) ?? 0.0;
            cost = c;
            margin = m;
            price = c * (1.0 + (m / 100.0));
            priceCtrl.text = price.toStringAsFixed(2);
          }

          void updateFromPrice() {
            final p = double.tryParse(priceCtrl.text) ?? 0.0;
            final c = double.tryParse(costCtrl.text) ?? 0.0;
            price = p;
            cost = c;
            if (c > 0) {
              margin = ((p - c) / c) * 100.0;
              marginCtrl.text = margin.toStringAsFixed(1);
            }
          }

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Container(
              width: 620,
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productToEdit == null ? 'Nuevo Producto al Catálogo' : 'Editar Producto',
                          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Tipo de Producto
                    Text('Tipo de Producto:', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildTypeRadio(ProductType.unit, 'Unidad / Cajas', selectedType, (t) => setModalState(() => selectedType = t)),
                        const SizedBox(width: 8),
                        _buildTypeRadio(ProductType.weightFraction, 'Pesable (Kg)', selectedType, (t) => setModalState(() => selectedType = t)),
                        const SizedBox(width: 8),
                        _buildTypeRadio(ProductType.variant, 'Con Variantes', selectedType, (t) => setModalState(() => selectedType = t)),
                        const SizedBox(width: 8),
                        _buildTypeRadio(ProductType.combo, 'Combo / Kit', selectedType, (t) => setModalState(() => selectedType = t)),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Nombre y Categoría
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(labelText: 'Nombre del Producto *', hintText: 'Ej. Galletas María Puig 150g'),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: categoryId,
                            decoration: const InputDecoration(labelText: 'Categoría'),
                            items: const [
                              DropdownMenuItem(value: 'viveres', child: Text('Víveres y Granos')),
                              DropdownMenuItem(value: 'bebidas', child: Text('Bebidas y Refrescos')),
                              DropdownMenuItem(value: 'charcuteria', child: Text('Charcutería y Carnes')),
                              DropdownMenuItem(value: 'snacks', child: Text('Snacks y Ropa')),
                              DropdownMenuItem(value: 'limpieza', child: Text('Limpieza y Hogar')),
                            ],
                            onChanged: (val) => setModalState(() => categoryId = val ?? 'viveres'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: skuCtrl,
                            decoration: const InputDecoration(labelText: 'SKU / Código Interno'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Código de Barras con botón Aleatorio
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: barcodeCtrl,
                            decoration: const InputDecoration(labelText: 'Código de Barras (EAN/UPC)'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          icon: const Icon(Icons.casino_outlined),
                          tooltip: 'Generar código aleatorio',
                          onPressed: () => setModalState(() {
                            barcodeCtrl.text = '759${Random().nextInt(899999999) + 100000000}';
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // CALCULADORA DE RENTABILIDAD
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Calculadora de Rentabilidad Bimoneda', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 13, color: primaryColor)),
                              Text('Tasa: ${rate.toStringAsFixed(2)} Bs/\$', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: costCtrl,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  onChanged: (_) => setModalState(updateFromCostOrMargin),
                                  decoration: const InputDecoration(
                                    labelText: 'Costo Compra (\$)',
                                    prefixText: '\$ ',
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: marginCtrl,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  onChanged: (_) => setModalState(updateFromCostOrMargin),
                                  decoration: const InputDecoration(
                                    labelText: 'Margen (%)',
                                    suffixText: '%',
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: priceCtrl,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  onChanged: (_) => setModalState(updateFromPrice),
                                  decoration: InputDecoration(
                                    labelText: 'Precio Final (\$)',
                                    prefixText: '\$ ',
                                    helperText: '≈ Bs. ${(price * rate).toStringAsFixed(2)}',
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Stock inicial y alerta mínima
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: stockCtrl,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: selectedType == ProductType.weightFraction ? 'Stock Inicial (Kg)' : 'Stock Inicial (Unidades)',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: minAlertCtrl,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Alerta Stock Mínimo',
                              helperText: 'Notifica en amarillo si baja',
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Si es Unidad, permitir agregar Presentaciones (Cajas/Bultos)
                    if (selectedType == ProductType.unit) ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Presentaciones / Cajas / Bultos:', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
                          TextButton.icon(
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text('Agregar Caja/Pack'),
                            onPressed: () {
                              setModalState(() {
                                presentations.add(
                                  ProductPresentationModel(
                                    id: 'pres_${Random().nextInt(99999)}',
                                    productId: productToEdit?.id ?? '',
                                    name: 'Caja x 24 Unidades',
                                    quantityEquivalent: 24.0,
                                    priceUsd: (price * 24.0 * 0.90), // 10% descuento mayorista
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                      ...presentations.map((pres) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
                          child: Row(
                            children: [
                              const Icon(Icons.inventory_2_outlined, size: 16, color: AppColors.accent),
                              const SizedBox(width: 8),
                              Expanded(child: Text('${pres.name} (Factor: ${pres.quantityEquivalent.toInt()}u) • \$${pres.priceUsd.toStringAsFixed(2)}')),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                                onPressed: () => setModalState(() => presentations.remove(pres)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],

                    const SizedBox(height: 24),

                    // Botones Cancelar y Guardar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
                          onPressed: () {
                            if (nameCtrl.text.trim().isEmpty) return;
                            final initialStockVal = double.tryParse(stockCtrl.text) ?? 0.0;
                            final minAlertVal = double.tryParse(minAlertCtrl.text) ?? 5.0;

                            if (productToEdit == null) {
                              ref.read(inventoryProvider.notifier).createProduct(
                                    name: nameCtrl.text.trim(),
                                    categoryId: categoryId,
                                    sku: skuCtrl.text.trim(),
                                    barcode: barcodeCtrl.text.trim().isNotEmpty ? barcodeCtrl.text.trim() : null,
                                    type: selectedType,
                                    priceUsd: price,
                                    costUsd: cost,
                                    initialStock: initialStockVal,
                                    minStockAlert: minAlertVal,
                                    presentations: presentations,
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Producto creado: ${nameCtrl.text.trim()} (\$${price.toStringAsFixed(2)})'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            } else {
                              final updated = ProductModel(
                                id: productToEdit.id,
                                name: nameCtrl.text.trim(),
                                categoryId: categoryId,
                                sku: skuCtrl.text.trim(),
                                barcode: barcodeCtrl.text.trim().isNotEmpty ? barcodeCtrl.text.trim() : null,
                                type: selectedType,
                                priceUsd: price,
                                costUsd: cost,
                                stockQuantity: initialStockVal,
                                minStockAlert: minAlertVal,
                                presentations: presentations,
                              );
                              ref.read(posProvider.notifier).updateProduct(updated);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Producto actualizado: ${updated.name}'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }

                            Navigator.pop(ctx);
                          },
                          child: Text(productToEdit == null ? 'Guardar Producto' : 'Guardar Cambios'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeRadio(ProductType type, String label, ProductType current, Function(ProductType) onSelect) {
    final isSelected = type == current;
    return InkWell(
      onTap: () => onSelect(type),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? AppColors.accent : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? AppColors.accent : AppColors.textPrimary),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 5. MODAL CARGAR COMPRA / ENTRADA DE MERCANCÍA
  // --------------------------------------------------------------------------
  void _showPurchaseModal(BuildContext context, List<ProductModel> catalog) async {
    final authState = ref.read(authProvider);
    if (authState.currentUser.isCashier) {
      final authorized = await PinAuthModal.requestSupervisorAuth(
        context,
        actionName: 'Recepción de Mercancía / Entrada a Stock',
      );
      if (!authorized) return;
    }
    if (!context.mounted) return;

    ProductModel selectedProduct = catalog.first;
    ProductPresentationModel? selectedPresentation;
    final qtyCtrl = TextEditingController(text: '10');
    final costCtrl = TextEditingController(text: selectedProduct.costUsd.toStringAsFixed(2));
    final notesCtrl = TextEditingController(text: 'Recepción de proveedor');

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('📦 Cargar Compra de Mercancía', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800)),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Selector de Producto
                  DropdownButtonFormField<ProductModel>(
                    value: selectedProduct,
                    decoration: const InputDecoration(labelText: 'Producto'),
                    items: catalog.map((p) => DropdownMenuItem(value: p, child: Text(p.name, overflow: TextOverflow.ellipsis))).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() {
                          selectedProduct = val;
                          selectedPresentation = null;
                          costCtrl.text = val.costUsd.toStringAsFixed(2);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  // Si tiene presentaciones (Cajas)
                  if (selectedProduct.presentations.isNotEmpty) ...[
                    DropdownButtonFormField<ProductPresentationModel?>(
                      value: selectedPresentation,
                      decoration: const InputDecoration(labelText: 'Modalidad de Entrada'),
                      items: [
                        const DropdownMenuItem(value: null, child: Text('Unidades Sueltas')),
                        ...selectedProduct.presentations.map((pres) => DropdownMenuItem(value: pres, child: Text('${pres.name} (Factor: ${pres.quantityEquivalent.toInt()}u)'))),
                      ],
                      onChanged: (val) => setDialogState(() => selectedPresentation = val),
                    ),
                    const SizedBox(height: 12),
                  ],

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: qtyCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: selectedPresentation != null ? 'Cantidad de Cajas' : 'Cantidad Unidades',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: costCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Costo Unitario (\$ USD)',
                            prefixText: '\$ ',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: notesCtrl,
                    decoration: const InputDecoration(labelText: 'Nota o N° Factura Proveedor'),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.success, foregroundColor: Colors.white),
                        onPressed: () {
                          final qty = double.tryParse(qtyCtrl.text) ?? 0.0;
                          final costVal = double.tryParse(costCtrl.text) ?? 0.0;
                          if (qty <= 0) return;

                          ref.read(inventoryProvider.notifier).recordPurchase(
                                product: selectedProduct,
                                quantityUnits: qty,
                                newUnitCostUsd: costVal,
                                presentation: selectedPresentation,
                                notes: notesCtrl.text.trim(),
                              );

                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Compra registrada: +$qty para ${selectedProduct.name}'),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        },
                        child: const Text('Confirmar Entrada'),
                      ),
                    ],
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
  // 6. MODAL AJUSTE DE STOCK (Merma / Conteo / Pérdida)
  // --------------------------------------------------------------------------
  void _showAdjustmentModal(BuildContext context, ProductModel product) async {
    final authState = ref.read(authProvider);
    if (authState.currentUser.isCashier) {
      final authorized = await PinAuthModal.requestSupervisorAuth(
        context,
        actionName: 'Ajuste Manual de Inventario / Merma',
      );
      if (!authorized) return;
    }
    if (!context.mounted) return;

    String type = 'waste'; // 'waste' = merma/pérdida, 'adjustment' = ajuste conteo
    double delta = -1.0;
    final qtyCtrl = TextEditingController(text: '1.0');
    final reasonCtrl = TextEditingController(text: 'Empaque roto / Merma');
    final primaryColor = ref.read(primaryColorProvider);

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
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
                      Text('⚖️ Ajuste de Stock: ${product.name}', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800)),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text('🔴 Merma / Pérdida')),
                          selected: type == 'waste',
                          selectedColor: const Color(0xFFFEE2E2),
                          labelStyle: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.bold),
                          onSelected: (_) => setDialogState(() {
                            type = 'waste';
                            reasonCtrl.text = 'Empaque roto / Vencimiento';
                          }),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text('🔵 Ajuste Conteo (+/-)')),
                          selected: type == 'adjustment',
                          selectedColor: const Color(0xFFEFF6FF),
                          labelStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                          onSelected: (_) => setDialogState(() {
                            type = 'adjustment';
                            reasonCtrl.text = 'Diferencia de conteo físico';
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  TextField(
                    controller: qtyCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: type == 'waste' ? 'Cantidad a Descontar (Merma)' : 'Cantidad (+ / -)',
                      prefixText: type == 'waste' ? '- ' : '',
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: reasonCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Motivo Obligatorio del Ajuste *',
                      hintText: 'Ej. Daño físico, vencimiento, auditoría',
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: type == 'waste' ? AppColors.danger : primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          final val = double.tryParse(qtyCtrl.text) ?? 0.0;
                          if (val <= 0 || reasonCtrl.text.trim().isEmpty) return;
                          delta = type == 'waste' ? -val : val;

                          ref.read(inventoryProvider.notifier).recordAdjustment(
                                product: product,
                                deltaUnits: delta,
                                reasonType: type,
                                notes: reasonCtrl.text.trim(),
                              );

                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Ajuste registrado: $delta para ${product.name}'),
                              backgroundColor: type == 'waste' ? AppColors.danger : AppColors.success,
                            ),
                          );
                        },
                        child: const Text('Aplicar Ajuste'),
                      ),
                    ],
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
  // 7. MODAL VISUALIZACIÓN DEL KARDEX AUDITABLE
  // --------------------------------------------------------------------------
  void _showKardexModal(BuildContext context) {
    final movements = ref.read(inventoryProvider).movements;
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          width: 780,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.assignment, color: AppColors.accent, size: 24),
                      const SizedBox(width: 10),
                      Text('Kardex de Movimientos de Inventario', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800)),
                    ],
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
              const SizedBox(height: 6),
              Text('Historial auditable de compras, ventas, devoluciones y mermas en tiempo real', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 16),

              Container(
                constraints: const BoxConstraints(maxHeight: 460),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: movements.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border),
                  itemBuilder: (context, idx) {
                    final m = movements[idx];
                    final isPos = m.isPositive;

                    return Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isPos ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              isPos ? Icons.arrow_downward : Icons.arrow_upward,
                              size: 18,
                              color: isPos ? AppColors.success : AppColors.danger,
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(m.productName, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
                                const SizedBox(height: 2),
                                Text(
                                  '${dateFormat.format(m.createdAt)} • ${m.userName}',
                                  style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(m.typeLabel, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold)),
                                ),
                                if (m.notes != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(m.notes!, style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
                                  ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${isPos ? "+" : ""}${m.quantity.toStringAsFixed(1)}',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: isPos ? AppColors.success : AppColors.danger,
                                ),
                              ),
                              Text(
                                '${m.previousStock.toStringAsFixed(1)} -> ${m.newStock.toStringAsFixed(1)}',
                                style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cerrar Kardex'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
