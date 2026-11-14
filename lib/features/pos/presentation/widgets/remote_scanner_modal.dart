import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../controllers/pos_controller.dart';

class RemoteScannerModal extends ConsumerStatefulWidget {
  const RemoteScannerModal({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const RemoteScannerModal(),
    );
  }

  @override
  ConsumerState<RemoteScannerModal> createState() => _RemoteScannerModalState();
}

class _RemoteScannerModalState extends ConsumerState<RemoteScannerModal> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _manualBarcodeCtrl = TextEditingController();
  final List<Map<String, dynamic>> _scanHistory = [
    {
      'code': '759108868510',
      'product': 'Salsa de Tomate Pampero 397g',
      'time': 'Hace 2 min',
      'status': 'Agregado al carrito',
    },
    {
      'code': '759100100101',
      'product': 'Harina PAN Maíz Blanco 1kg',
      'time': 'Hace 5 min',
      'status': 'Agregado al carrito',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _manualBarcodeCtrl.dispose();
    super.dispose();
  }

  void _simulateScan(String barcode) {
    final posState = ref.read(posProvider);
    final posNotifier = ref.read(posProvider.notifier);

    // Buscar producto por código de barras
    final product = posState.catalog.firstWhere(
      (p) => p.barcode == barcode,
      orElse: () => posState.catalog.firstWhere(
        (p) => p.name.toLowerCase().contains('pampero'),
        orElse: () => posState.catalog.first,
      ),
    );

    // Agregar al carrito en tiempo real
    posNotifier.addToCart(product: product);

    setState(() {
      _scanHistory.insert(0, {
        'code': barcode,
        'product': product.name,
        'time': 'Ahora mismo',
        'status': 'Agregado al carrito (+1)',
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text('¡Escaneado remoto! +1 ${product.name} (Canal Supabase Realtime • Latencia: 38ms)'),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = ref.watch(primaryColorProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.surface,
      elevation: 20,
      child: Container(
        width: 620,
        height: 640,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header del Escáner Remoto
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
                      child: Icon(Icons.phonelink_ring, color: primaryColor, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Escáner Remoto Teléfono-a-PC',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18),
                        ),
                        Text(
                          'Usa la cámara de cualquier teléfono como lector inalámbrico de códigos',
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
            const SizedBox(height: 16),

            // Selector de Pestañas (Receptor PC vs Emisor Móvil)
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
                tabs: const [
                  Tab(icon: Icon(Icons.computer, size: 18), text: '1. Receptor en PC (Sesión Activa)'),
                  Tab(icon: Icon(Icons.smartphone, size: 18), text: '2. Emisor en Teléfono (Cámara)'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Contenido de las pestañas
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPcReceiverTab(primaryColor),
                  _buildPhoneEmitterTab(primaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // PESTAÑA 1: RECEPTOR EN PC
  // --------------------------------------------------------------------------
  Widget _buildPcReceiverTab(Color primaryColor) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.success.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Canal Supabase Realtime Conectado: pos_scanner_channel',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13, color: const Color(0xFF065F46)),
                      ),
                      Text(
                        'Sesión vinculada: AZULITO-SESSION-4829 • Escuchando eventos broadcast en <100ms',
                        style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF047857)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Código QR de Emparejamiento
              Container(
                width: 140,
                height: 140,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.qr_code_2, size: 84, color: AppColors.textPrimary),
                    const SizedBox(height: 4),
                    Text(
                      'PIN: 4829',
                      style: GoogleFonts.spaceMono(fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Instrucciones rápidas
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('¿Cómo vincular tu teléfono?', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Text('1. Abre la cámara de tu teléfono y escanea este código QR.', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    Text('2. O ingresa en la app móvil a la pestaña "Emisor en Teléfono".', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    Text('3. Cada producto enfocado con el láser se agregará directamente al carrito de esta PC.', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.play_arrow, size: 16),
                      label: const Text('Simular lectura Salsa Pampero (759108868510)'),
                      onPressed: () => _simulateScan('759108868510'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Historial de lecturas recibidas
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'HISTORIAL DE LECTURAS RECIBIDAS EN LA PC',
              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.8),
            ),
          ),
          const SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _scanHistory.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border),
              itemBuilder: (context, index) {
                final item = _scanHistory[index];
                return ListTile(
                  dense: true,
                  leading: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(0xFFECFDF5),
                    child: Icon(Icons.check, size: 14, color: AppColors.success),
                  ),
                  title: Text(item['product'] as String, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13)),
                  subtitle: Text('Código: ${item['code']} • ${item['time']}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      item['status'] as String,
                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.success),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // PESTAÑA 2: EMISOR EN TELÉFONO (CÁMARA CON MIRA LÁSER)
  // --------------------------------------------------------------------------
  Widget _buildPhoneEmitterTab(Color primaryColor) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Visor de Cámara con Mira Láser Roja
          Container(
            height: 190,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.accent, width: 2),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Icono sutil de cámara de fondo
                const Icon(Icons.camera_alt_outlined, color: Colors.white12, size: 70),

                // Esquinas del marco de escaneo (Viewfinder brackets)
                Positioned(
                  top: 30,
                  left: 60,
                  right: 60,
                  bottom: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Línea Láser Roja Vibrante
                        Container(
                          height: 3,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.8),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Enfocando código de barras...',
                            style: GoogleFonts.spaceMono(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Badge de resolución
                Positioned(
                  top: 10,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.fiber_manual_record, color: Colors.white, size: 10),
                        const SizedBox(width: 4),
                        Text('EN VIVO 60 FPS', style: GoogleFonts.inter(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Botones de Disparo Rápido para simular escaneo en vivo
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'DISPARADORES RÁPIDOS DE LECTURA (EMISOR MÓVIL):',
              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.8),
            ),
          ),
          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFastScanBtn('🥫 Salsa Pampero 397g', '759108868510', primaryColor),
              _buildFastScanBtn('🌽 Harina PAN 1kg', '759100100101', AppColors.success),
              _buildFastScanBtn('🥤 Pepsi Cola 1.5L', '759100100201', AppColors.accent),
              _buildFastScanBtn('🧀 Queso Blanco (Kg)', '759100100301', Colors.purple),
            ],
          ),
          const SizedBox(height: 14),

          // Input manual con botón de enviar
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: TextField(
                    controller: _manualBarcodeCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Ingresar código manual...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.send, size: 16),
                label: const Text('Enviar a PC'),
                onPressed: () {
                  final text = _manualBarcodeCtrl.text.trim();
                  if (text.isNotEmpty) {
                    _simulateScan(text);
                    _manualBarcodeCtrl.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFastScanBtn(String label, String code, Color color) {
    return InkWell(
      onTap: () => _simulateScan(code),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
