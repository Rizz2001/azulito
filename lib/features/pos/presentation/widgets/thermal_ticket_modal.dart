import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../controllers/pos_controller.dart';

class ThermalTicketModal extends ConsumerWidget {
  final bool isTestTicket;

  const ThermalTicketModal({super.key, this.isTestTicket = false});

  static void show(BuildContext context, {bool isTest = false}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => ThermalTicketModal(isTestTicket: isTest),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final posState = ref.watch(posProvider);
    final is58mm = settings.paperWidth == '58mm';
    final ticketWidth = is58mm ? 290.0 : 360.0;
    final rate = posState.exchangeRate;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Contenedor del Ticket Térmico con textura de papel
              Container(
                width: ticketWidth,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF9), // Blanco marfil papel térmico
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Borde superior dentado (corte de papel)
                    _buildSerratedEdge(),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Encabezado
                          Text(
                            settings.name.toUpperCase(),
                            style: GoogleFonts.spaceMono(fontWeight: FontWeight.w900, fontSize: is58mm ? 14 : 16, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'RIF: ${settings.rif}',
                            style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, color: Colors.black87),
                          ),
                          Text(
                            'Tlf: ${settings.phone}',
                            style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, color: Colors.black87),
                          ),
                          Text(
                            settings.address,
                            style: GoogleFonts.spaceMono(fontSize: is58mm ? 9 : 10, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),

                          _buildDashedLine(),
                          const SizedBox(height: 6),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('FACTURA: FAC-043201', style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, fontWeight: FontWeight.bold, color: Colors.black)),
                              Text('14/11/2026', style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, color: Colors.black)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('CAJERO: Principal', style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, color: Colors.black87)),
                              Text('HORA: 03:00 AM', style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, color: Colors.black87)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('CLIENTE: Juan Pérez', style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, color: Colors.black87)),
                              Text('V-18234567', style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, color: Colors.black87)),
                            ],
                          ),

                          const SizedBox(height: 6),
                          _buildDashedLine(),
                          const SizedBox(height: 6),

                          // Encabezado de columnas
                          Row(
                            children: [
                              Expanded(flex: 2, child: Text('CANT', style: GoogleFonts.spaceMono(fontSize: 10, fontWeight: FontWeight.bold))),
                              Expanded(flex: 5, child: Text('DESCRIPCIÓN', style: GoogleFonts.spaceMono(fontSize: 10, fontWeight: FontWeight.bold))),
                              Expanded(flex: 3, child: Text('TOTAL', style: GoogleFonts.spaceMono(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Items de prueba o del carrito
                          _buildItemRow('1.0', 'Harina PAN 1kg', '\$1.25', is58mm),
                          _buildItemRow('1.0', 'Salsa Pampero 397g', '\$1.04', is58mm),
                          _buildItemRow('1.0', 'Pepsi Cola 1.5L', '\$1.50', is58mm),

                          const SizedBox(height: 6),
                          _buildDashedLine(),
                          const SizedBox(height: 6),

                          // Totales bimoneda
                          _buildTotalRow('SUBTOTAL (\$):', '\$3.79', is58mm, false),
                          _buildTotalRow('IGTF (3.0%):', '\$0.11', is58mm, false),
                          _buildTotalRow('TOTAL A PAGAR (\$):', '\$3.90', is58mm, true),
                          const SizedBox(height: 2),
                          _buildTotalRow('TASA DEL DÍA:', '${rate.toStringAsFixed(2)} Bs/\$', is58mm, false),
                          _buildTotalRow('TOTAL BOLÍVARES:', 'Bs. ${(3.90 * rate).toStringAsFixed(2)}', is58mm, true),

                          const SizedBox(height: 6),
                          _buildDashedLine(),
                          const SizedBox(height: 6),

                          Text('FORMAS DE PAGO:', style: GoogleFonts.spaceMono(fontSize: 10, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          _buildTotalRow('Efectivo USD (\$):', '\$3.00', is58mm, false),
                          _buildTotalRow('Pago Móvil (VES):', 'Bs. ${(0.90 * rate).toStringAsFixed(2)}', is58mm, false),

                          const SizedBox(height: 12),

                          // Código de Barras / QR impreso térmico simulado
                          Container(
                            height: 38,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.qr_code, size: 24, color: Colors.black87),
                                const SizedBox(width: 8),
                                Text(
                                  'FAC-043201-SENIAT',
                                  style: GoogleFonts.spaceMono(fontSize: 9, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          Text(
                            settings.ticketFooter,
                            style: GoogleFonts.spaceMono(fontSize: is58mm ? 9 : 10, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '*** COMPROBANTE FISCAL NO VÁLIDO SIN SELLO ***',
                            style: GoogleFonts.spaceMono(fontSize: 8, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // Borde inferior dentado
                    _buildSerratedEdge(),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Botones de Acción
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    ),
                    icon: const Icon(Icons.print, size: 18),
                    label: Text('🖨️ Enviar a ${settings.paperWidth} (${settings.connectionType.toUpperCase()})'),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Comprobante enviado a la impresora ${settings.paperWidth} correctamente.'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white70),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cerrar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSerratedEdge() {
    return Container(
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFDF9),
      ),
      child: Row(
        children: List.generate(
          35,
          (index) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: const BoxDecoration(
                color: Color(0xFFE2E8F0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashedLine() {
    return Row(
      children: List.generate(
        40,
        (i) => Expanded(
          child: Container(
            color: i.isEven ? Colors.black54 : Colors.transparent,
            height: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(String qty, String desc, String total, bool is58mm) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(qty, style: GoogleFonts.spaceMono(fontSize: is58mm ? 9 : 10, color: Colors.black))),
          Expanded(flex: 5, child: Text(desc, style: GoogleFonts.spaceMono(fontSize: is58mm ? 9 : 10, color: Colors.black), overflow: TextOverflow.ellipsis)),
          Expanded(flex: 3, child: Text(total, style: GoogleFonts.spaceMono(fontSize: is58mm ? 9 : 10, color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, bool is58mm, bool isBold) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Colors.black)),
          Text(value, style: GoogleFonts.spaceMono(fontSize: is58mm ? 10 : 11, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Colors.black)),
        ],
      ),
    );
  }
}
