ID: PROMPT-24
FECHA: 2026-02-17
PROYECTO: PRONTO-System
SEVERIDAD: alta
TITULO: PROMPT 24 - Contratos Publicos y API Parity

DESCRIPCION:
Falta crear prompt para implementar contratos publicos y validacion de API parity.

CONTENIDO PROMPT:

```
Implementa el sistema de contratos publicos y API parity para PRONTO:

API CANONICA (/api) - REGLAS:

1. Regla canonica por host:
   - Unica ruta canonica de API: "/api/*"
   - Resolution por host:
     * employees.<dominio>/api/* → pronto-employees
     * clients.<dominio>/api/* → pronto-client
   - Prohibido implementar/documentar/depender de "/{scope}/api/*"

2. Frontend employees (pronto-static) — wrapper obligatorio (P0):
   - Toda llamada a "/api/*" debe ser relativa (sin host hardcode)
   - Prohibido mutar "/api/*" fuera de:
     pronto-static/src/vue/employees/core/http.ts
   - Canon: credentials: 'include'
   - Prohibido: credentials: 'same-origin'

3. CSRF canonico employees (P0):
   - Fuente token: <meta name="csrf-token" ...>
   - Header: X-CSRFToken
   - Toda mutacion a "/api/*" incluye X-CSRFToken (incluye FormData)
   - Si falta meta tag y se intenta mutar ⇒ wrapper falla loud (throw)

4. Autenticacion clientes (P0):
   - pronto-client → pronto-api debe usar header: X-PRONTO-CUSTOMER-REF

5. Tipos de parametros en rutas (P0):
   - Entidades principales (Customer, Employee, DiningSession, Order, Table, MenuItem, Modifier, etc.) deben usar UUID
   - Solo entidades de lookup/tecnicas usan Integer: Area, Role, DiscountCode, Promotion, ProductSchedule, WaiterCall, Notification
   - Flask route converters: usar <uuid:id> para entidades UUID, <int:id> solo para Integer
   - No usar <str:id> para IDs; usar converters explicitos
   - Validar contra el modelo: si el modelo usa UUID(as_uuid=True), la ruta debe usar <uuid:id>
   - Servicios permitidos de Integer IDs:
     - pronto-employees: Area, Role, DiscountCode, Promotion, ProductSchedule, WaiterCall, AdminShortcut

6. Gate de validacion de tipos (P0):
   - Ejecutar para validar:
     # Verificar que no haya <int:> para entidades UUID
     rg -n --hidden "/<int:[a-z_]+_id>" pronto-employees/src/pronto_employees/routes/api/
     rg -n --hidden "/<int:[a-z_]+_id>" pronto-client/src/pronto_clients/routes/api/
   - Si produce output ⇒ REJECTED

CONTRATOS PUBLICOS:

Estructura en pronto-docs/contracts/<mod>/

1. openapi.yaml (si aplica)
2. redis_keys.md
3. events.md
4. db_schema.sql (generado con pg_dump --schema-only)
5. files.md (si aplica)
6. cookies.md / csrf.md (si aplica)

SCRIPTS DE PARITY:

1. pronto-api-parity-check employees
   - Valida que todos los endpoints de employees esten implementados
   - Compara con OpenAPI specs
   - Reporta missing endpoints

2. pronto-api-parity-check clients
   - Valida que todos los endpoints de clients esten implementados
   - Compara con OpenAPI specs
   - Reporta missing endpoints

Entrega:
- Script de validacion de tipos de parametros
- Scripts de parity check
- Estructura de contratos
- Documentacion de API canonica
```

PASOS_REPRODUCIR:
1. Ejecutar `./pronto-scripts/bin/pronto-api-parity-check clients`
2. Ejecutar `./pronto-scripts/bin/pronto-api-parity-check employees`
3. Ejecutar:
   - `rg -n --hidden "/<int:[a-z_]+_id>" pronto-employees/src/pronto_employees/routes/api/`
   - `rg -n --hidden "/<int:[a-z_]+_id>" pronto-client/src/pronto_clients/routes/api/`

RESULTADO_ACTUAL:
- `pronto-api-parity-check clients` retorna `ok: true`
- `pronto-api-parity-check employees` retorna `ok: true`
- El gate de converters `/<int:[a-z_]+_id>` no retorna coincidencias en rutas API de client/employees.

RESULTADO_ESPERADO:
Paridad API validada para clients/employees y cumplimiento de gate de tipos de parámetros.

UBICACION:
- pronto-scripts/bin/pronto-api-parity-check
- pronto-client/src/pronto_clients/routes/api/
- pronto-employees/src/pronto_employees/routes/api/
- pronto-static/src/vue/clients/store/orders.ts
- pronto-static/src/vue/employees/core/http.ts

EVIDENCIA:
Validaciones ejecutadas el 2026-02-18 con salida `ok: true` para ambos parity checks y sin matches en el gate regex de converters.

HIPOTESIS_CAUSA:
Desalineaciones acumuladas entre rutas frontend/backend y naming histórico de parámetros `int` con sufijo `_id`.

ESTADO: RESUELTO
SOLUCION:
Se alinearon endpoints frontend/backend a la ruta canónica `/api/*`, se agregó compatibilidad faltante en client API (`POST /api/login`, `GET /api/session/<uuid:session_id>/timeout`), se corrigieron llamadas en módulos Vue y se normalizaron converters int para eliminar matches del gate de tipos.

COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
