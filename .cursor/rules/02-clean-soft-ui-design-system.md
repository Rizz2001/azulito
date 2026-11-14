# Sistema de Diseño: Clean Soft UI & Ergonomía POS

## 1. Fundamentos y Paleta de Color "Clean Soft"
El sistema visual está diseñado para entornos de trabajo continuo (pantallas de cajeros, tablets y monitores de mostrador), minimizando la fatiga visual mediante contrastes suaves, superficies limpias y acentos cromáticos vibrantes.

### 1.1 Tokens de Color
- **Color Primario (por defecto):** Azul Rey (`#1E40AF` / `Color(0xFF1E40AF)`). Comunica estabilidad, confianza bancaria y autoridad.
- **Color Secundario / Acento:** Azul Cielo (`#0EA5E9` / `Color(0xFF0EA5E9)`). Utilizado para badges, indicadores activos, focos y micro-interacciones.
- **Fondo de Aplicación:** Blanco Frío Suave (`#F1F5F9` / `Color(0xFFF1F5F9)`). Proporciona contraste suave sin la agresividad del blanco puro.
- **Superficie de Tarjetas y Contenedores:** Blanco Puro (`#FFFFFF` / `Color(0xFFFFFFFF)`).
- **Texto Principal:** Pizarra Oscura (`#0F172A` / `Color(0xFF0F172A)`).
- **Texto Secundario / Etiquetas Suaves:** Pizarra Media (`#64748B` / `Color(0xFF64748B)`).
- **Bordes y Divisores:** Pizarra Clara (`#E2E8F0` / `Color(0xFFE2E8F0)`).
- **Estados de Alerta:**
  - Éxito / Online: Verde Esmeralda (`#10B981`).
  - Alerta / Offline: Naranja Ámbar (`#F59E0B`).
  - Error / Peligro: Rojo Carmesí (`#EF4444`).

### 1.2 Geometría y Sombras Suaves (Soft Radii & Shadows)
- **Tarjetas y Paneles Principales:** Bordes redondeados de `20px` (`BorderRadius.circular(20)`).
- **Botones, Inputs y Chips:** Bordes redondeados de `14px` (`BorderRadius.circular(14)`).
- **Píldoras e Indicadores:** Bordes completamente redondeados (`BorderRadius.circular(9999)`).
- **Sombra Difusa Soft:**
  ```dart
  boxShadow: [
    BoxShadow(
      color: Color(0x0A0F172A), // 4% de opacidad pizarra
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ]
  ```
- **Personalización Dinámica:** La aplicación permite al administrador elegir o alterar el color primario desde el menú de Ajustes; el motor de temas recompone los degradados y estados activos en tiempo de ejecución.

---

## 2. Header Global y Navegación Superior
El encabezado permanece accesible en todas las vistas principales de la aplicación:

1. **Buscador Universal Omnipresente:**
   - Campo de texto limpio con ícono de lupa y atajo de teclado (`Ctrl + F`).
   - Escucha continua de pistolas lectoras de códigos de barra USB/Bluetooth en segundo plano (`HardwareKeyboard`), permitiendo agregar productos al carrito sin necesidad de hacer clic previo en el campo de texto.
   - Botón de escáner visual por cámara para dispositivos móviles.
2. **Píldora Interactiva de Tasa del Día:**
   - Visualización destacada: `💵 Tasa: 54.20 Bs/$`.
   - Al hacer clic, abre un modal rápido para consultar tasa oficial BCV, Tasa Paralelo o fijar una tasa personalizada manual para la sesión actual.
3. **Indicador de Estado de Conectividad:**
   - `🟢 Online`: Conexión activa con Supabase.
   - `🟠 Modo Offline (X en cola)`: Conexión caída, mostrando el número exacto de transacciones pendientes en `sync_queue` listas para subir al restablecerse la red.

---

## 3. Layout Responsivo de 3 Columnas en PC (Pantallas >= 900px)
En pantallas de escritorio y tablets en modo horizontal, el POS adopta un diseño de tres paneles independientes sin scroll de página general:

```
+------------------------------------------------------------------------------------+
|                                   HEADER GLOBAL                                    |
+-------------------+------------------------------------------+---------------------+
|   COLUMNA 1       |               COLUMNA 2                  |      COLUMNA 3      |
|  (CATEGORÍAS)     |         (CUADRÍCULA DE PRODUCTOS)        |   (ORDER DETAILS)   |
|   ~200px          |                Flexible                  |       ~400px        |
|                   |                                          |                     |
| [ ] Todos         | +--------------+  +--------------+       | [Cliente] [Desc]    |
| [*] Víveres       | | [ Foto/Avatar]  | [ Foto/Avatar]       | [Hold]    [Escáner] |
| [ ] Bebidas       | | Harina PAN   |  | Arroz 1kg    |       |---------------------|
| [ ] Lácteos       | | Stock: 42    |  | Stock: 18    |       | Items en Carrito... |
| [ ] Limpieza      | | $1.20        |  | $1.10        |       | - Harina x2  $2.40  |
|                   | | Bs. 65.04    |  | Bs. 59.62    |       | - Arroz x1   $1.10  |
|                   | +--------------+  +--------------+       |---------------------|
|                   |                                          | Switch IGTF [ ] 3%  |
|                   |                                          | Total USD: $3.50    |
|                   |                                          | Total Bs:  Bs189.70 |
|                   |                                          | [ BOTÓN COBRAR ]    |
+-------------------+------------------------------------------+---------------------+
```

### Detalle de Columnas:
1. **Columna Izquierda (Categorías Verticales):**
   - Lista scrollable de categorías con ícono, nombre y contador de productos.
   - Indicador de selección activo con píldora coloreada en Azul Rey y texto en alto contraste.
2. **Columna Central (Catálogo y Grilla de Productos):**
   - Cuadrícula adaptable (*auto-fit*) con tarjetas en fondo blanco puro y esquinas redondeadas de 20px.
   - **Imagen / Avatar:** Imagen centrada con `BoxFit.contain`. Si el producto no tiene fotografía, se genera un avatar limpio con fondo pastel derivado de la categoría y las iniciales del producto en tipografía enérgica.
   - **Etiqueta de Stock:** Chip superior con disponibilidad (`Disponible: 24`). Si el stock es bajo (≤ 5), cambia a advertencia ámbar; si es 0, la tarjeta se atenúa visualmente y bloquea la selección.
   - **Jerarquía de Precios Bimoneda:**
     - Precio en **Dólares en texto grande y en negrita** (ej. **$1.20**).
     - Precio en **Bolívares en tipografía mediana y color suave** al lado o debajo (ej. `Bs. 65.04`).
3. **Columna Derecha (Panel de Orden / Carrito):**
   - **Barra de Acciones Rápidas:** Botones compactos para asignar Cliente (o Consumidor Final), aplicar Descuento porcentual/monto, pausar cuenta (*Hold Bill / Cuentas en Espera*) y vincular escáner remoto.
   - **Lista de Ítems del Carrito:** Fila limpia por ítem con nombre, selector de cantidad interactivo (`- 1 +`), cálculo de subtotales y botón para remover.
   - **Bloque de Cierre:**
     - Toggle para activar/desactivar IGTF (3%).
     - Totales calculados en tiempo real en ambas monedas (USD y Bs).
     - Botón principal de cobro a todo lo ancho en Azul Rey con tipografía clara y vibrante (`Cobrar $XX.XX / Bs. YY.YY`).

---

## 4. Layout Móvil (< 900px) y Modales Táctiles

### 4.1 Floating Pill Dock Inferior
- En pantallas móviles y tablets verticales, la navegación tradicional se reemplaza por un dock flotante en forma de cápsula (*Floating Pill Dock*), con esquinas redondeadas (`BorderRadius.circular(9999)`), fondo blanco con sombra pronunciada y efecto de desenfoque de fondo (*glassmorphism* suave).
- Contiene accesos directos al POS, Inventario, Sesión de Caja, Clientes y Dashboard, con badge numérico en el carrito.

### 4.2 Dashboard de Rendimiento
- **Tarjeta Principal Hero:** Gradiente elegante desde Azul Rey (`#1E40AF`) hacia Azul Cielo (`#0EA5E9`), mostrando las ventas totales del día en USD y VES, margen estimado y conteo de transacciones.
- **Top de Productos Más Vendidos:** Visualización mediante barras de progreso horizontales tipo píldora, encabezadas por la miniatura circular del producto y el porcentaje de participación en las ventas de la jornada.

### 4.3 Modal Bottom Sheet para Presentaciones, Variantes y Pesables
Al tocar un producto que dispone de múltiples presentaciones (cajas/bultos), variantes de talla/color o venta por peso fraccionado, la aplicación despliega un **Modal Bottom Sheet** con esquinas superiores de `24px`:
- **Selector de Presentación / Variante:** Grupos de botones tipo radio (*Pill Radio Buttons*) mostrando claramente el factor de conversión (ej. `Unidad ($1.50)` vs. `Caja x 12 ($15.00 - Ahorra 16%)`).
- **Control para Pesables:** Teclado numérico táctil integrado o input formateado para balanzas electrónicas (ej. `1.325 kg`).
- **Barra Inferior Fija:** Selector de cantidad `- 1 +` y botón prominente "Agregar a la Orden" con subtotal dinámico actualizado al milisegundo.

---

## 5. Arquitectura Responsiva Multidispositivo y Blindaje Anti-Text-Clipping (Inspirado en 5 Repositorios Open-Source)

Para garantizar legibilidad absoluta y **cero desbordamientos de texto (Zero Text-Clipping)** en resoluciones extremas (desde móviles de 375px hasta monitores 4K y montos largos en Bolívares `Bs. 999.999,99`), la aplicación adopta la ingeniería de 5 repositorios canónicos de Flutter:

### 5.1 Inyección y Referencia de los 5 Repositorios de GitHub
1. **`Codelessly/ResponsiveFramework` (`responsive_framework`)**:
   - Envuelve el árbol en `ResponsiveBreakpoints.builder` con puntos de quiebre canónicos:
     - `MOBILE`: 0 a 600 px
     - `TABLET`: 601 a 900 px
     - `DESKTOP`: 901 a 1440 px
     - `4K`: 1441 px en adelante.
   - Aplica `ResponsiveScaledBox` y `ResponsiveValue` en dispositivos ultra-compactos para escalar armónicamente sin overflow.
2. **`simc/auto_size_text` (`auto_size_text`)**:
   - Reemplaza de forma obligatoria los `Text()` rígidos dentro de píldoras, chips, badges de inventario y etiquetas numéricas por `AutoSizeText` con `minFontSize: 9`, `stepGranularity: 0.5`, `maxLines: 1` y `TextOverflow.ellipsis`.
3. **`letsar/flutter_staggered_grid_view` (`flutter_staggered_grid_view`)**:
   - Reemplaza `GridView` de `childAspectRatio` fijo por `AlignedGridView.extent` o `AlignedGridView.count`. Las tarjetas de productos e indicadores KPI calculan su altura de manera elástica según su contenido exacto, eliminando el corte del texto inferior o de los montos bimoneda.
4. **`gskinnerTeam/flutter-folio` (Patrón de Arquitectura Fluida)**:
   - Prohibición estricta de `width` o `height` fijos en contenedores que alojen texto variable. Empleo de `BoxConstraints(minHeight: ...)` + `Padding` elástico + `FittedBox(fit: BoxFit.scaleDown)` para que los textos nunca se asfixien.
5. **`abuanwar072/Flutter-Responsive-Admin-Panel-or-Dashboard` (`ResponsiveLayout`)**:
   - Helper universal `ResponsiveLayout(mobile: ..., tablet: ..., desktop: ...)` sustentado en `LayoutBuilder` para conmutar limpiamente la distribución espacial de las vistas sin saltos bruscos ni lógica dispersa.

### 5.2 Las 4 Leyes Estrictas de Blindaje de Componentes
- **Ley 1 (Píldoras y Badges Elásticos):** Ninguna píldora (`Container` redondeado) puede tener `height` fijo (ej. `height: 24` o `28` está terminantemente prohibido porque decapita caracteres como `g`, `p`, `q`, `j` o genera *RenderFlex overflow*). Toda píldora o badge debe encapsularse en el widget universal `CleanSoftPill` con `padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)`, `mainAxisSize: MainAxisSize.min`, y contenido de texto en `Flexible` + `AutoSizeText(maxLines: 1)`.
- **Ley 2 (Barras Tipo Píldora del Dashboard `Sweet Crumb`):** En las barras horizontales de *Top Selling Products*, nunca meter el texto (`$XX.XX • XX Unidades`) dentro del ancho coloreado de progreso si el porcentaje es bajo (ej. 15% o 30%), porque el texto se saldría de la píldora. La barra debe construirse como un `Stack` de ancho completo (`100%`) con fondo suave redondeado a `30px`, un `FractionallySizedBox(widthFactor: porcentaje)` en el fondo con el color vibrante, y una capa superior en `Row` con el avatar circular a la izquierda y el texto en `AutoSizeText` con badge de alto contraste, garantizando que el texto **siempre tenga el 100% del ancho del contenedor para respirar y jamás se desborde**.
- **Ley 3 (Precios Bimoneda `$ USD` + `Bs.`):** Todos los montos bimoneda deben estar envueltos en `FittedBox(fit: BoxFit.scaleDown)` o `AutoSizeText` para admitir cifras elevadas en Bolívares sin quebrar las tarjetas de productos, las filas del carrito ni las tablas de cobranza.
- **Ley 4 (Botones de Acción en Paneles Laterales):** En el panel derecho de `Order Details` (botones `Cliente`, `Descuento`, `Pausar`, `Escáner`), usar siempre `Expanded` con `AutoSizeText(maxLines: 1, minFontSize: 9)` e íconos compactos para evitar truncamientos y desbordamientos en resoluciones como `1366x768` o tablets.
