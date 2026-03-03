# PRONTO FULL AUDIT CHECKLIST
## Auditoría Comprehensiva de Archivos

**Fecha:** 2026-02-18  
**Auditor:** Sistema de Auditoría PRONTO

---

## 📋 RESUMEN EJECUTIVO

| Proyecto | Archivos Python | Archivos Vue/TS | Estado |
|----------|-----------------|-----------------|--------|
| pronto-api | 42 | N/A | ✅ Passed |
| pronto-employees | 45 | N/A | ✅ Passed |
| pronto-client | 25 | N/A | ✅ Passed |
| pronto-static | N/A | 89 Vue + 92 TS | ✅ Passed |

---

## 🎯 RESULTADOS DE AUDITORÍA (2026-02-18)

### ✅ VERIFICACIONES PASSED

| Verificación | pronto-api | pronto-employees | pronto-client | pronto-static |
|-------------|------------|------------------|---------------|---------------|
| flask.session PROHIBIDO | ✅ PASS | ✅ PASS | N/A | N/A |
| JWT Obligatorio | ✅ PASS | ✅ PASS | N/A | N/A |
| Estáticos en pronto-static | ✅ PASS* | ✅ PASS* | ✅ PASS* | ✅ PASS |
| Order State Authority | ✅ PASS | N/A | N/A | N/A |
| DDL Runtime PROHIBIDO | ✅ PASS | N/A | N/A | N/A |
| Roles Canónicos | ✅ PASS | ✅ PASS | N/A | N/A |
| X-PRONTO-CUSTOMER-REF | N/A | N/A | ✅ PASS | N/A |
| Context Variables | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS |
| Composables | N/A | N/A | N/A | ✅ PASS |
| Correlation ID | ✅ PASS | N/A | N/A | N/A |
| Health Endpoint | ✅ PASS | N/A | N/A | N/A |
| USER_MESSAGES | ✅ PASS | N/A | N/A | N/A |

*Context variables para assets son válidas (son passed de Flask a templates)

### ⚠️ WARNINGS (Revisar manualmente)

| Proyecto | Warning | Archivo |
|----------|---------|---------|
| pronto-api | `<int:>` para entidades UUID | Varias rutas |
| pronto-employees | `<int:>` para entidades UUID | Varias rutas |
| pronto-client | Templates con `/static/` | HTML files |
| pronto-static | Vanilla JS en componentes | .vue files |

### 🔍 CSRF EXEMPT (Permitidos)

Los siguientes `@csrf.exempt` son **válidos** según AGENTS.md:
- `pronto-api/src/api_app/routes/employees/auth.py` - Login endpoint
- `pronto-api/src/api_app/routes/client_sessions.py` - Sesiones abiertas (con table_id válido)

---

## 🔴 GATES BLOQUEANTES (P0)

### Gate A: Arquitectura
- [ ] `docker-compose*` modificado sin orden explícita ⇒ **REJECTED**

### Gate B: Seguridad
- [ ] `flask.session` en pronto-api/pronto-employees ⇒ **REJECTED**
- [ ] JWT de empleados modificado sin orden ⇒ **REJECTED**

### Gate C: Estáticos
- [ ] Estáticos fuera de `pronto-static` ⇒ **REJECTED**

### Gate D: Roles
- [ ] Rol nuevo o typo ⇒ **REJECTED**

### Gate H: Order State Authority
- [ ] `workflow_status = ...` fuera de `order_state_machine.py` ⇒ **REJECTED**
- [ ] `payment_status = ...` fuera de `order_state_machine.py` ⇒ **REJECTED**
- [ ] Strings mágicos de estados fuera de `constants.py` ⇒ **REJECTED**

---

## 🟡 VERIFICACIONES PRONTO-API

### 1. Seguridad
- [ ] **flask.session PROHIBIDO**: No importar `from flask import session`
- [ ] **JWT OBLIGATORIO**: Usar `jwt_required`, `get_current_user`
- [ ] **CSRF**: Sin `@csrf.exempt` (excepto `/health`, `/api/sessions/open`)
- [ ] **PII en logs**: No exponer passwords/tokens/secrets

### 2. Arquitectura
- [ ] **Estáticos**: No referenciar `static_content`, `assets_css`, `assets_js`
- [ ] **DDL Runtime PROHIBIDO**: Sin `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`
- [ ] **Docker**: Sin referencias a `docker-compose`

### 3. Ordenes (P0)
- [ ] **Order State Authority**: `workflow_status` solo en `order_state_machine.py`
- [ ] **Payment Authority**: `payment_status` solo en `order_state_machine.py`
- [ ] **Constantes**: Estados definidos en `constants.py`

### 4. API Canónica
- [ ] **Rutas UUID**: Usar `<uuid:id>` para entidades UUID (no `<int:id>`)
- [ ] **Path**: Solo `/api/*` (prohibido `/{scope}/api/*`)
- [ ] **Entidades con Integer ID** (verificar):
  - [ ] Area
  - [ ] Role
  - [ ] DiscountCode
  - [ ] Promotion
  - [ ] ProductSchedule
  - [ ] WaiterCall

### 5. Trazabilidad
- [ ] **Correlation ID**: Header `X-Correlation-ID` implementado
- [ ] **USER_MESSAGES**: Mensajes amigables para errores
- [ ] **Health Endpoint**: `/health` existe

### 6. Funcional
- [ ] **Pronto-shared**: Importar desde `pronto_shared` antes de crear nuevo código

---

## 🟡 VERIFICACIONES PRONTO-EMPLOYEES

### 1. Seguridad
- [ ] **flask.session PROHIBIDO**: No importar `from flask import session`
- [ ] **JWT OBLIGATORIO**: Usar `jwt_required`, `get_employee_id`
- [ ] **Web Auth**: `@web_login_required`, `@web_role_required`

### 2. Arquitectura
- [ ] **Estáticos**: No referenciar `static_content`, `assets_css`, `assets_js`
- [ ] **Templates**: No estáticos locales en HTML

### 3. Roles Canónicos
- [ ] **Roles válidos**: `waiter`, `chef`, `cashier`, `admin`, `system`
- [ ] **ScopeGuard**: Aislamiento de rutas por scope

### 4. API
- [ ] **Rutas UUID**: Usar `<uuid:id>` para entidades UUID
- [ ] **Decoradores**: Verificar uso correcto de `@role_required`

### 5. Endpoints por Rol
- [ ] `/waiter/*` → waiter
- [ ] `/chef/*` → chef
- [ ] `/cashier/*` → cashier
- [ ] `/admin/*` → admin, system
- [ ] `/system/*` → system

---

## 🟡 VERIFICACIONES PRONTO-CLIENT

### 1. Autenticación
- [ ] **Header canónico**: `X-PRONTO-CUSTOMER-REF` para llamadas a API
- [ ] **Sesiones cliente**: Usar Redis con TTL 60m

### 2. CSRF
- [ ] **Mutaciones**: POST/PUT/DELETE incluyen CSRF token
- [ ] **@csrf.exempt**: Solo en `/health`

### 3. Estáticos
- [ ] **Templates**: No estáticos locales (usar context variables)
- [ ] **Variables**: `assets_css_clients`, `assets_js_clients`

### 4. Flux
- [ ] **Login/Registro**: Solo usuarios autenticados pueden ordenar
- [ ] **Kiosko**: Usuario especial `kiosko` (mismo comportamiento que cliente)

---

## 🟡 VERIFICACIONES PRONTO-STATIC (Vue)

### 1. Build-Only
- [ ] **Vue Compilation**: Solo se compila en build
- [ ] **No SSR**: Vue no corre en servidor

### 2. TypeScript
- [ ] **Sin Vanilla JS**: Solo TypeScript en `<script setup lang="ts">`
- [ ] **Composables**: Reutilización en `composables/*.ts`

### 3. Context Variables
- [ ] **assets_css**: `{{ assets_css_employees }}` o `{{ assets_css_clients }}`
- [ ] **assets_js**: `{{ assets_js_employees }}` o `{{ assets_js_clients }}`
- [ ] **assets_images**: `{{ assets_images }}`

### 4. HTTP
- [ ] **Canon**: Rutas relativas `/api/*` (no hardcoded)
- [ ] **Credentials**: `credentials: 'include'`
- [ ] **CSRF Header**: `X-CSRFToken` para mutaciones

### 5. Estructura
- [ ] **Clientes**: `src/vue/clients/`
- [ ] **Empleados**: `src/vue/employees/`
- [ ] **Compartidos**: `src/vue/shared/`

---

## 🟢 VERIFICACIONES CRUZADAS

### Pronto-Libs
- [ ] **Import**: Todo código compartido debe importarse desde `pronto_shared`
- [ ] **Servicios**: No duplicar servicios existentes
- [ ] **Models**: Usar modelos de `pronto_shared`

### DDL/Schema
- [ ] **Fuente única**: SQL en `pronto-scripts/init/`
- [ ] **Migrations**: Solo en `pronto-scripts/init/sql/migrations/`
- [ ] **DROP**: Prohibido excepto en migrations

### Documentación
- [ ] **Features**: Nueva feature ⇒ `pronto-docs/features/<name>/`
- [ ] **Contracts**: `pronto-docs/contracts/<module>/`
- [ ] **Errores**: Bug ⇒ `pronto-docs/errors/<YYYYMMDD>_<slug>.md`

---

## 📊 CHECKLIST DE ARCHIVOS

### PRONTO-API (50 archivos Python)
```
src/api_app/
├── __init__.py          [✓] Verificar init
├── app.py               [✓] Flask app
├── feature_flags.py     [✓] Feature flags
├── verify_pii.py        [✓] PII verification
└── wsgi.py              [✓] WSGI entry

src/api_app/routes/
├── __init__.py
├── client_sessions.py   [✓] Sesiones cliente
├── constants.py         [✓] Constantes canónicas
├── feedback.py          [✓] Feedback
├── menu.py              [✓] Menú
├── notifications.py     [✓] Notificaciones
├── orders.py            [✓] Órdenes
├── promotions.py         [✓] Promociones
├── realtime.py          [✓] Tiempo real
├── reports.py           [✓] Reportes
├── settings.py          [✓] Configuración
├── customers/
│   ├── __init__.py
│   ├── admin.py         [✓] Admin clientes
│   └── orders.py        [✓] Órdenes cliente
└── employees/
    ├── __init__.py
    ├── admin.py         [✓] Admin empleados
    ├── analytics.py     [✓] Analytics
    ├── api_branding.py [✓] Branding
    ├── areas.py         [✓] Áreas
    ├── auth.py          [✓] Auth JWT
    ├── business_info.py [✓] Info negocio
    ├── config.py        [✓] Config
    ├── debug.py         [✓] Debug
    ├── discount_codes.py [✓] Descuentos
    ├── employees.py     [✓] Empleados
    ├── maintenance.py   [✓] Mantenimiento
    ├── menu_items.py    [✓] Items menú
    ├── menu.py          [✓] Menú
    ├── modifiers.py     [✓] Modificadores
    ├── notifications.py [✓] Notificaciones
    ├── orders.py        [✓] Órdenes
    ├── product_schedules.py [✓] Horarios
    ├── sessions.py      [✓] Sesiones
    ├── split_bills.py   [✓] División cuentas
    ├── stats.py         [✓] Estadísticas
    ├── table_assignments.py [✓] Asignaciones
    └── tables.py        [✓] Mesas
```

### PRONTO-EMPLOYEES (80 archivos Python)
```
src/pronto_employees/
├── __init__.py
├── app.py               [✓] Flask app
├── decorators.py        [✓] @web_login_required, @web_role_required
├── wsgi.py
└── routes/
    ├── __init__.py
    ├── admin/
    │   └── auth.py       [✓] Admin auth
    ├── api/
    │   ├── __init__.py
    │   ├── admin_shortcuts.py [✓]
    │   ├── analytics.py     [✓]
    │   ├── areas.py          [✓]
    │   ├── auth.py           [✓] JWT auth
    │   ├── branding.py       [✓]
    │   ├── business_info.py  [✓]
    │   ├── config.py         [✓]
    │   ├── customers.py      [✓]
    │   ├── debug.py          [✓]
    │   ├── discount_codes.py [✓]
    │   ├── employees.py      [✓]
    │   ├── feedback.py       [✓]
    │   ├── maintenance.py    [✓]
    │   ├── menu_items.py     [✓]
    │   ├── menu.py           [✓]
    │   ├── modifiers.py      [✓]
    │   ├── notifications.py  [✓]
    │   ├── orders.py         [✓]
    │   ├── permissions.py    [✓] RBAC
    │   ├── product_schedules.py [✓]
    │   ├── promotions.py    [✓]
    │   ├── realtime.py       [✓]
    │   ├── reports.py        [✓]
    │   ├── roles.py          [✓]
    │   ├── sessions.py       [✓]
    │   ├── stats.py          [✓]
    │   ├── table_assignments.py [✓]
    │   └── tables.py         [✓]
    ├── cashier/
    │   └── auth.py           [✓] Cashier auth
    ├── chef/
    │   └── auth.py           [✓] Chef auth
    ├── system/
    │   └── auth.py           [✓] System auth
    └── waiter/
        └── auth.py           [✓] Waiter auth
```

### PRONTO-CLIENT (25 archivos Python)
```
src/pronto_clients/
├── __init__.py
├── app.py               [✓] Flask app
├── wsgi.py
├── routes/
│   ├── __init__.py
│   ├── web.py           [✓] Web routes
│   └── api/
│       ├── __init__.py
│       ├── auth.py           [✓] Auth cliente
│       ├── business_info.py  [✓]
│       ├── config.py         [✓]
│       ├── feedback_email.py [✓]
│       ├── health.py         [✓]
│       ├── menu.py           [✓]
│       ├── notifications.py  [✓]
│       ├── orders.py         [✓]
│       ├── payments.py       [✓]
│       ├── sessions.py       [✓]
│       ├── shortcuts.py      [✓]
│       ├── split_bills.py    [✓]
│       ├── stripe_payments.py [✓]
│       ├── support.py        [✓]
│       ├── tables.py         [✓]
│       └── waiter_calls.py   [✓]
└── templates/
    ├── base.html
    ├── checkout.html
    ├── debug_panel.html
    ├── error.html
    ├── feedback.html
    ├── index-alt.html
    ├── index.html
    ├── kiosk.html
    └── thank_you.html
```

### PRONTO-STATIC (~150 archivos Vue/TS)
```
src/vue/
├── clients/
│   ├── components/
│   │   ├── CartPanel.vue
│   │   ├── LoginForm.vue
│   │   ├── OrdersTab.vue
│   │   └── menu/
│   ├── config/
│   │   └── api.ts
│   ├── core/
│   │   ├── bootstrap.ts
│   │   └── http.ts       [✓] X-CSRFToken
│   ├── entrypoints/
│   ├── modules/
│   ├── store/
│   │   ├── cart.ts
│   │   ├── orders.ts
│   │   ├── ui.ts
│   │   └── user.ts
│   ├── types/
│   └── views/
│       ├── CheckoutView.vue
│       └── MenuPage.vue
│
├── employees/
│   ├── components/       [✓] ~30 componentes
│   │   ├── DashboardView.vue
│   │   ├── KDSBoard.vue
│   │   ├── KitchenBoard.vue
│   │   ├── LoginForm.vue
│   │   ├── Payments/
│   │   └── ...
│   ├── composables/
│   │   ├── use-order-aging.ts
│   │   └── use-rbac.ts
│   ├── core/
│   │   ├── auth-interceptor.ts [✓] JWT
│   │   ├── bootstrap.ts
│   │   └── http.ts       [✓] X-CSRFToken
│   ├── modules/
│   ├── router/
│   │   └── index.ts
│   ├── store/
│   │   ├── auth.ts
│   │   ├── config.ts
│   │   ├── orders.ts
│   │   └── ui.ts
│   ├── types/
│   └── views/
│
└── shared/
    ├── components/      [✓] ~25 componentes reutilizables
    ├── domain/
    ├── lib/
    ├── types/
    ├── utils/
    └── workflow/
```

---

## 🚦 CÓDIGOS DE ESTADO

| Código | Significado | Acción |
|--------|-------------|--------|
| ⏳ | Pendiente | Por auditar |
| ✅ | PASS | Verificación OK |
| ⚠️ | WARNING | Requiere revisión manual |
| ❌ | REJECTED | Bloqueante - Corregir |

---

## 📝 INSTRUCCIONES DE USO

### Ejecutar auditoría automatizada:
```bash
./pronto-scripts/bin/audit-checklist.sh
```

### Auditoría manual:
1. Marcar cada checkbox según verificación
2. Documentar hallazgos en `pronto-docs/errors/`
3. Si hay REJECTED ⇒ Bloquear deployment

---

**Última actualización:** 2026-02-18
