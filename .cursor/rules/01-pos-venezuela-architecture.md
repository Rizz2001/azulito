# Arquitectura General y Motor de Negocio: POS e Inventario Multiplataforma Venezuela

## 1. Visión y Marco Filosófico
Este sistema está concebido como una solución de punto de venta (POS) y gestión de inventario de nivel empresarial, diseñada específicamente para las condiciones extremas y particulares del comercio en Venezuela:
- **Alta inestabilidad eléctrica y de conectividad (Anti-Apagones):** La aplicación debe ser 100% operativa en modo local sin depender de internet para facturar o consultar inventario.
- **Economía Bimoneda de Alta Frecuencia:** Precios y costos anclados en Dólares Estadounidenses (USD), con liquidación dinámica y multimoneda en Bolívares (VES) y divisas.
- **Ecosistema de Pagos Fragmentado:** Múltiples pasarelas y métodos de pago simultáneos por transacción.

---

## 2. Inspiración y Patrones Arquitectónicos de Referencia

### 2.1 `Desha29/Bayaa` (Clean Architecture & Gestión de Caja)
Se adopta la estructura **Feature-First Clean Architecture**:
```
lib/
├── core/
│   ├── database/          # Drift (SQLite local) y sincronizadores
│   ├── network/           # Supabase client y listeners de red
│   ├── theme/             # Tokens de diseño, tipografía y paleta
│   └── utils/             # Formateadores de moneda (USD/VES), UUIDs y extensiones
└── features/
    ├── pos/               # Venta rápida, carrito y checkout
    ├── inventory/         # Catálogo, variantes, presentaciones y lotes
    ├── cash_session/      # Apertura, movimientos de caja (I/E), arqueos y cierres
    ├── customers/         # Directorio de clientes y cuentas por cobrar (Crédito)
    └── settings/          # Tasa de cambio, configuración de impresora y tema
```
- **Sesión de Caja Estricta (`cash_sessions`):** No se permite procesar ninguna venta sin una caja abierta por el usuario. La sesión audita monto inicial, ingresos, egresos, ventas desglosadas por cada método de pago y discrepancia en arqueo ciego final.
- **Devoluciones Parciales por Ítem:** Soporte para revertir líneas individuales de una factura con reingreso automático al stock y emisión de nota de crédito o reintegro según el método original.

### 2.2 `AnushAdk04/pos-app` (Caché Reactiva de Stock en Memoria y Lectura Veloz)
- **Caché Reactiva de Stock (`_stockMap`):** Al cargar el catálogo o interactuar con el carrito, se mantiene un mapa reactivo en memoria (`Map<String, double> _stockMap`) que rastrea la disponibilidad en tiempo real. 
- **Prevención de Sobreventa:** Cada clic o escaneo descuenta del `_stockMap` instantáneamente sin golpear el almacenamiento local en SQLite ni realizar lecturas asíncronas lentas. Si la cantidad solicitada excede el disponible físico, la interfaz bloquea la adición con respuesta táctil y advertencia inmediata.
- **Escáner y Recibos:** Soporte nativo y rápido de pistolas lectoras de código de barras USB/Bluetooth (captura de teclado `RawKeyboardListener`/`HardwareKeyboard`) y cámara integrada móvil, con generación optimizada de tickets térmicos (80mm/58mm en PDF/ESC-POS).

### 2.3 `Desha29/pharmacy_pos` (Sincronización Multi-Dispositivo y Manejo de Conflictos)
- **Topología Multi-Caja:** En comercios con varias cajas simultáneas, los cambios se propagan a través de eventos en tiempo real de Supabase (`Postgres Changes`).
- **Resolución de Conflictos:** Estrategia basada en sellos de tiempo UTC (`client_updated_at` vs. `server_updated_at`) y vectores de versión, donde las transacciones financieras locales prevalecen y el stock se resuelve mediante operaciones delta atómicas (evitando sobrescrituras ciegas de cantidades absolutas).

---

## 3. Motor Híbrido Offline-First (Anti-Apagones)

### 3.1 Base de Datos Local Espejo (`Drift` SQLite)
- La aplicación local corre sobre **Drift (SQLite)** compilado para Windows nativo (`sqlite3.dll`), Android (`sqlite3`) y Web (`WasmDatabase` con IndexedDB / OPFS).
- Todas las lecturas del POS leen **únicamente** de Drift local, garantizando tiempos de respuesta inferiores a **16ms (60 FPS)**.
- Todas las inserciones (ventas, pagos, ajustes) se escriben primero en Drift dentro de una transacción ACID local.

### 3.2 Identificadores Universales UUID v4
- **Prohibido el uso de IDs autoincrementales** generados por base de datos remota (`serial` o `bigserial`).
- Toda entidad creada en el cliente (`sale_id`, `payment_id`, `product_id`, `customer_id`) genera su clave primaria mediante **UUID v4** local (`uuid.v4()`). Esto permite emitir facturas y relaciones complejas sin conexión previa con Supabase.

### 3.3 Ciclo de Sincronización y Tabla `sync_queue`
Cada tabla local cuenta con metadatos de sincronización:
- `sync_status`: Enum (`'synced'`, `'pending_create'`, `'pending_update'`, `'pending_delete'`).
- `client_updated_at`: Timestamp UTC de la última modificación en el dispositivo.
- `last_synced_at`: Timestamp UTC del último acuse de recibo de Supabase.

**Tabla Local `sync_queue`:**
```sql
CREATE TABLE sync_queue (
    id TEXT PRIMARY KEY,               -- UUID v4 de la tarea
    entity_name TEXT NOT NULL,         -- 'sales', 'sale_items', 'sale_payments', etc.
    entity_id TEXT NOT NULL,           -- UUID de la fila afectada
    operation TEXT NOT NULL,           -- 'INSERT', 'UPDATE', 'DELETE'
    payload TEXT NOT NULL,             -- JSON serializado del registro
    status TEXT NOT NULL,              -- 'pending', 'processing', 'failed'
    attempts INTEGER DEFAULT 0,
    error_message TEXT,
    created_at TEXT NOT NULL
);
```
- Un servicio en segundo plano monitorea la conectividad (`connectivity_plus`). Al detectar internet, procesa la cola en orden FIFO garantizado, sube las operaciones a Supabase mediante transacciones y actualiza el estado local a `'synced'`.

---

## 4. Reglas de Negocio Específicas de Venezuela

### 4.1 Arquitectura Bimoneda Dinámica (USD / VES)
1. **Moneda Base en USD:** Todos los precios base (`base_price_usd`) y costos de adquisición (`cost_usd`) se almacenan y calculan en Dólares Estadounidenses.
2. **Tasa de Cambio Activa (`exchange_rates`):**
   - El sistema almacena la tasa del día indicando origen: `BCV` (Banco Central de Venezuela), `PARALELO` o `MANUAL`.
   - Conversión en pantalla en tiempo real: `precio_ves = round(precio_usd * tasa_activa, 2)`.
3. **Congelamiento de Tasa por Venta (`exchange_rate_used`):**
   - Cada factura almacena en su registro cabecera el valor exacto de la tasa en el instante del cobro. Aunque la tasa cambie una hora después, los reportes históricos y la contabilidad de esa factura permanecen inalterables.

### 4.2 Pagos Mixtos y Ecosistema de Pasarelas (Relación `1:N`)
Una sola venta puede liquidarse con múltiples métodos de pago combinados hasta completar el total (`sale_payments`):
- **Efectivo USD (`cash_usd`):** Admite cambio en USD o cambio en Bolívares a la tasa de la transacción.
- **Efectivo VES (`cash_ves`):** Billetes en Bolívares.
- **Pago Móvil (`pago_movil`):** Requiere registro de banco emisor, teléfono y últimos 4 a 6 dígitos de referencia.
- **Punto de Venta / Tarjetas (`point_of_sale`):** Tarjetas de débito o crédito nacional, guardando número de lote y referencia.
- **Biopago BDV (`biopago`):** Sistema biométrico del Banco de Venezuela.
- **Zelle (`zelle`):** Transferencia en divisas con titular de la cuenta y referencia.
- **Transferencia Bancaria (`bank_transfer`):** Transferencia directa a cuenta jurídica o natural.
- **Crédito de Tienda (`store_credit`):** Genera una cuenta por cobrar (CxC) asociada al perfil del cliente, validando su límite de crédito disponible.
- **Cashea (`cashea`):** Sistema Buy Now Pay Later (BNPL) venezolano:
  - *Modo Cuotas:* El cliente cancela un pago inicial en caja (ej. 40%, 50% o 60%) y el saldo restante queda financiado a través de la plataforma en cuotas quincenales.
  - *Modo Pago Directo:* Liquidación completa reportada a la plataforma.

### 4.3 IGTF (Impuesto a las Grandes Transacciones Financieras - 3%)
- El módulo de cobro incluye un interruptor (*switch*) configurable para el cobro del 3% de IGTF.
- **Regla Fiscal Estricta:** El 3% se calcula **únicamente** sobre la porción del pago realizada en divisas o moneda extranjera en efectivo/digital (`cash_usd`, `zelle`). Los montos cancelados en Bolívares (efectivo, Pago Móvil, Punto de Venta) están exentos de IGTF.

### 4.4 Catálogo Avanzado y Multi-Presentación
- **Productos Simples:** Venta por unidad individual con código de barras estándar.
- **Presentaciones / Cajas / Bultos (`product_presentations`):**
  - Un producto base (ej. "Refresco 1.5L") tiene stock en unidades.
  - Se definen presentaciones hijas (ej. "Caja x 6 unidades").
  - Al vender 1 Caja, el sistema descuenta atómicamente **6 unidades** del stock base sin duplicar inventarios.
- **Productos Fraccionados / Pesables:** Soporte para cantidades con decimales (`double`), ideal para víveres, carnicerías y charcuterías (ej. `1.455 kg`).
- **Variantes de Producto:** Matrices de Talla y Color bajo un producto padre, compartiendo atributos pero con SKU y códigos de barra independientes.
- **Combos y Kits:** Artículos agrupados que no poseen stock propio, sino que verifican y descuentan los stocks de sus componentes individuales al momento de facturar.
