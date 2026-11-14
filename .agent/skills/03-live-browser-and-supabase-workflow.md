# Flujo Operativo Autónomo: Supabase Direct Control & Live Browser QA

## 1. Misión del Flujo Autónomo
Este protocolo establece las reglas estrictas de operación para el Agente AI como Ingeniero de Software Principal. El objetivo es eliminar cualquier suposición teórica: **cada cambio de base de datos debe reflejarse en vivo en Supabase y cada interfaz debe ser validada visualmente en un navegador real antes de darse por completada**.

---

## 2. Protocolo de Base de Datos: Supabase Direct Control

### 2.1 Principio de Fuente Única y Versionado SQL
- La carpeta [`supabase/migrations/`](file:///d:/proyectos/azulito/supabase/migrations) constituye la fuente canónica e inmutable del esquema relacional.
- Todo cambio estructural (creación de tablas, nuevas columnas, índices, tipos `ENUM`, triggers o políticas RLS) debe plasmarse en un archivo SQL con convención de nombres estándar:
  ```
  supabase/migrations/<TIMESTAMP>_<nombre_descriptivo_snake_case>.sql
  ```
  *Ejemplo:* `20261113005500_create_sales_and_payments.sql`

### 2.2 Sincronización Simultánea con Drift (SQLite Local)
- No puede existir discrepancia entre la base de datos remota y la local.
- Por cada migración escrita en `supabase/migrations/`, debe actualizarse en paralelo la definición correspondiente en las tablas de **Drift** (`lib/core/database/tables/` o `app_database.dart`), garantizando equivalencia exacta de nombres de campo, tipos de datos y restricciones de nulidad.

### 2.3 Ejecución Autónoma vía Supabase MCP
El agente utilizará las herramientas del servidor **Supabase MCP** para aplicar los cambios de manera directa e inmediata:
1. **Aplicar Migración DDL:** Invocar la herramienta `apply_migration` indicando `project_id`, el nombre de la migración y la consulta SQL completa.
2. **Seguridad RLS Obligatoria:** Toda tabla creada debe tener activado Row Level Security de forma innegociable:
   ```sql
   ALTER TABLE public.<nombre_tabla> ENABLE ROW LEVEL SECURITY;
   ```
   Acompañado de sus políticas `CREATE POLICY` correspondientes para usuarios autenticados y aislamiento por comercio/tienda.
3. **Auditoría Post-Migración:** Comprobar la existencia y estructura mediante `list_tables` con `verbose: true`.
4. **Regeneración de Tipos:** Ejecutar `generate_typescript_types` o regenerar los modelos Dart para asegurar sincronía estricta de tipos.

---

## 3. Protocolo de Verificación Visual: Live Browser QA (Playwright MCP)

### 3.1 Servidor de Previsualización Web
Para validar en tiempo real cada funcionalidad visual y flujo de usuario, la aplicación se ejecuta en modo web mediante:
```powershell
flutter run -d web-server --web-port 8080
```
- **Abstracción Multiplataforma:** Para garantizar que el proyecto compile y ejecute fluidamente en el servidor web sin errores causados por dependencias nativas de escritorio/móvil (como `sqflite`, impresoras térmicas ESC-POS de hardware o lectores serie), el código debe emplear interfaces y clases abstractas con exportaciones condicionales (`kIsWeb`), utilizando adaptadores web (ej. `WasmDatabase` de Drift o mocks de desarrollo para impresoras).

### 3.2 Pruebas Automatizadas con Playwright MCP
El agente se conectará autónomamente a `http://localhost:8080` utilizando las herramientas del servidor **Playwright MCP**:
- `browser_navigate`: Abrir la URL del servidor local.
- `browser_resize`: Forzar dimensiones de prueba específicas.
- `browser_snapshot`: Inspeccionar el árbol de accesibilidad y elementos interactivos para verificar que los botones, campos de texto y listas respondan.
- `browser_click` / `browser_fill_form`: Simular interacciones completas (agregar productos al carrito, alternar métodos de pago, aplicar descuentos).
- `browser_take_screenshot`: Capturar evidencia visual de los componentes renderizados. **Regla de orden:** Todas las capturas deben guardarse obligatoriamente dentro de `docs/screenshots/<nombre>.png`, nunca en la raíz del proyecto.

### 3.3 Matriz de Inspección de Resoluciones Obligatoria
Toda nueva vista o componente debe verificarse sin excepción en dos factores de forma:
1. **Resolución Desktop / PC (`1366 x 768` px):**
   - Verificar que el diseño de 3 columnas (Categorías, Grilla, Carrito) se distribuya con proporciones armónicas.
   - Constatar que no aparezcan barras de desplazamiento generales en la ventana principal (solo en las columnas interiores).
   - Validar que el botón de cobro y los totales duales (USD / Bs) permanezcan siempre visibles en el viewport.
2. **Resolución Móvil (`390 x 844` px):**
   - Verificar la correcta posición del *Floating Pill Dock* inferior sin solapar contenido.
   - Comprobar que los *Bottom Sheets* se abran con suavidad y tengan áreas táctiles de al menos `48 x 48` px.

### 3.4 Criterios de Aceptación y "Zero Defect"
Una tarea o historia de usuario **nunca** se considerará concluida si se presenta cualquiera de las siguientes condiciones:
- **RenderFlex Overflows:** Cualquier franja amarilla y negra de desbordamiento en la interfaz o mensaje `A RenderFlex overflowed by X pixels on the bottom/right` en la consola.
- **Errores de Consola:** Advertencias no controladas o excepciones JavaScript en `browser_console_messages`.
- **Fallas de Conexión:** Errores de red o rechazos de políticas RLS al comunicar con Supabase.
- **Desajustes de Tipografía o Contraste:** Textos ilegibles o botones con padding inconsistente respecto a la guía de estilo *Clean Soft UI*.

