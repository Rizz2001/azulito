-- ==============================================================================
-- MIGRACIÓN: Servidor Maestro de Licencias SaaS y Multi-Tenant Supabase
-- Tabla: licencias_negocios
-- ==============================================================================

CREATE TABLE IF NOT EXISTS public.licencias_negocios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo_tienda TEXT UNIQUE NOT NULL,
    pin_activacion TEXT NOT NULL,
    nombre_negocio TEXT NOT NULL,
    rif_negocio TEXT,
    target_supabase_url TEXT NOT NULL,
    target_supabase_anon_key TEXT NOT NULL,
    plan_suscripcion TEXT DEFAULT 'PRO_BIMONEDA',
    estado_licencia TEXT NOT NULL DEFAULT 'activa' CHECK (estado_licencia IN ('activa', 'suspendida', 'vencida')),
    fecha_vencimiento TIMESTAMPTZ DEFAULT (now() + INTERVAL '1 year'),
    dispositivos_activos INT DEFAULT 1,
    notas_soporte TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Habilitar RLS
ALTER TABLE public.licencias_negocios ENABLE ROW LEVEL SECURITY;

-- Políticas de acceso para validación y gestión de terminales SaaS
DROP POLICY IF EXISTS "Permitir lectura y gestion de licencias SaaS" ON public.licencias_negocios;
CREATE POLICY "Permitir lectura y gestion de licencias SaaS" 
    ON public.licencias_negocios 
    FOR ALL 
    USING (true) 
    WITH CHECK (true);

-- Índices de consulta rápida por código de tienda y estado
CREATE INDEX IF NOT EXISTS idx_licencias_codigo ON public.licencias_negocios(codigo_tienda);
CREATE INDEX IF NOT EXISTS idx_licencias_estado ON public.licencias_negocios(estado_licencia);

-- Seed Data: 5 Negocios de prueba para el ecosistema Multi-Tenant
INSERT INTO public.licencias_negocios (
    codigo_tienda, 
    pin_activacion, 
    nombre_negocio, 
    rif_negocio, 
    target_supabase_url, 
    target_supabase_anon_key, 
    plan_suscripcion, 
    estado_licencia,
    notas_soporte
) VALUES 
(
    'AZUL-BODEGON-01', 
    '8842', 
    'Azulito Market & POS (Principal)', 
    'J-50123456-7', 
    'https://ujrwamckhqhhtdfbikhy.supabase.co', 
    'sb_publishable_OamTK90V9yFUb4Yzs74NsA_7_T-v1bb', 
    'PRO_BIMONEDA', 
    'activa',
    'Servidor de producción principal con datos en vivo'
),
(
    'AZUL-LICORERIA-02', 
    '2026', 
    'Licorería & Bodegón El Llano', 
    'J-40998877-1', 
    'https://licoreria-el-llano.supabase.co', 
    'sb_publishable_licoreria_2026_demo', 
    'PRO_BIMONEDA', 
    'activa',
    'Cliente VIP - Facturación con IGTF y cajas cerradas'
),
(
    'AZUL-FERRETERIA-03', 
    '3030', 
    'Ferretería Industrial Barinas', 
    'J-30112233-4', 
    'https://ferreteria-barinas.supabase.co', 
    'sb_publishable_ferreteria_3030_demo', 
    'ENTERPRISE_MULTI', 
    'activa',
    'Catálogo con más de 2000 SKUs y ventas a crédito'
),
(
    'AZUL-REPUESTOS-04', 
    '4040', 
    'Moto Repuestos & Racing Express', 
    'J-50445566-8', 
    'https://moto-repuestos-racing.supabase.co', 
    'sb_publishable_repuestos_4040_demo', 
    'PRO_BIMONEDA', 
    'activa',
    'Punto de venta rápido y control de inventario de repuestos'
),
(
    'AZUL-MOROSO-05', 
    '5050', 
    'Minimarket La Esquina (Suscripción Vencida)', 
    'J-29887766-0', 
    'https://minimarket-esquina.supabase.co', 
    'sb_publishable_moroso_5050_demo', 
    'PRO_BIMONEDA', 
    'suspendida',
    'Bloqueo Kill-Switch por mora de 15 días en pago mensual'
)
ON CONFLICT (codigo_tienda) DO UPDATE SET
    pin_activacion = EXCLUDED.pin_activacion,
    nombre_negocio = EXCLUDED.nombre_negocio,
    rif_negocio = EXCLUDED.rif_negocio,
    target_supabase_url = EXCLUDED.target_supabase_url,
    target_supabase_anon_key = EXCLUDED.target_supabase_anon_key,
    estado_licencia = EXCLUDED.estado_licencia,
    updated_at = now();
