# AUDITORÍA COMPLETA: pronto-api

**Fecha:** 2026-02-12  
**Auditor:** Pronto-Guardrails-Agent + Pronto-API-Agent  
**Alcance:** Todo `pronto-api/src/api_app/`  
**Versión:** 1.0.0

---

## PARTE 1: HALLAZGOS DE AUDITORÍA (AGENTS.md Compliance)

### ✅ CUMPLIMIENTOS

| Regla | Estado | Evidencia |
|---|---|---|
| P0-5: No `flask.session` en pronto-api | ✅ OK | Zero ocurrencias |
| P0-7: Auth = JWT | ✅ OK | `jwt_required`, `jwt_optional` en todos los endpoints |
| P0-8: Estáticos en pronto-static | ✅ OK | Ningún estático local |
| P0-11: Roles canónicos | ✅ OK | Solo `waiter`, `chef`, `cashier`, `admin`, `system` |
| P0-13: No DDL runtime | ✅ OK | Zero DDL en routes |
| P0-12: Ruta canónica `/api/*` | ✅ OK | Todas las rutas bajo `/api/` |
| P0-17: Requirements.txt única fuente | ✅ OK | Solo `requirements.txt` en raíz |
| PRONTO_ROUTES_ONLY | ✅ OK | Correcta separación `routes_only` vs `init_runtime` |

### ⚠️ VIOLACIONES / RIESGOS

| # | Sev | Regla | Archivo | Problema |
|---|---|---|---|---|
| 1 | 🔴 CRÍTICO | Seguridad | `reset_all.py` | Contraseña hardcodeada `"pronto"`, credenciales system hardcodeadas. Script puede correr en cualquier entorno |
| 2 | 🔴 CRÍTICO | Seguridad | `reset_maria.py` | Hash hardcodeado, imprime salt de seguridad a stdout (L70) |
| 3 | 🟠 ALTO | P0-8 / Scripts | `reset_all.py`, `reset_maria.py`, `list_employees.py` | Scripts operativos dentro de `src/api_app/` en vez de `pronto-scripts/bin` (viola §8) |
| 4 | 🟠 ALTO | Duplicación | `routes/employees/roles.py` vs `routes/employees/employees.py` | Roles CRUD duplicado: ambos definen `/roles`, `/roles/<id>`, `/roles/<id>/permissions/bulk` — colisión de rutas |
| 5 | 🟠 ALTO | Duplicación | `routes/promotions.py` vs `routes/employees/promotions.py` | Ambos registran `/api/promotions` — colisión |
| 6 | 🟠 ALTO | Duplicación | `routes/modifiers.py` vs `routes/employees/modifiers.py` | Ambos registran `/api/modifiers` — colisión |
| 7 | 🟠 ALTO | Duplicación | `routes/feedback.py` vs `routes/employees/feedback.py` | Ambos registran `/api/feedback/stats/*` — colisión |
| 8 | 🟠 ALTO | Duplicación | `routes/analytics.py` vs `routes/employees/analytics.py` | Ambos registran `/api/analytics/*` — colisión |
| 9 | 🟠 ALTO | Duplicación | `routes/sessions.py` vs `routes/employees/sessions.py` | Ambos registran `/api/sessions/*` — colisión |
| 10 | 🟠 ALTO | Duplicación | `routes/admin.py` vs `routes/employees/admin.py` | Ambos registran `/api/admin/*` — colisión |
| 11 | 🟠 ALTO | Duplicación | `routes/config.py` vs `routes/employees/config.py` | Ambos registran `/api/config/*` — colisión |
| 12 | 🟠 ALTO | Duplicación | `routes/customers.py` vs `routes/employees/customers.py` | Ambos registran `/api/customers/*` — colisión |
| 13 | 🟡 MEDIO | Stub | `branding.py` | Registrado en `__init__.py` (L66 dice "removed") pero el archivo existe y tiene rutas activas |
| 14 | 🟡 MEDIO | feature_flags.py | `feature_flags.py` vs `app.py` | `_is_api_isolation_enabled()` duplicada en `app.py:31-38` y `feature_flags.py:11-21` |
| 15 | 🟡 MEDIO | Seguridad | `client_auth.py:19` | Cookie domain hardcodeado `.pronto.com` — no funciona en dev/localhost |
| 16 | 🟡 MEDIO | Seguridad | `client_sessions.py:16` | Misma duplicación de cookie domain hardcodeado |
| 17 | 🟡 MEDIO | Consistencia | `orders.py:34` | `Blueprint("orders", "__name__")` — string literal en vez de `__name__` |
| 18 | 🟡 MEDIO | Stub endpoints | Múltiples | ~30 endpoints devuelven datos vacíos/hardcodeados sin implementación real |
| 19 | 🟡 MEDIO | Seguridad Auth | `employees/auth.py:179` | `except Exception` en refresh expone mensaje de error interno al cliente |
| 20 | 🟡 MEDIO | `success_response` | `menu.py:48` | Llama `success_response()` importado no existente (no importado en el archivo) |
| 21 | 🔵 BAJO | Cookie duplicación | `client_auth.py` vs `client_sessions.py` | `ACCESS_COOKIE_OPTS` definido idéntico en 2 archivos |

---

## PARTE 2: MAPA DE LÓGICA DE NEGOCIO (Estado Actual)

### Dominio 1: Gestión de Órdenes (CORE — ~70% implementado)

```
WORKFLOW DE ÓRDENES:
  pending → confirmed → preparing → ready → served → delivered → paid → closed
                                                                    ↓
                                                              cancelled
```

| Operación | Ruta | Estado | Actor |
|---|---|---|---|
| Crear orden (cliente) | `POST /api/orders` | ✅ Implementado | client JWT |
| Crear orden (empleado) | `POST /api/orders` (employees) | ✅ Implementado | waiter, cashier, admin |
| Listar órdenes | `GET /api/orders` | ✅ Implementado | employee |
| Detalle orden (employee) | `GET /api/orders/<id>` | ✅ Implementado | employee |
| Detalle orden (client) | `GET /api/orders/<id>` | ⚠️ STUB (devuelve `{}`) | client |
| Aceptar orden | `POST /api/orders/<id>/accept` | ✅ Implementado | waiter, admin |
| Iniciar cocina | `POST /api/orders/<id>/kitchen/start` | ✅ Implementado | chef, admin |
| Listo cocina | `POST /api/orders/<id>/kitchen/ready` | ✅ Implementado | chef, admin |
| Servir | `POST /api/orders/<id>/serve` | ✅ Implementado | waiter, admin |
| Entregar | `POST /api/orders/<id>/deliver` | ✅ Implementado | waiter, admin |
| Entregar items parcial | `POST /api/orders/<id>/deliver-items` | ✅ Implementado | waiter, admin |
| Cancelar (employee) | `POST /api/orders/<id>/cancel` | ✅ Implementado | any employee |
| Cancelar (client) | `POST /api/orders/<id>/cancel` | ✅ Implementado | client |
| Forzar cancelación | `POST /api/admin/orders/<id>/force-cancel` | ✅ Implementado | admin, system |
| Solicitar cuenta | `POST /api/orders/<id>/request-check` | ✅ Implementado | client, employee |
| Modificar orden | `POST /api/orders/<id>/modify` | ✅ Implementado | client, waiter |
| Aprobar modificación | `POST /api/modifications/<id>/approve` | ✅ Implementado | customer |
| Rechazar modificación | `POST /api/modifications/<id>/reject` | ✅ Implementado | customer |
| Notas | `POST /api/orders/<id>/notes` | ✅ Implementado | employee |
| Búsqueda órdenes | `GET /api/orders/search` | ⚠️ STUB | employee |
| Table rows | `GET /api/orders/table-rows` | ⚠️ STUB | employee |
| Delivery status (client) | `GET /api/orders/<id>/delivery-status` | ⚠️ STUB | client |
| Imprimir | `POST /api/orders/<id>/print` | ⚠️ STUB | client |
| Marcar recibido | `POST /api/orders/<id>/received` | ⚠️ STUB | client |

### Dominio 2: Sesiones de Comida (Dining Sessions — ~80% implementado)

| Operación | Ruta | Estado | Actor |
|---|---|---|---|
| Abrir sesión | `POST /api/sessions/open` | ✅ Implementado | client |
| Cerrar sesión (client) | `POST /api/sessions/close` | ✅ Implementado | client |
| Validar sesión | `POST /api/sessions/validate` | ✅ Implementado | client |
| Me (source of truth) | `GET /api/sessions/me` | ✅ Implementado | client |
| Listar sesiones activas | `GET /api/sessions/all` | ✅ Implementado | employee |
| Detalle sesión | `GET /api/sessions/<id>` | ✅ Implementado | employee |
| Pagar sesión | `POST /api/sessions/<id>/pay` | ✅ Implementado | cashier, admin |
| Confirmar pago | `POST /api/sessions/<id>/confirm-payment` | ✅ Implementado | waiter, admin |
| Propina | `POST /api/sessions/<id>/tip` | ✅ Implementado | cashier, admin |
| Checkout | `POST /api/sessions/<id>/checkout` | ✅ Implementado | employee |
| Cerrar sesión (admin) | `POST /api/sessions/<id>/close` | ✅ Implementado | admin |
| Ticket PDF | `GET /api/sessions/<id>/ticket.pdf` | ✅ Implementado | employee |
| Ticket HTML | `GET /api/sessions/<id>/ticket` | ✅ Implementado | employee |
| Reenviar ticket email | `POST /api/sessions/<id>/resend` | ✅ Implementado | cashier, admin |
| Reimprimir ticket | `POST /api/sessions/<id>/reprint` | ✅ Implementado | cashier, admin |
| Session timeout (client) | `GET /api/session/<id>/timeout` | ⚠️ STUB | client |

### Dominio 3: Menú y Productos (~60% implementado)

| Operación | Ruta | Estado | Actor |
|---|---|---|---|
| Menú público | `GET /api/menu` / `/products` / `/menu-items` | ✅ Implementado | public |
| Menú empleados | `GET /api/menu` (employees) | ✅ Implementado | employee |
| Crear item | `POST /api/menu-items` | ✅ Implementado | admin |
| Editar item | `PUT /api/menu-items/<id>` | ✅ Implementado | admin |
| Eliminar item | `DELETE /api/menu-items/<id>` | ✅ Implementado | admin |
| Popular items | `GET /api/menu-items/popular` | ⚠️ STUB | public |
| Recommendations | `GET /api/menu-items/recommendations` | ⚠️ STUB | public |
| Detalle item | `GET /api/menu-items/<id>` | ⚠️ STUB | public |
| Prep time | `PATCH /api/menu-items/<id>/preparation-time` | ⚠️ STUB | admin |
| Item schedules | `GET /api/menu-items/<id>/schedules` | ⚠️ STUB | admin |
| Product schedules CRUD | `/api/product-schedules` | ⚠️ STUB | admin |

### Dominio 4: Auth (~90% implementado)

| Operación | Ruta | Estado | Actor |
|---|---|---|---|
| Login employee | `POST /api/employees/auth/login` | ✅ Implementado | public |
| Refresh token | `POST /api/employees/auth/refresh` | ✅ Implementado | employee |
| Revoke token | `POST /api/employees/auth/revoke` | ✅ Implementado | employee |
| Register client | `POST /api/client-auth/register` | ✅ Implementado | public |
| Login client | `POST /api/client-auth/login` | ✅ Implementado | public |
| Logout client | `POST /api/client-auth/logout` | ✅ Implementado | client |

### Dominio 5: Empleados CRUD (~85% implementado)

Completamente funcional: list, create, get, update, delete, search, preferences.  
Roles CRUD funcional pero duplicado en 2 lugares (ver hallazgo #4).

### Dominio 6: Mesas y Áreas (~95% implementado)

Completamente funcional: CRUD tablas, CRUD áreas, asignación de mesas a waiters, transferencias de mesas.

### Dominio 7: Notificaciones y Realtime (~90% implementado)

Waiter calls (create, pending, confirm), admin calls, order events stream, notification events stream — todo implementado.

### Dominio 8: Modifiers (~85% implementado — pero duplicado)

CRUD grupos + CRUD modifiers funcional, pero existe en 2 rutas (hallazgo #6).

### Dominio 9: Analytics y Reports

- **Reports** (`routes/reports.py`): ✅ Implementado — KPIs, sales, top products, peak hours, waiter tips, waiter performance, category performance, customer segments, operational metrics
- **Analytics** (`routes/employees/analytics.py`): ⚠️ Mayormente STUBS excepto KPIs

### Dominio 10: Funcionalidades STUB (sin implementar)

| Feature | Archivos | Estado |
|---|---|---|
| Branding (AI generation) | `branding.py`, `employees/api_branding.py:generate_*` | 🔴 NOT_IMPLEMENTED |
| Discount codes | `employees/discount_codes.py` | 🔴 STUB |
| Product schedules | `employees/product_schedules.py` | 🔴 NOT_IMPLEMENTED |
| Debug orders | `employees/debug.py` | 🔴 NOT_IMPLEMENTED |
| Business info | `employees/business_info.py` | 🔴 STUB |
| Config management | `employees/config.py` | 🔴 STUB |
| Admin shortcuts | `employees/admin.py` | 🔴 STUB |
| Permissions system | `employees/admin.py:permissions` | 🔴 STUB |
| Promotions CRUD (employees) | `employees/promotions.py` | 🔴 NOT_IMPLEMENTED |

---

## PARTE 3: PLAN DE LÓGICA DE NEGOCIO Y UX

### 3.1 Prioridades Inmediatas (P0 — Bugs/Seguridad)

#### 3.1.1 Resolver colisiones de rutas Blueprint
**Problema:** Flask registra ambos blueprints en `/api/*` causando rutas ambiguas o sobrescritas.  
**Plan:**
1. Decidir cuál blueprint es canónico (core vs employees)
2. Eliminar el duplicado o separar prefijos (`/api/employees/promotions` vs `/api/promotions`)
3. Afecta: promotions, modifiers, feedback, analytics, sessions, admin, config, customers, roles

#### 3.1.2 Mover scripts operativos a `pronto-scripts/bin`
- `reset_all.py` → `pronto-scripts/bin/pronto-reset-passwords`
- `reset_maria.py` → `pronto-scripts/bin/pronto-reset-maria`  
- `list_employees.py` → `pronto-scripts/bin/pronto-list-employees`
- Agregar guard: solo correr si `PRONTO_ENV in {dev, test}`

#### 3.1.3 Cookie domain configurable
Extraer `ACCESS_COOKIE_OPTS` a `pronto-libs` con domain desde env var:
```python
COOKIE_DOMAIN = os.getenv("COOKIE_DOMAIN", ".pronto.com")
```

#### 3.1.4 Fix `menu.py` import faltante
Agregar `from pronto_shared.serializers import success_response` en `routes/menu.py`.

---

### 3.2 Completar Features STUB (P1 — Valor de negocio)

#### Tier 1: Impacto directo en operación del restaurante
| Feature | Valor | Esfuerzo | Prioridad |
|---|---|---|---|
| Detalle orden (client) | Cliente puede ver su orden completa | Bajo | 🔥 Alta |
| Popular items / Recommendations | Ventas cruzadas, mayor ticket promedio | Medio | 🔥 Alta |
| Order search (employee) | Eficiencia operativa | Medio | 🔥 Alta |
| Delivery status tracking | UX del cliente | Medio | 🔥 Alta |
| Business info CRUD | Admin configura info del restaurante | Bajo | Alta |
| Config management | Admin gestiona parámetros del sistema | Medio | Alta |

#### Tier 2: Crecimiento y retención
| Feature | Valor | Esfuerzo | Prioridad |
|---|---|---|---|
| Discount codes CRUD | Campañas de marketing | Medio | Media |
| Promotions CRUD (employees) | Gestión de promociones | Medio | Media |
| Product schedules | Menú por horario (desayuno/almuerzo/cena) | Medio | Media |
| Analytics completos (employees) | Decisiones basadas en datos | Alto | Media |

#### Tier 3: Diferenciación
| Feature | Valor | Esfuerzo | Prioridad |
|---|---|---|---|
| AI branding generation | Branding automatizado | Alto | Baja |
| Customer feedback completo | NPS, satisfacción | Medio | Media |
| Admin shortcuts | Productividad admin | Bajo | Baja |

---

### 3.3 Plan UX por Rol

#### 🧑‍🍳 WAITER (Mesero)
**Flujo principal:**
```
Login → Ver mesas asignadas → Tomar orden → Seguir estado en cocina → Servir → Entregar
```
**Gaps UX identificados:**
- ❌ No hay búsqueda de órdenes (stub) — el mesero no puede encontrar órdenes pasadas
- ❌ No hay vista "table-rows" (stub) — no puede ver resumen por mesa
- ✅ Transferencia de mesas funciona bien
- ✅ Notificaciones waiter calls funcionan

#### 👨‍🍳 CHEF (Cocinero)
**Flujo principal:**
```
Login → Ver órdenes pendientes → Iniciar preparación → Marcar lista
```
**Gaps UX:**
- ✅ Flujo completo funcional
- ❌ No hay vista de tiempos de preparación reales vs estimados (prep-time stub)

#### 💰 CASHIER (Cajero)
**Flujo principal:**
```
Login → Ver sesiones activas → Checkout → Procesar pago → Propina → Ticket
```
**Gaps UX:**
- ✅ Flujo de pago completo
- ✅ Tickets (PDF, email, reprint)
- ❌ Discount codes no implementados — cajero no puede aplicar descuentos

#### 👔 ADMIN
**Flujo principal:**
```
Login → Dashboard KPIs → Gestionar menú → Gestionar empleados → Reports → Config
```
**Gaps UX:**
- ❌ Business info es stub — no puede configurar datos del restaurante
- ❌ Config management es stub — no puede ajustar parámetros
- ❌ Analytics parcialmente stub — solo KPIs básicos del día
- ❌ Promotions employees es stub — no puede crear/editar/eliminar promociones
- ❌ Admin shortcuts es stub
- ❌ Permissions system es stub
- ✅ Reports funciona bien (sales, peak hours, waiter tips, etc.)
- ✅ Employee CRUD funciona
- ✅ Menu CRUD funciona
- ✅ Modifiers CRUD funciona

#### 📱 CLIENT (Comensal)
**Flujo principal:**
```
Escanear QR → Abrir sesión → Ver menú → Ordenar → Seguir estado → Pedir cuenta
```
**Gaps UX:**
- ❌ Detalle de orden es stub — cliente no ve su orden
- ❌ Delivery status es stub — no puede rastrear estado
- ❌ Popular items / Recommendations son stubs — pierde oportunidad de venta
- ❌ Item detail es stub — no puede ver detalle del producto
- ❌ "Marcar recibido" es stub
- ✅ Registro/login funcional
- ✅ Abrir/cerrar sesión funcional
- ✅ Crear orden funcional
- ✅ Llamar mesero funcional
- ✅ Solicitar cuenta funcional

---

### 3.4 Roadmap Recomendado

```
FASE 1 (Inmediato — 1-2 semanas):
├── Fix colisiones de blueprints
├── Mover scripts a pronto-scripts/bin
├── Fix cookie domain configurable
├── Fix menu.py import
└── Implementar order detail (client)

FASE 2 (Corto plazo — 2-4 semanas):
├── Implementar order search
├── Implementar delivery status tracking
├── Implementar popular items + recommendations
├── Implementar item detail
├── Implementar business info CRUD
└── Implementar config management

FASE 3 (Medio plazo — 1-2 meses):
├── Implementar discount codes CRUD
├── Conectar promotions employees con promotions core
├── Implementar product schedules
├── Completar analytics employees (usar AnalyticsService existente)
└── Implementar customer feedback completo

FASE 4 (Largo plazo):
├── AI branding generation
├── Admin shortcuts
└── Permissions system granular
```

---

## RESUMEN EJECUTIVO

| Métrica | Valor |
|---|---|
| Endpoints totales | ~120 |
| Implementados | ~75 (62%) |
| Stubs | ~45 (38%) |
| Colisiones de rutas | 9 pares duplicados |
| Violaciones AGENTS.md | 3 (scripts fuera de lugar) |
| Riesgos seguridad | 3 (scripts con secrets, cookie domain, error exposure) |
| Dominios funcionales | 10 |
| Dominios >80% completos | 6 de 10 |

**Veredicto general:** El core operativo (órdenes, sesiones, pagos, auth, mesas) está sólido. Los mayores problemas son las **colisiones de blueprints duplicados** y la cantidad de **stubs sin implementar** que afectan principalmente al flujo del **cliente (comensal)** y al **admin dashboard**.
