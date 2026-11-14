import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/database/sync_service.dart';
import '../domain/models/pos_models.dart';
import 'controllers/pos_controller.dart';
import 'widgets/presentation_weight_modal.dart';
import 'widgets/customer_selector_modal.dart';
import 'widgets/discount_modal.dart';
import 'widgets/held_bills_modal.dart';
import 'widgets/checkout_modal.dart';
import '../../cash_session/presentation/views/cash_session_view.dart';
import '../../sales/presentation/views/sales_history_view.dart';
import '../../customers/presentation/views/customers_view.dart';
import '../../inventory/presentation/views/inventory_view.dart';
import '../../dashboard/presentation/views/dashboard_view.dart';
import '../../settings/presentation/views/settings_view.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
import '../../auth/presentation/widgets/pin_auth_modal.dart';
import 'widgets/remote_scanner_modal.dart';
import 'widgets/thermal_ticket_modal.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'all');
final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedNavTabProvider = StateProvider<String>((ref) => 'pos'); // 'pos', 'cash', 'sales', 'customers', 'inventory', 'dashboard', 'settings'

class MainLayoutShell extends ConsumerStatefulWidget {
  const MainLayoutShell({super.key});

  @override
  ConsumerState<MainLayoutShell> createState() => _MainLayoutShellState();
}

class _MainLayoutShellState extends ConsumerState<MainLayoutShell> {
  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  final List<Map<String, dynamic>> _categories = [
    {'id': 'all', 'name': 'Todos', 'icon': Icons.apps, 'color': Color(0xFF1E40AF)},
    {'id': 'viveres', 'name': 'Víveres y Granos', 'icon': Icons.inventory_2, 'color': Color(0xFFF59E0B)},
    {'id': 'bebidas', 'name': 'Bebidas y Refrescos', 'icon': Icons.local_drink, 'color': Color(0xFF0EA5E9)},
    {'id': 'charcuteria', 'name': 'Charcutería y Carnes', 'icon': Icons.scale, 'color': Color(0xFFEF4444)},
    {'id': 'snacks', 'name': 'Snacks y Ropa', 'icon': Icons.checkroom, 'color': Color(0xFF8B5CF6)},
    {'id': 'limpieza', 'name': 'Limpieza y Hogar', 'icon': Icons.cleaning_services, 'color': Color(0xFF10B981)},
  ];

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    _searchCtrl.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.f2) {
      _searchFocusNode.requestFocus();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final posState = ref.watch(posProvider);
    final primaryColor = ref.watch(primaryColorProvider);
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. HEADER GLOBAL OMNIPRESENTE
            _buildGlobalHeader(context, posState, primaryColor),

            // 2. CUERPO RESPONSIVO (3 Columnas PC vs Móvil)
            Expanded(
              child: isDesktop
                  ? _buildDesktopLayout(context, posState, primaryColor)
                  : _buildMobileLayout(context, posState, primaryColor),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isDesktop ? null : _buildMobileFloatingDock(context, posState, primaryColor),
    );
  }

  // --------------------------------------------------------------------------
  // 1. HEADER GLOBAL
  // --------------------------------------------------------------------------
  Widget _buildGlobalHeader(BuildContext context, PosState posState, Color primaryColor) {
    final syncState = ref.watch(syncProvider);
    final authState = ref.watch(authProvider);

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          // Logo e Identidad
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.point_of_sale, color: Colors.white, size: 22),
                const SizedBox(width: 8),
                Text(
                  'AZULITO POS',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Buscador Universal con soporte de pistola lectora USB
          Expanded(
            child: SizedBox(
              height: 46,
              child: TextField(
                controller: _searchCtrl,
                focusNode: _searchFocusNode,
                onChanged: (val) => ref.read(searchQueryProvider.notifier).state = val,
                onSubmitted: (val) => _handleBarcodeSubmit(val, posState),
                decoration: InputDecoration(
                  hintText: 'Buscar producto o escanear código USB / Remoto (F2)...',
                  hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.phonelink_ring, color: AppColors.accent, size: 20),
                        onPressed: () => RemoteScannerModal.show(context),
                        tooltip: '📱 Abrir Escáner Remoto Teléfono-a-PC',
                      ),
                      IconButton(
                        icon: const Icon(Icons.flash_on, color: AppColors.warning, size: 20),
                        onPressed: () => _handleBarcodeSubmit('759108868510', posState),
                        tooltip: '⚡ Simular Pistola USB (759108868510)',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Píldora Interactiva de Tasa del Día
          InkWell(
            onTap: () => _showRateDialog(context, posState),
            borderRadius: BorderRadius.circular(9999),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: AppColors.accent.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Text('💵', style: TextStyle(fontSize: 15)),
                  const SizedBox(width: 6),
                  Text(
                    'Tasa: ${posState.exchangeRate.toStringAsFixed(2)} Bs/\$',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.accent),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Selector de Usuario Activo y Roles con PIN
          InkWell(
            onTap: () => PinAuthModal.showUserSwitcher(context),
            borderRadius: BorderRadius.circular(9999),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: authState.currentUser.isAdmin
                    ? primaryColor.withOpacity(0.10)
                    : AppColors.accent.withOpacity(0.10),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: authState.currentUser.isAdmin
                      ? primaryColor.withOpacity(0.5)
                      : AppColors.accent.withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    authState.currentUser.isAdmin ? Icons.shield : Icons.badge_outlined,
                    size: 16,
                    color: authState.currentUser.isAdmin ? primaryColor : AppColors.accent,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    authState.currentUser.fullName,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: authState.currentUser.isAdmin ? primaryColor : AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down, size: 16, color: AppColors.textSecondary),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Badge de Cuentas en Espera (si existen)
          if (posState.heldBills.isNotEmpty)
            InkWell(
              onTap: () => HeldBillsModal.show(context),
              borderRadius: BorderRadius.circular(9999),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.amber),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.pause_circle_filled, size: 18, color: Colors.amber),
                    const SizedBox(width: 6),
                    Text(
                      '${posState.heldBills.length} Pausadas',
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(width: 10),

          // Badge de Estado Online / Offline Interactivo (Simulador de Apagón)
          InkWell(
            onTap: () {
              ref.read(syncProvider.notifier).toggleOfflineSimulation();
              final isOnlineNow = !syncState.isOfflineSimulated;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isOnlineNow
                        ? 'Simulando corte de conexión: Modo Offline Activado.'
                        : 'Reconexión establecida: Sincronizando operaciones con Supabase.',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            borderRadius: BorderRadius.circular(9999),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: syncState.isOnline ? const Color(0xFFECFDF5) : const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: syncState.isOnline ? AppColors.success.withOpacity(0.3) : Colors.amber.withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: syncState.isOnline ? AppColors.success : Colors.amber.shade700,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    syncState.statusBadgeLabel,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: syncState.isOnline ? const Color(0xFF065F46) : Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 2. LAYOUT DESKTOP MULTI-MÓDULO (>= 900px)
  // --------------------------------------------------------------------------
  Widget _buildDesktopLayout(BuildContext context, PosState posState, Color primaryColor) {
    final navTab = ref.watch(selectedNavTabProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Columna 1: Barra Lateral con Módulos y Categorías (~220px)
        SizedBox(
          width: 220,
          child: _buildNavigationAndCategorySidebar(primaryColor),
        ),

        // Cuerpo Principal según Módulo
        Expanded(
          child: navTab == 'pos'
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Grilla Central de Productos (Flexible)
                    Expanded(
                      child: _buildProductGrid(context, posState, primaryColor),
                    ),
                    // Order Details / Carrito (~410px)
                    SizedBox(
                      width: 410,
                      child: _buildOrderDetailsPanel(context, posState, primaryColor),
                    ),
                  ],
                )
              : (navTab == 'cash'
                  ? const CashSessionView()
                  : (navTab == 'sales'
                      ? const SalesHistoryView()
                      : (navTab == 'customers'
                          ? const CustomersView()
                          : (navTab == 'inventory'
                              ? const InventoryView()
                              : (navTab == 'dashboard'
                                  ? const DashboardView()
                                  : const SettingsView()))))),
        ),
      ],
    );
  }

  Widget _buildNavigationAndCategorySidebar(Color primaryColor) {
    final navTab = ref.watch(selectedNavTabProvider);
    final selectedCat = ref.watch(selectedCategoryProvider);

    final modules = [
      {'id': 'pos', 'name': 'POS / Ventas', 'icon': Icons.point_of_sale},
      {'id': 'cash', 'name': 'Caja y Turnos', 'icon': Icons.account_balance_wallet},
      {'id': 'sales', 'name': 'Historial Ventas', 'icon': Icons.receipt_long},
      {'id': 'customers', 'name': 'Clientes y CxC', 'icon': Icons.people},
      {'id': 'inventory', 'name': 'Inventario y Kardex', 'icon': Icons.inventory_2_outlined},
      {'id': 'dashboard', 'name': 'Dashboard Ejecutivo', 'icon': Icons.insights},
      {'id': 'settings', 'name': 'Ajustes y Tienda', 'icon': Icons.settings_outlined},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        children: [
          // Sección Módulos Principales
          Text(
            'MÓDULOS',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          ...modules.map((m) {
            final isSelected = navTab == m['id'];
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: InkWell(
                onTap: () => ref.read(selectedNavTabProvider.notifier).state = m['id'] as String,
                borderRadius: BorderRadius.circular(14),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        m['icon'] as IconData,
                        size: 20,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          m['name'] as String,
                          style: GoogleFonts.inter(
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            fontSize: 13,
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Si estamos en POS, mostramos el filtro de Categorías debajo
          if (navTab == 'pos') ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 14),
            Text(
              'CATEGORÍAS',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.textSecondary,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            ..._categories.map((cat) {
              final isCatSelected = selectedCat == cat['id'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: InkWell(
                  onTap: () => ref.read(selectedCategoryProvider.notifier).state = cat['id'],
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isCatSelected ? primaryColor.withOpacity(0.12) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          cat['icon'] as IconData,
                          size: 18,
                          color: isCatSelected ? primaryColor : (cat['color'] as Color),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            cat['name'] as String,
                            style: GoogleFonts.inter(
                              fontWeight: isCatSelected ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 13,
                              color: isCatSelected ? primaryColor : AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // COLUMNA 2: CUADRÍCULA DE PRODUCTOS
  // --------------------------------------------------------------------------
  Widget _buildProductGrid(BuildContext context, PosState posState, Color primaryColor) {
    final selectedCat = ref.watch(selectedCategoryProvider);
    final search = ref.watch(searchQueryProvider).toLowerCase().trim();

    final filtered = posState.catalog.where((p) {
      final matchesCat = selectedCat == 'all' || p.categoryId == selectedCat;
      final matchesSearch = search.isEmpty ||
          p.name.toLowerCase().contains(search) ||
          (p.barcode != null && p.barcode!.contains(search));
      return matchesCat && matchesSearch;
    }).toList();

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisExtent: 245,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final prod = filtered[index];
          return _buildProductCard(context, prod, posState, primaryColor);
        },
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductModel prod,
    PosState posState,
    Color primaryColor,
  ) {
    final rate = posState.exchangeRate;
    final priceUsd = prod.priceUsd;
    final priceBs = priceUsd * rate;
    final availableStock = posState.stockMap[prod.id] ?? 0.0;
    final isLowStock = availableStock <= prod.minStockAlert;
    final isOutOfStock = availableStock <= 0.0;

    return InkWell(
      onTap: isOutOfStock
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('¡Producto sin stock! ${prod.name} agotado.'),
                  backgroundColor: AppColors.danger,
                ),
              );
            }
          : () {
              // Si el producto tiene presentaciones, variantes o es pesable -> abre modal
              if (prod.hasPresentations || prod.hasVariants || prod.isWeightFraction) {
                PresentationWeightModal.show(context, prod);
              } else {
                // Producto simple: 1 clic directo con validación de stock atómico
                final success = ref.read(posProvider.notifier).addToCart(product: prod, quantity: 1);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Agregado: ${prod.name} (\$${prod.priceUsd.toStringAsFixed(2)})'),
                      backgroundColor: AppColors.success,
                      duration: const Duration(milliseconds: 1200),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No hay más stock disponible para ${prod.name}.'),
                      backgroundColor: AppColors.danger,
                    ),
                  );
                }
              }
            },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isOutOfStock ? const Color(0xFFF8FAFC) : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isOutOfStock ? AppColors.border : AppColors.border,
            width: 1,
          ),
          boxShadow: isOutOfStock ? null : AppTheme.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge Stock Disponible
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isOutOfStock
                        ? const Color(0xFFFEE2E2)
                        : isLowStock
                            ? const Color(0xFFFEF3C7)
                            : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    isOutOfStock
                        ? 'Agotado'
                        : isLowStock
                            ? '¡Quedan ${availableStock.toInt()}!'
                            : 'Disp: ${prod.isWeightFraction ? "${availableStock.toStringAsFixed(1)}kg" : availableStock.toInt()}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isOutOfStock
                          ? AppColors.danger
                          : isLowStock
                              ? const Color(0xFFB45309)
                              : AppColors.textSecondary,
                    ),
                  ),
                ),
                if (prod.hasPresentations)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('Cajas/Pack',
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.accent)),
                  )
                else if (prod.isWeightFraction)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('Pesable',
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.purple)),
                  ),
              ],
            ),
            const Spacer(),

            // Avatar Central con Iniciales Limpias
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(isOutOfStock ? 0.05 : 0.15),
                      AppColors.accent.withOpacity(isOutOfStock ? 0.05 : 0.15),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    prod.name.substring(0, 2).toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isOutOfStock ? AppColors.textSecondary : primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),

            // Nombre
            Text(
              prod.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: isOutOfStock ? AppColors.textSecondary : AppColors.textPrimary,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),

            // Precios Duales (USD en grande, Bs suave)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '\$${priceUsd.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: isOutOfStock ? AppColors.textSecondary : primaryColor,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Bs. ${priceBs.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // COLUMNA 3: ORDER DETAILS (CARRITO Y CHECKOUT)
  // --------------------------------------------------------------------------
  Widget _buildOrderDetailsPanel(BuildContext context, PosState posState, Color primaryColor) {
    final rate = posState.exchangeRate;
    final cart = posState.cart;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(left: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        children: [
          // Header de la Orden y Acciones Rápidas
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Detalle de Orden',
                          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                        if (posState.customer != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              posState.customer!.fullName.split(' ')[0],
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: primaryColor),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (cart.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.delete_sweep_outlined, color: AppColors.danger, size: 22),
                        onPressed: () => ref.read(posProvider.notifier).clearCart(),
                        tooltip: 'Vaciar Carrito',
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Barra de Acciones Rápidas 100% Funcionales
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickActionButton(
                        icon: Icons.person_add_alt_1,
                        label: posState.customer != null ? 'Cliente ✓' : 'Cliente',
                        isSelected: posState.customer != null,
                        primaryColor: primaryColor,
                        onTap: () => CustomerSelectorModal.show(context),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _buildQuickActionButton(
                        icon: Icons.percent,
                        label: posState.calculatedDiscountUsd > 0
                            ? '-\$${posState.calculatedDiscountUsd.toStringAsFixed(1)}'
                            : 'Desc.',
                        isSelected: posState.calculatedDiscountUsd > 0,
                        primaryColor: primaryColor,
                        onTap: () => DiscountModal.show(context),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _buildQuickActionButton(
                        icon: Icons.pause_circle_outline,
                        label: posState.heldBills.isNotEmpty ? '(${posState.heldBills.length})' : 'Pausar',
                        isSelected: posState.heldBills.isNotEmpty,
                        primaryColor: primaryColor,
                        onTap: () => HeldBillsModal.show(context),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _buildQuickActionButton(
                        icon: Icons.phonelink_ring,
                        label: 'Escáner',
                        isSelected: false,
                        primaryColor: primaryColor,
                        onTap: () => RemoteScannerModal.show(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),

          // Lista de Ítems en el Carrito con Stepper Reactivo
          Expanded(
            child: cart.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 48, color: AppColors.textSecondary.withOpacity(0.5)),
                        const SizedBox(height: 12),
                        Text('El carrito está vacío',
                            style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
                        const SizedBox(height: 4),
                        Text('Toca un producto para agregar', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      final itemBs = item.subtotalUsd * rate;

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textPrimary),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '\$${item.unitPriceUsd.toStringAsFixed(2)} / ${item.unitLabel}',
                                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                            // Stepper - 1 + con validación atómica
                            Row(
                              children: [
                                _buildStepperBtn(
                                  icon: Icons.remove,
                                  onTap: () => ref.read(posProvider.notifier).updateQuantity(item.id, -1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    item.isWeight ? '${item.quantity.toStringAsFixed(3)} kg' : item.quantity.toInt().toString(),
                                    style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                ),
                                _buildStepperBtn(
                                  icon: Icons.add,
                                  onTap: () {
                                    final ok = ref.read(posProvider.notifier).updateQuantity(item.id, 1);
                                    if (!ok) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('No puedes agregar más: límite de stock alcanzado.'),
                                          backgroundColor: AppColors.danger,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            // Subtotales
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${item.subtotalUsd.toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14, color: primaryColor),
                                ),
                                Text(
                                  'Bs. ${itemBs.toStringAsFixed(2)}',
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

          // Bloque de Cierre, IGTF y Totales
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border, width: 1)),
            ),
            child: Column(
              children: [
                // Switch IGTF
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('IGTF (3% en Divisas)',
                            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        const SizedBox(width: 4),
                        const Tooltip(
                          message: 'Se calcula en checkout únicamente sobre pagos en efectivo USD y Zelle',
                          child: Icon(Icons.info_outline, size: 16, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    Switch.adaptive(
                      value: posState.igtfEnabled,
                      activeColor: primaryColor,
                      onChanged: (val) => ref.read(posProvider.notifier).setIgtfEnabled(val),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Subtotal y Descuentos
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal:', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                    Text('\$${posState.rawSubtotalUsd.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
                if (posState.calculatedDiscountUsd > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Descuento aplicado:', style: GoogleFonts.inter(fontSize: 13, color: AppColors.danger)),
                      Text('-\$${posState.calculatedDiscountUsd.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.danger)),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 12),

                // Totales
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total a Pagar', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                        Text(
                          '\$${posState.totalWithEstimatedIgtfUsd.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w900, color: primaryColor, letterSpacing: -0.5),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('En Bolívares (VES)', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                        Text(
                          'Bs. ${posState.totalBs.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Botón Cobrar + Ticket Térmico
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: cart.isEmpty ? null : () => CheckoutModal.show(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            disabledBackgroundColor: AppColors.border,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle_outline, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'COBRAR  \$${posState.totalWithEstimatedIgtfUsd.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: OutlinedButton(
                        onPressed: () => ThermalTicketModal.show(context, isTest: true),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryColor,
                          side: BorderSide(color: primaryColor.withOpacity(0.5)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.print_outlined, size: 22),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // LAYOUT MÓVIL (< 900px)
  // --------------------------------------------------------------------------
  Widget _buildMobileLayout(BuildContext context, PosState posState, Color primaryColor) {
    final navTab = ref.watch(selectedNavTabProvider);
    if (navTab == 'cash') {
      return const CashSessionView();
    } else if (navTab == 'sales') {
      return const SalesHistoryView();
    } else if (navTab == 'customers') {
      return const CustomersView();
    } else if (navTab == 'inventory') {
      return const InventoryView();
    } else if (navTab == 'dashboard') {
      return const DashboardView();
    } else if (navTab == 'settings') {
      return const SettingsView();
    }

    return Column(
      children: [
        SizedBox(
          height: 48,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = ref.watch(selectedCategoryProvider) == cat['id'];
              return ChoiceChip(
                label: Text(cat['name'] as String),
                selected: isSelected,
                selectedColor: primaryColor,
                labelStyle: GoogleFonts.inter(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 12,
                ),
                onSelected: (_) => ref.read(selectedCategoryProvider.notifier).state = cat['id'],
              );
            },
          ),
        ),
        Expanded(
          child: _buildProductGrid(context, posState, primaryColor),
        ),
      ],
    );
  }

  Widget _buildMobileFloatingDock(BuildContext context, PosState posState, Color primaryColor) {
    final navTab = ref.watch(selectedNavTabProvider);
    final cart = posState.cart;

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.point_of_sale, color: navTab == 'pos' ? primaryColor : AppColors.textSecondary),
              tooltip: 'POS / Ventas',
              onPressed: () => ref.read(selectedNavTabProvider.notifier).state = 'pos',
            ),
            IconButton(
              icon: Icon(Icons.account_balance_wallet, color: navTab == 'cash' ? primaryColor : AppColors.textSecondary),
              tooltip: 'Caja y Turnos',
              onPressed: () => ref.read(selectedNavTabProvider.notifier).state = 'cash',
            ),
            IconButton(
              icon: Icon(Icons.receipt_long, color: navTab == 'sales' ? primaryColor : AppColors.textSecondary),
              tooltip: 'Historial',
              onPressed: () => ref.read(selectedNavTabProvider.notifier).state = 'sales',
            ),
            IconButton(
              icon: Icon(Icons.people, color: navTab == 'customers' ? primaryColor : AppColors.textSecondary),
              tooltip: 'Clientes y CxC',
              onPressed: () => ref.read(selectedNavTabProvider.notifier).state = 'customers',
            ),
            IconButton(
              icon: Icon(Icons.inventory_2_outlined, color: navTab == 'inventory' ? primaryColor : AppColors.textSecondary),
              tooltip: 'Inventario',
              onPressed: () => ref.read(selectedNavTabProvider.notifier).state = 'inventory',
            ),
            IconButton(
              icon: Icon(Icons.insights, color: navTab == 'dashboard' ? primaryColor : AppColors.textSecondary),
              tooltip: 'Dashboard',
              onPressed: () => ref.read(selectedNavTabProvider.notifier).state = 'dashboard',
            ),
            IconButton(
              icon: Icon(Icons.settings_outlined, color: navTab == 'settings' ? primaryColor : AppColors.textSecondary),
              tooltip: 'Ajustes',
              onPressed: () => ref.read(selectedNavTabProvider.notifier).state = 'settings',
            ),
            // Carrito Flotante con Badge y apertura de Checkout
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.textSecondary),
                  onPressed: cart.isEmpty ? null : () => CheckoutModal.show(context),
                ),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                      child: Text(
                        cart.length.toString(),
                        style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // DIÁLOGOS AUXILIARES
  // --------------------------------------------------------------------------
  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isSelected = false,
    required Color primaryColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.12) : AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? primaryColor : AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: isSelected ? primaryColor : AppColors.textPrimary),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? primaryColor : AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperBtn({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 16, color: AppColors.textPrimary),
      ),
    );
  }

  void _handleBarcodeSubmit(String rawBarcode, PosState posState) {
    final query = rawBarcode.trim();
    if (query.isEmpty) return;

    // Buscar si coincide con el código de barras o SKU del catálogo
    final product = posState.catalog.firstWhere(
      (p) => (p.barcode != null && p.barcode == query) || (p.sku != null && p.sku!.toLowerCase() == query.toLowerCase()),
      orElse: () => posState.catalog.firstWhere(
        (p) => p.name.toLowerCase().contains(query.toLowerCase()),
        orElse: () => posState.catalog.first,
      ),
    );

    ref.read(posProvider.notifier).addToCart(product: product);
    _searchCtrl.clear();
    ref.read(searchQueryProvider.notifier).state = '';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text('¡Pistola USB: +1 ${product.name} agregado al carrito!'),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showRateDialog(BuildContext context, PosState posState) async {
    final authState = ref.read(authProvider);
    if (authState.currentUser.isCashier) {
      final authorized = await PinAuthModal.requestSupervisorAuth(
        context,
        actionName: 'Modificar Tasa de Cambio Oficial',
      );
      if (!authorized) return;
    }

    if (!context.mounted) return;

    final customCtrl = TextEditingController(text: posState.exchangeRate.toStringAsFixed(2));

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Actualizar Tasa del Día', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Tasa Oficial BCV'),
              subtitle: const Text('45.50 Bs/\$'),
              leading: const Icon(Icons.account_balance, color: AppColors.accent),
              onTap: () {
                ref.read(posProvider.notifier).updateExchangeRate(45.50);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tasa actualizada a 45.50 Bs/\$ (BCV)')),
                );
              },
            ),
            ListTile(
              title: const Text('Tasa Monitor Paralelo'),
              subtitle: const Text('52.10 Bs/\$'),
              leading: const Icon(Icons.trending_up, color: AppColors.warning),
              onTap: () {
                ref.read(posProvider.notifier).updateExchangeRate(52.10);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tasa actualizada a 52.10 Bs/\$ (Paralelo)')),
                );
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: customCtrl,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Tasa Manual (Bs/\$)'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final val = double.tryParse(customCtrl.text);
                      if (val != null && val > 0) {
                        ref.read(posProvider.notifier).updateExchangeRate(val);
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tasa manual fijada en ${val.toStringAsFixed(2)} Bs/\$')),
                        );
                      }
                    },
                    child: const Text('Fijar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
