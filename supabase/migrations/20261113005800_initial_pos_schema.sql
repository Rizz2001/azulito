-- Migración Inicial Canónica: Sistema POS e Inventario Multiplataforma para Venezuela
-- Fecha: 2026-11-13
-- Módulo: 14 Tablas Relacionales Bimoneda (USD/Bs) con RLS y Soporte Multi-Tienda

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 1. STORES / APP SETTINGS
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

-- 2. EXCHANGE RATES
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

-- 3. USERS / PROFILES
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

-- 4. CATEGORIES
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

-- 5. PRODUCTS
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

-- 6. PRODUCT PRESENTATIONS (Cajas / Bultos)
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

-- 7. PRODUCT VARIANTS (Tallas y Colores)
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

-- 8. COMBO ITEMS
CREATE TABLE IF NOT EXISTS public.combo_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    combo_product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    component_product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    quantity_required NUMERIC(12, 3) NOT NULL DEFAULT 1.000,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 9. CUSTOMERS
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

-- 10. CASH SESSIONS (Sesiones de Caja)
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

-- 11. SALES (Ventas con congelamiento de tasa)
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
    payment_status TEXT NOT NULL CHECK (payment_status IN ('paid', 'partial', 'pending', 'cancelled')) DEFAULT 'paid',
    notes TEXT,
    is_deleted BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 12. SALE ITEMS (con soporte de devoluciones parciales)
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

-- 13. SALE PAYMENTS (1:N Pagos Mixtos Venezuela)
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

-- 14. INVENTORY MOVEMENTS (Kardex auditable)
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

-- HABILITACIÓN DE ROW LEVEL SECURITY (RLS) EN LAS 14 TABLAS
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
ALTER TABLE public.sales ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sale_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sale_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inventory_movements ENABLE ROW LEVEL SECURITY;

-- POLÍTICAS RLS (Permisivas para inicio y desarrollo con Supabase client y backend)
DO $$
DECLARE
    t text;
    tables text[] := ARRAY[
        'stores', 'exchange_rates', 'profiles', 'categories', 'products',
        'product_presentations', 'product_variants', 'combo_items', 'customers',
        'cash_sessions', 'sales', 'sale_items', 'sale_payments', 'inventory_movements'
    ];
BEGIN
    FOREACH t IN ARRAY tables LOOP
        EXECUTE format('DROP POLICY IF EXISTS "Allow full access for all roles" ON public.%I', t);
        EXECUTE format('CREATE POLICY "Allow full access for all roles" ON public.%I FOR ALL USING (true) WITH CHECK (true)', t);
    END LOOP;
END $$;

