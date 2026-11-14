-- Migración: Movimientos de Caja Chica y Abonos de Clientes CxC
-- Timestamp: 2026-11-14 01:00:00

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

-- Habilitar RLS
ALTER TABLE public.cash_movements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customer_debt_payments ENABLE ROW LEVEL SECURITY;

-- Políticas de Acceso Permisivo
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'cash_movements' AND policyname = 'Public Access cash_movements'
    ) THEN
        CREATE POLICY "Public Access cash_movements" ON public.cash_movements FOR ALL USING (true) WITH CHECK (true);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'customer_debt_payments' AND policyname = 'Public Access customer_debt_payments'
    ) THEN
        CREATE POLICY "Public Access customer_debt_payments" ON public.customer_debt_payments FOR ALL USING (true) WITH CHECK (true);
    END IF;
END $$;

