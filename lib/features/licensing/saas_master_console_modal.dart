import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/clean_soft_pill.dart';
import '../../core/licensing/license_model.dart';
import '../../core/licensing/licensing_controller.dart';

class SaasMasterConsoleModal extends ConsumerStatefulWidget {
  const SaasMasterConsoleModal({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const SaasMasterConsoleModal(),
    );
  }

  @override
  ConsumerState<SaasMasterConsoleModal> createState() => _SaasMasterConsoleModalState();
}

class _SaasMasterConsoleModalState extends ConsumerState<SaasMasterConsoleModal> {
  final TextEditingController _pinCtrl = TextEditingController();
  bool _isUnlocked = false;
  String? _pinError;

  @override
  void initState() {
    super.initState();
    _isUnlocked = ref.read(licensingProvider).isSuperAdminUnlocked;
  }

  @override
  void dispose() {
    _pinCtrl.dispose();
    super.dispose();
  }

  void _verifyPin(String pin) {
    final success = ref.read(licensingProvider.notifier).unlockSuperAdmin(pin);
    if (success) {
      setState(() {
        _isUnlocked = true;
        _pinError = null;
      });
      ref.read(licensingProvider.notifier).refreshLicensesList();
    } else {
      setState(() {
        _pinError = 'PIN de SuperAdmin incorrecto (Use: 9999)';
        _pinCtrl.clear();
      });
    }
  }

  void _copySqlMasterSchema() {
    Clipboard.setData(const ClipboardData(text: _kFullTenantSqlSchema));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.copy_all, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text('¡Script SQL Maestro copiado al portapapeles! Pégalo en el SQL Editor de tu nueva cuenta Supabase.'),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _showAddBusinessDialog() {
    final codeCtrl = TextEditingController();
    final pinCtrl = TextEditingController(text: '1234');
    final nameCtrl = TextEditingController();
    final rifCtrl = TextEditingController(text: 'J-');
    final urlCtrl = TextEditingController(text: 'https://nuevo-negocio.supabase.co');
    final keyCtrl = TextEditingController(text: 'sb_publishable_key_aqui');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Registrar Nueva Tienda SaaS', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16)),
        content: SizedBox(
          width: 440,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: codeCtrl, decoration: const InputDecoration(labelText: 'Código de Tienda (Ej: AZUL-NUEVO-06)')),
                const SizedBox(height: 10),
                TextField(controller: pinCtrl, decoration: const InputDecoration(labelText: 'PIN de Activación (4 Dígitos)')),
                const SizedBox(height: 10),
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nombre del Negocio')),
                const SizedBox(height: 10),
                TextField(controller: rifCtrl, decoration: const InputDecoration(labelText: 'RIF / Fiscal')),
                const SizedBox(height: 10),
                TextField(controller: urlCtrl, decoration: const InputDecoration(labelText: 'Target Supabase Project URL')),
                const SizedBox(height: 10),
                TextField(controller: keyCtrl, decoration: const InputDecoration(labelText: 'Target Supabase Anon Key')),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E40AF),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              if (codeCtrl.text.isNotEmpty && nameCtrl.text.isNotEmpty) {
                final newModel = BusinessLicenseModel(
                  id: '',
                  storeCode: codeCtrl.text.trim().toUpperCase(),
                  activationPin: pinCtrl.text.trim(),
                  businessName: nameCtrl.text.trim(),
                  rif: rifCtrl.text.trim(),
                  targetSupabaseUrl: urlCtrl.text.trim(),
                  targetSupabaseAnonKey: keyCtrl.text.trim(),
                  status: 'activa',
                );
                await ref.read(licensingProvider.notifier).saveCustomBusiness(newModel);
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tienda ${newModel.storeCode} registrada en el Servidor Maestro')),
                  );
                }
              }
            },
            child: const Text('Guardar Negocio'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = ref.watch(primaryColorProvider);
    final licensingState = ref.watch(licensingProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.surface,
      elevation: 24,
      child: Container(
        width: _isUnlocked ? 840 : 400,
        padding: const EdgeInsets.all(26),
        child: _isUnlocked
            ? _buildConsolePanel(licensingState, primaryColor)
            : _buildPinGate(primaryColor),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // PANTALLA 1: PIN DE SUPERADMIN (9999)
  // --------------------------------------------------------------------------
  Widget _buildPinGate(Color primaryColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.admin_panel_settings, color: Color(0xFF0F172A), size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  'Consola Maestro SaaS',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16),
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
        Text(
          'Ingrese el PIN de SuperAdmin para acceder a la administración global de licencias y Kill-Switch remoto:',
          style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Campo de PIN
        SizedBox(
          width: 180,
          child: TextField(
            controller: _pinCtrl,
            keyboardType: TextInputType.number,
            maxLength: 4,
            obscureText: true,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceMono(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 8),
            decoration: InputDecoration(
              counterText: '',
              hintText: '••••',
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onSubmitted: _verifyPin,
          ),
        ),

        if (_pinError != null) ...[
          const SizedBox(height: 10),
          Text(_pinError!, style: const TextStyle(color: AppColors.danger, fontSize: 12, fontWeight: FontWeight.bold)),
        ],

        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.lock_open, size: 18),
              label: const Text('Desbloquear'),
              onPressed: () => _verifyPin(_pinCtrl.text),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => _verifyPin('9999'),
              child: const Text('Auto (9999)', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // PANTALLA 2: CONSOLA DE ADMINISTRACIÓN SAAS
  // --------------------------------------------------------------------------
  Widget _buildConsolePanel(LicensingState state, Color primaryColor) {
    return SingleChildScrollView(
      child: Column(
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
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.admin_panel_settings, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Consola Maestro SaaS', style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 18)),
                          const SizedBox(width: 8),
                          CleanSoftPill(
                            text: 'SUPERADMIN ACTIVO',
                            backgroundColor: const Color(0xFF0F172A).withOpacity(0.1),
                            textColor: const Color(0xFF0F172A),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          ),
                        ],
                      ),
                      Text(
                        'Servidor de Licencias: https://ujrwamckhqhhtdfbikhy.supabase.co (CRPproyecto)',
                        style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
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

          // Botones de acción rápida superiores
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF059669),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.copy_all, size: 18),
                label: const AutoSizeText('📋 Copiar Script SQL para Nuevo Supabase', maxLines: 1),
                onPressed: _copySqlMasterSchema,
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: BorderSide(color: primaryColor.withOpacity(0.5)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.add_business, size: 18),
                label: const AutoSizeText('+ Registrar Nueva Tienda / Supabase', maxLines: 1),
                onPressed: _showAddBusinessDialog,
              ),
              IconButton(
                icon: const Icon(Icons.refresh, size: 20),
                tooltip: 'Refrescar Licencias desde Servidor Maestro',
                onPressed: () => ref.read(licensingProvider.notifier).refreshLicensesList(),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Lista de las 5 tiendas en tiempo real
          Text(
            'TIENDAS Y NEGOCIOS REGISTRADOS EN SUPABASE (KILL-SWITCH EN VIVO):',
            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.6),
          ),
          const SizedBox(height: 10),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.allLicenses.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final lic = state.allLicenses[index];
              final isActive = lic.isActive;
              final isCurrentActive = state.activeLicense?.storeCode == lic.storeCode;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isCurrentActive ? primaryColor.withOpacity(0.04) : AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isCurrentActive ? primaryColor : AppColors.border,
                    width: isCurrentActive ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Icono de estado
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isActive ? AppColors.success.withOpacity(0.3) : AppColors.danger.withOpacity(0.3),
                        ),
                      ),
                      child: Icon(
                        isActive ? Icons.storefront : Icons.storefront_outlined,
                        color: isActive ? AppColors.success : AppColors.danger,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Info del negocio
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(lic.storeCode, style: GoogleFonts.spaceMono(fontWeight: FontWeight.w800, fontSize: 13)),
                              const SizedBox(width: 8),
                              CleanSoftPill(
                                text: isActive ? '🟢 ACTIVA' : '🔴 SUSPENDIDA',
                                backgroundColor: isActive ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                                textColor: isActive ? const Color(0xFF065F46) : AppColors.danger,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              ),
                              if (isCurrentActive) ...[
                                const SizedBox(width: 6),
                                CleanSoftPill(
                                  text: 'ESTE DISPOSITIVO',
                                  backgroundColor: primaryColor.withOpacity(0.12),
                                  textColor: primaryColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(lic.businessName, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
                          Text(
                            'PIN: ${lic.activationPin} • RIF: ${lic.rif ?? "N/A"} • Plan: ${lic.plan}',
                            style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          Text(
                            'Endpoint: ${lic.targetSupabaseUrl}',
                            style: GoogleFonts.spaceMono(fontSize: 10, color: AppColors.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Botón de Acción Kill-Switch
                    Column(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isActive ? const Color(0xFFDC2626) : const Color(0xFF059669),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: Icon(isActive ? Icons.power_settings_new : Icons.play_arrow, size: 16),
                          label: Text(
                            isActive ? '🔴 Suspender (Kill-Switch)' : '🟢 Activar Tienda',
                            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final newStatus = isActive ? 'suspendida' : 'activa';
                            final ok = await ref.read(licensingProvider.notifier).toggleStoreStatus(lic.storeCode, newStatus);
                            if (ok && mounted) {
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text('Estado de ${lic.storeCode} cambiado a: ${newStatus.toUpperCase()} en Supabase'),
                                  backgroundColor: newStatus == 'activa' ? AppColors.success : AppColors.danger,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Script SQL Maestro completo embebido para copiado al portapapeles
const String _kFullTenantSqlSchema = r'''
-- AZULITO POS: ESQUEMA MAESTRO UNIFICADO PARA NUEVAS CUENTAS SUPABASE (TENANTS)
-- Copia y pega en el SQL Editor de tu nuevo proyecto Supabase y ejecuta "Run".
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS public.stores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    rif TEXT NOT NULL,
    phone TEXT,
    address TEXT,
    primary_color TEXT NOT NULL DEFAULT '#1E40AF',
    secondary_color TEXT NOT NULL DEFAULT '#0EA5E9',
    default_igtf_enabled BOOLEAN NOT NULL DEFAULT true,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.exchange_rates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    source TEXT NOT NULL CHECK (source IN ('bcv', 'parallel', 'manual')),
    rate NUMERIC(12, 4) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    full_name TEXT NOT NULL,
    email TEXT,
    role TEXT NOT NULL CHECK (role IN ('admin', 'cashier')) DEFAULT 'cashier',
    quick_pin TEXT,
    is_active BOOLEAN NOT NULL DEFAULT true,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    icon_name TEXT NOT NULL DEFAULT 'category',
    color_hex TEXT NOT NULL DEFAULT '#0EA5E9',
    sort_order INTEGER NOT NULL DEFAULT 0,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,
    sku TEXT UNIQUE,
    barcode TEXT,
    name TEXT NOT NULL,
    description TEXT,
    image_url TEXT,
    product_type TEXT NOT NULL CHECK (product_type IN ('unit', 'weight_fraction', 'variant', 'combo')) DEFAULT 'unit',
    cost_usd NUMERIC(12, 4) NOT NULL DEFAULT 0.0000,
    profit_margin_percent NUMERIC(6, 2) NOT NULL DEFAULT 30.00,
    price_usd NUMERIC(12, 4) NOT NULL,
    stock_quantity NUMERIC(12, 3) NOT NULL DEFAULT 0.000,
    min_stock_alert NUMERIC(12, 3) NOT NULL DEFAULT 5.000,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.product_presentations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    barcode TEXT,
    quantity_equivalent NUMERIC(12, 3) NOT NULL,
    price_usd NUMERIC(12, 4) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.product_variants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    variant_name TEXT NOT NULL,
    sku TEXT,
    barcode TEXT,
    additional_price_usd NUMERIC(12, 4) NOT NULL DEFAULT 0.0000,
    stock_quantity NUMERIC(12, 3) NOT NULL DEFAULT 0.000,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.combo_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    combo_product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    component_product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    quantity_required NUMERIC(12, 3) NOT NULL DEFAULT 1.000,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    full_name TEXT NOT NULL,
    id_document TEXT,
    phone TEXT,
    email TEXT,
    address TEXT,
    credit_limit_usd NUMERIC(12, 4) NOT NULL DEFAULT 0.0000,
    current_debt_usd NUMERIC(12, 4) NOT NULL DEFAULT 0.0000,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.cash_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    status TEXT NOT NULL CHECK (status IN ('open', 'closed')) DEFAULT 'open',
    opened_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    closed_at TIMESTAMPTZ,
    opening_cash_usd NUMERIC(12, 4) NOT NULL DEFAULT 0.0000,
    opening_cash_bs NUMERIC(14, 2) NOT NULL DEFAULT 0.00,
    expected_cash_usd NUMERIC(12, 4) NOT NULL DEFAULT 0.0000,
    expected_cash_bs NUMERIC(14, 2) NOT NULL DEFAULT 0.00,
    declared_cash_usd NUMERIC(12, 4),
    declared_cash_bs NUMERIC(14, 2),
    difference_usd NUMERIC(12, 4),
    difference_bs NUMERIC(14, 2),
    notes TEXT,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.cash_movements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    cash_session_id UUID REFERENCES public.cash_sessions(id) ON DELETE CASCADE,
    movement_type TEXT NOT NULL CHECK (movement_type IN ('in', 'out')),
    amount NUMERIC(12, 4) NOT NULL,
    currency TEXT NOT NULL CHECK (currency IN ('USD', 'VES')),
    exchange_rate NUMERIC(12, 4) NOT NULL,
    amount_usd_equivalent NUMERIC(12, 4) NOT NULL,
    reason TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.sales (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    cash_session_id UUID REFERENCES public.cash_sessions(id) ON DELETE SET NULL,
    customer_id UUID REFERENCES public.customers(id) ON DELETE SET NULL,
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    invoice_number TEXT NOT NULL,
    exchange_rate_used NUMERIC(12, 4) NOT NULL,
    subtotal_usd NUMERIC(12, 4) NOT NULL,
    discount_usd NUMERIC(12, 4) NOT NULL DEFAULT 0.0000,
    igtf_applied BOOLEAN NOT NULL DEFAULT false,
    igtf_amount_usd NUMERIC(12, 4) NOT NULL DEFAULT 0.0000,
    total_usd NUMERIC(12, 4) NOT NULL,
    total_bs NUMERIC(14, 2) NOT NULL,
    payment_status TEXT NOT NULL CHECK (payment_status IN ('paid', 'partial', 'pending', 'cancelled', 'refunded', 'partial_return')) DEFAULT 'paid',
    notes TEXT,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.sale_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sale_id UUID NOT NULL REFERENCES public.sales(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE RESTRICT,
    presentation_id UUID REFERENCES public.product_presentations(id) ON DELETE SET NULL,
    variant_id UUID REFERENCES public.product_variants(id) ON DELETE SET NULL,
    product_name TEXT NOT NULL,
    quantity NUMERIC(12, 3) NOT NULL,
    unit_price_usd NUMERIC(12, 4) NOT NULL,
    subtotal_usd NUMERIC(12, 4) NOT NULL,
    returned_quantity NUMERIC(12, 3) NOT NULL DEFAULT 0.000,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.sale_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sale_id UUID NOT NULL REFERENCES public.sales(id) ON DELETE CASCADE,
    payment_method TEXT NOT NULL CHECK (payment_method IN (
        'cash_usd', 'cash_bs', 'pago_movil', 'pos_card', 'biopago',
        'zelle', 'transfer_bs', 'cashea_initial', 'cashea_financed', 'store_credit'
    )),
    amount_original NUMERIC(14, 2) NOT NULL,
    currency TEXT NOT NULL CHECK (currency IN ('USD', 'VES')) DEFAULT 'USD',
    exchange_rate NUMERIC(12, 4) NOT NULL,
    amount_usd_equivalent NUMERIC(12, 4) NOT NULL,
    reference_number TEXT,
    bank_name TEXT,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.customer_debt_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    customer_id UUID REFERENCES public.customers(id) ON DELETE CASCADE,
    cash_session_id UUID REFERENCES public.cash_sessions(id) ON DELETE SET NULL,
    payment_method TEXT NOT NULL,
    amount_original NUMERIC(12, 4) NOT NULL,
    currency TEXT NOT NULL CHECK (currency IN ('USD', 'VES')),
    exchange_rate NUMERIC(12, 4) NOT NULL,
    amount_usd_equivalent NUMERIC(12, 4) NOT NULL,
    reference_number TEXT,
    bank_name TEXT,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.inventory_movements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES public.stores(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    movement_type TEXT NOT NULL CHECK (movement_type IN ('initial', 'purchase', 'sale', 'refund', 'adjustment', 'waste')),
    quantity NUMERIC(12, 3) NOT NULL,
    previous_stock NUMERIC(12, 3) NOT NULL,
    new_stock NUMERIC(12, 3) NOT NULL,
    cost_usd NUMERIC(12, 4),
    reference_id UUID,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- RLS
ALTER TABLE public.stores ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exchange_rates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_presentations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_variants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.combo_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cash_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cash_movements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sales ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sale_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sale_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customer_debt_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inventory_movements ENABLE ROW LEVEL SECURITY;

DO $$
DECLARE
    t text;
    tables text[] := ARRAY[
        'stores', 'exchange_rates', 'profiles', 'categories', 'products',
        'product_presentations', 'product_variants', 'combo_items', 'customers',
        'cash_sessions', 'cash_movements', 'sales', 'sale_items', 'sale_payments',
        'customer_debt_payments', 'inventory_movements'
    ];
BEGIN
    FOREACH t IN ARRAY tables LOOP
        EXECUTE format('DROP POLICY IF EXISTS "Allow full access for all roles" ON public.%I', t);
        EXECUTE format('CREATE POLICY "Allow full access for all roles" ON public.%I FOR ALL USING (true) WITH CHECK (true)', t);
    END LOOP;
END $$;
''';
