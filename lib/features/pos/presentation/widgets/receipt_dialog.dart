import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/pos_models.dart';

class ReceiptDialog extends StatelessWidget {
  final SaleReceiptModel receipt;

  const ReceiptDialog({super.key, required this.receipt});

  static void show(BuildContext context, SaleReceiptModel receipt) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => ReceiptDialog(receipt: receipt),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 440,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Cabecera del Modal
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.success, size: 22),
                      const SizedBox(width: 8),
                      Text('¡Venta Exitosa!', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Contenedor del Ticket Térmico Imprimible
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Encabezado del Comercio
                      Text(
                        receipt.storeName.toUpperCase(),
                        style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: 0.5),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'RIF: ${receipt.storeRif}',
                        style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      Text(
                        'Caracas, Venezuela • Tel: +58 412 1234567',
                        style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 12),
                      const Divider(thickness: 1, color: Colors.black26),

                      // Datos de la Factura y Tasa Congelada
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Factura: ${receipt.invoiceNumber}', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12)),
                          Text(dateFormat.format(receipt.date), style: GoogleFonts.inter(fontSize: 11)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Cajero: ${receipt.cashierName}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                          Text('Tasa: ${receipt.exchangeRate.toStringAsFixed(2)} Bs/\$', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.defaultPrimary)),
                        ],
                      ),
                      if (receipt.customer != null) ...[
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Cliente: ${receipt.customer!.fullName} (${receipt.customer!.idDocument})',
                            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                      const Divider(thickness: 1, color: Colors.black26),

                      // Detalle de Ítems
                      ...receipt.items.map((item) {
                        final itemBs = item.subtotalUsd * receipt.exchangeRate;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.isWeight
                                    ? '${item.quantity.toStringAsFixed(3)} kg x '
                                    : '${item.quantity.toInt()} x ',
                                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: GoogleFonts.inter(fontSize: 12),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('\$${item.subtotalUsd.toStringAsFixed(2)}', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Text('Bs. ${itemBs.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary)),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),

                      const Divider(thickness: 1, color: Colors.black26),

                      // Subtotales y Desglose Fiscal
                      _buildSummaryRow('Subtotal:', '\$${receipt.subtotalUsd.toStringAsFixed(2)}'),
                      if (receipt.discountUsd > 0)
                        _buildSummaryRow('Descuento:', '-\$${receipt.discountUsd.toStringAsFixed(2)}', color: AppColors.danger),
                      if (receipt.igtfApplied)
                        _buildSummaryRow('IGTF Divisas (3%):', '\$${receipt.igtfAmountUsd.toStringAsFixed(2)}', color: AppColors.warning),

                      const SizedBox(height: 6),
                      // TOTAL EN DÓLARES Y BOLÍVARES
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('TOTAL A PAGAR (USD):', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14)),
                                Text('\$${receipt.totalUsd.toStringAsFixed(2)}', style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.defaultPrimary)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('TOTAL EN BOLÍVARES:', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.textSecondary)),
                                Text('Bs. ${receipt.totalBs.toStringAsFixed(2)}', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Desglose de Pagos Mixtos
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Formas de Pago Aplicadas:', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 4),
                      ...receipt.payments.map((p) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '• ${p.methodLabel}${p.referenceNumber != null ? " (Ref: ${p.referenceNumber})" : ""}',
                              style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                            ),
                            Text(
                              p.currency == 'USD'
                                  ? '\$${p.amountOriginal.toStringAsFixed(2)}'
                                  : 'Bs. ${p.amountOriginal.toStringAsFixed(2)} (\$${p.amountUsdEquivalent.toStringAsFixed(2)})',
                              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )),

                      const SizedBox(height: 16),
                      // Código de Barras Simulado
                      Container(
                        height: 40,
                        width: double.infinity,
                        color: const Color(0xFFF1F5F9),
                        child: Center(
                          child: Text(
                            '* ${receipt.invoiceNumber} *',
                            style: GoogleFonts.courierPrime(letterSpacing: 4, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('¡Gracias por su compra!', style: GoogleFonts.inter(fontSize: 11, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ),
            ),

            // Botones de Acción (Imprimir, PDF, WhatsApp, Nueva Venta)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.print, size: 18),
                          label: const Text('Imprimir'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Ticket enviado a la impresora térmica (80mm)')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.picture_as_pdf, size: 18),
                          label: const Text('PDF'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Recibo PDF generado exitosamente')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.share, size: 18, color: Color(0xFF25D366)),
                          label: const Text('WhatsApp'),
                          onPressed: () {
                            final phone = receipt.customer?.phone ?? '584120000000';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Abriendo WhatsApp para $phone con el recibo...')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: const Text('NUEVA VENTA'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 12, color: color ?? AppColors.textSecondary)),
          Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
