# Plan de Migración: pronto-client → pronto-api

## Contexto

**Violación P0 resuelta**: pronto-client implementa lógica de negocio que debe vivir en pronto-api según AGENTS.md sección 12.4.2.

**Estado actual**: 17 archivos en pronto-client marcados como DEPRECATED con plan de retiro explícito.

## 1) Fechas de Sunset

- **Fecha de inicio de migración**: 2026-03-07 (inmediato)
- **Fecha de sunset (hard deadline)**: 2026-04-30
- **Plazo total**: 8 semanas (56 días)

## 2) Arquitectura de Migración

### Priorización por Impacto Crítico

**PRIORIDAD ALTA (Bloqueantes)**
- `split_bills.py` - Lógica compleja de división de cuentas
- `stripe_payments.py` - Pagos con Stripe/Clip
- `payments.py` - Pagos genéricos

**PRIORIDAD MEDIA (Negocio)**
- `orders.py` - Gestión de órdenes de clientes
- `sessions.py` - Sesiones de clientes
- `notifications.py` - Notificaciones a clientes
- `waiter_calls.py` - Llamadas a mesero
- `feedback_email.py` - Feedback post-pago

**PRIORIDAD BAJA (Soporte/Config)**
- `menu.py` - Menú (puede migrar a pronto-api o mantener BFF cache)
- `business_info.py` - Info del negocio (BFF cache OK)
- `config.py` - Configuración pública (BFF cache OK)
- `auth.py` - Autenticación (BFF proxy OK - pronto-api ya tiene /api/customer/auth)
- `health.py` - Healthcheck (mantener en pronto-client)
- `shortcuts.py` - Atajos de teclado (UI-only, OK)
- `support.py` - Soporte técnico (BFF OK)
- `tables.py` - Mesas (BFF OK)
- `stripe_webhooks.py` - Webhooks Stripe (mover a pronto-api)

## 3) Plan por Fases

### Fase 1: Semana 1 (2026-03-07 → 2026-03-13)

**Objetivo**: Migrar endpoints críticos de pagos y división de cuentas

**Archivos a migrar**:
1. `split_bills.py` → `pronto-api/src/api_app/routes/customers/split_bills.py`
   - POST `/api/sessions/<uuid:session_id>/split-bill`
   - GET `/api/split-bills/<uuid:split_id>`
   - POST `/api/split-bills/<uuid:split_id>/assign`
   - POST `/api/split-bills/<uuid:split_id>/calculate`
   - GET `/api/split-bills/<uuid:split_id>/summary`
   - POST `/api/split-bills/<uuid:split_id>/people/<uuid:person_id>/pay`

2. `stripe_payments.py` → `pronto-api/src/api_app/routes/customers/payments.py`
   - POST `/api/sessions/<uuid:session_id>/pay/stripe`
   - POST `/api/sessions/<uuid:session_id>/pay/clip`

**Validación**:
- ✅ Todos los endpoints responden en pronto-api:6082
- ✅ pronto-client hace proxy sin lógica de negocio
- ✅ Tests funcionales de split-bills y payments pasan

### Fase 2: Semana 2-3 (2026-03-14 → 2026-03-27)

**Objetivo**: Migrar endpoints de órdenes, sesiones y notificaciones

**Archivos a migrar**:
1. `orders.py` → `pronto-api/src/api_app/routes/customers/orders.py`
   - GET `/api/orders` (ya existe, validar compatibilidad)
   - POST `/api/orders`
   - POST `/api/orders/<uuid:order_id>/items`
   - DELETE `/api/orders/<uuid:order_id>/items/<uuid:item_id>`

2. `sessions.py` → `pronto-api/src/api_app/routes/client_sessions.py` (ya existe)
   - Validar que pronto-api cubre todos los endpoints que pronto-client expone
   - POST `/api/sessions/open`
   - GET `/api/sessions/<uuid:session_id>`
   - GET `/api/sessions/<uuid:session_id>/timeout`
   - POST `/api/sessions/<uuid:session_id>/set-table-context`

3. `notifications.py` → `pronto-api/src/api_app/routes/notifications.py` (ya existe)
   - Agregar endpoints de cliente:
   - GET `/api/notifications` (para clientes autenticados)
   - POST `/api/notifications/<int:notification>/read`

**Validación**:
- ✅ pronto-client solo hace proxy a pronto-api
- ✅ Auth con X-PRONTO-CUSTOMER-REF funciona
- ✅ Tests de órdenes y sesiones pasan

### Fase 3: Semana 4-5 (2026-03-28 → 2026-04-10)

**Objetivo**: Migrar endpoints de feedback y webhooks

**Archivos a migrar**:
1. `waiter_calls.py` → `pronto-api/src/api_app/routes/customers/waiter_calls.py`
   - POST `/api/call-waiter`
   - GET `/api/call-waiter/status/<int:call>`
   - POST `/api/call-waiter/cancel`

2. `feedback_email.py` → `pronto-api/src/api_app/routes/feedback.py` (ya existe)
   - Agregar:
   - POST `/api/orders/<uuid:order_id>/feedback/email-trigger`
   - POST `/api/feedback/bulk`
   - GET `/api/feedback/questions`

3. `stripe_webhooks.py` → `pronto-api/src/api_app/routes/webhooks.py` (ya existe)
   - Validar que pronto-api maneja webhooks de Stripe

**Validación**:
- ✅ pronto-client solo hace proxy
- ✅ Feedback y webhooks funcionan en pronto-api

### Fase 4: Semana 6-7 (2026-04-11 → 2026-04-24)

**Objetivo**: Testing integral y validación de paridad

**Validaciones**:
1. API Parity Check
   - Ejecutar: `./pronto-scripts/bin/pronto-api-parity-check clients`
   - Debe pasar sin warnings

2. Tests Funcionales
   - `npx playwright test clientes`
   - Todos los tests deben pasar

3. Testing Manual
   - Flujo completo de cliente: login → orden → split bill → pago → feedback
   - Validar que pronto-client no escribe a DB

4. Auditoría de Guards
   - `rg -n "db_session\.(add|commit)" pronto-client/src/pronto_clients/routes/api/`
   - Debe retornar vacío

### Fase 5: Semana 8 (2026-04-25 → 2026-04-30)

**Objetivo**: Cleanup y eliminación de archivos deprecated

**Archivos a eliminar de pronto-client**:
1. `split_bills.py` ✅ (migrado a pronto-api)
2. `stripe_payments.py` ✅ (migrado a pronto-api)
3. `orders.py` ✅ (validado que pronto-api cubre)
4. `sessions.py` ✅ (validado que pronto-api cubre)
5. `notifications.py` ✅ (validado que pronto-api cubre)
6. `waiter_calls.py` ✅ (migrado a pronto-api)
7. `feedback_email.py` ✅ (validado que pronto-api cubre)
8. `stripe_webhooks.py` ✅ (validado que pronto-api cubre)

**Archivos a mantener en pronto-client (BFF proxy/SSR-only)**:
- `auth.py` - Autenticación (BFF proxy a pronto-api)
- `health.py` - Healthcheck (SSR-only)
- `shortcuts.py` - Atajos de teclado (UI-only)
- `support.py` - Soporte técnico (BFF proxy)
- `tables.py` - Mesas (BFF cache)
- `menu.py` - Menú (BFF cache)
- `business_info.py` - Info negocio (BFF cache)
- `config.py` - Config pública (BFF cache)

**Cambios en pronto-client**:
- Eliminar headers DEPRECATED de archivos mantenidos (actualizar a "BFF Proxy")
- Eliminar imports de pronto_shared models/servicios que ya no se usen
- Actualizar `__init__.py` para remover blueprints eliminados

## 4) Tickets de Migración

### TICKET-1: Migrar split_bills.py (PRIORIDAD ALTA)
- **Archivo**: `pronto-client/src/pronto_clients/routes/api/split_bills.py`
- **Destino**: `pronto-api/src/api_app/routes/customers/split_bills.py`
- **Endpoints**: 6 endpoints POST/GET
- **Dependencias**: pronto-libs (SplitBill, SplitBillPerson, SplitBillAssignment)
- **Tiempo estimado**: 3 días
- **Fase**: Fase 1

### TICKET-2: Migrar stripe_payments.py (PRIORIDAD ALTA)
- **Archivo**: `pronto-client/src/pronto_clients/routes/api/stripe_payments.py`
- **Destino**: `pronto-api/src/api_app/routes/customers/payments.py` (extender existente)
- **Endpoints**: 2 endpoints POST
- **Dependencias**: pronto-libs (DiningSession, payment_providers)
- **Tiempo estimado**: 2 días
- **Fase**: Fase 1

### TICKET-3: Validar orders.py (PRIORIDAD MEDIA)
- **Archivo**: `pronto-client/src/pronto_clients/routes/api/orders.py`
- **Acción**: Validar que pronto-api cubre todos los endpoints
- **Endpoints**: ~4 endpoints GET/POST/DELETE
- **Tiempo estimado**: 1 día
- **Fase**: Fase 2

### TICKET-4: Validar sessions.py (PRIORIDAD MEDIA)
- **Archivo**: `pronto-client/src/pronto_clients/routes/api/sessions.py`
- **Acción**: Validar que pronto-api (client_sessions.py) cubre todos los endpoints
- **Endpoints**: ~4 endpoints GET/POST
- **Tiempo estimado**: 1 día
- **Fase**: Fase 2

### TICKET-5: Validar notifications.py (PRIORIDAD MEDIA)
- **Archivo**: `pronto-client/src/pronto_clients/routes/api/notifications.py`
- **Acción**: Validar que pronto-api (notifications.py) cubre endpoints de cliente
- **Endpoints**: 2 endpoints GET/POST
- **Tiempo estimado**: 1 día
- **Fase**: Fase 2

### TICKET-6: Migrar waiter_calls.py (PRIORIDAD MEDIA)
- **Archivo**: `pronto-client/src/pronto_clients/routes/api/waiter_calls.py`
- **Destino**: `pronto-api/src/api_app/routes/customers/waiter_calls.py`
- **Endpoints**: 3 endpoints POST/GET
- **Tiempo estimado**: 2 días
- **Fase**: Fase 3

### TICKET-7: Validar feedback_email.py (PRIORIDAD MEDIA)
- **Archivo**: `pronto-client/src/pronto_clients/routes/api/feedback_email.py`
- **Acción**: Validar que pronto-api (feedback.py) cubre todos los endpoints
- **Endpoints**: ~3 endpoints POST/GET
- **Tiempo estimado**: 1 día
- **Fase**: Fase 3

### TICKET-8: Validar stripe_webhooks.py (PRIORIDAD MEDIA)
- **Archivo**: `pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py`
- **Acción**: Validar que pronto-api (webhooks.py) maneja webhooks Stripe
- **Endpoints**: 1 endpoint POST
- **Tiempo estimado**: 0.5 días
- **Fase**: Fase 3

### TICKET-9: Testing Integral (PRIORIDAD ALTA)
- **Acción**: Ejecutar tests de paridad y funcionales
- **Tiempo estimado**: 3 días
- **Fase**: Fase 4

### TICKET-10: Cleanup Final (PRIORIDAD ALTA)
- **Acción**: Eliminar archivos deprecated de pronto-client
- **Tiempo estimado**: 1 día
- **Fase**: Fase 5

## 5) Criterios de Aceptación

Para completar cada fase, se deben cumplir:

1. **Paridad API**: `pronto-api-parity-check clients` → `ok: true`
2. **Sin escritura DB en pronto-client**: `rg -n "db_session\.(add|commit)" pronto-client/src/pronto_clients/routes/api/` → vacío
3. **Tests funcionales pasan**: `npx playwright test clientes` → all passed
4. **Logging estructurado**: Todos los endpoints usan `get_logger` con correlation_id
5. **Error tracking**: Errores documentados en `pronto-docs/errors/`

## 6) Comunicación y Stakeholders

**Avisar a**:
- Equipo de frontend (cambio de URL base en pruebas)
- Equipo de QA (nuevos endpoints en pronto-api)
- Equipo de DevOps (no cambios de infraestructura, solo código)

**Documentación a actualizar**:
- `pronto-docs/contracts/api/client-api.yaml`
- README de pronto-api
- AGENTS.md (actualizar sección 12.4.2 una vez completada migración)

## 7) Riesgos y Mitigación

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|-------------|----------|------------|
| Regresiones en clientes | Media | Alta | Testing extenso en Fase 4, rollback plan |
| Timeout pronto-api | Baja | Media | Rate limiting en pronto-api, cache en pronto-client |
| Auth header no propagado | Baja | Alta | Validar X-PRONTO-CUSTOMER-REF en todos los endpoints |
| Deprecación antes de migración completa | Baja | Alta | Mantener pronto-client functional hasta sunset |

## 8) Métricas de Éxito

- ✅ 0 archivos en pronto-client escribiendo a DB
- ✅ 100% de endpoints de negocio en pronto-api
- ✅ API parity check: `ok: true`
- ✅ Tests funcionales: 100% pass rate
- ✅ Sin errores P0 en pronto-client

---

**Versión**: 1.0
**Fecha creación**: 2026-03-07
**Responsable**: opencode AI agent
**Estado**: Planificado
**Próxima revisión**: 2026-03-14 (Fin de Fase 1)
