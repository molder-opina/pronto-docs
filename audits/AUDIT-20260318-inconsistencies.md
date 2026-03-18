# PRONTO - Auditoría Exhaustiva de Inconsistencias

**Fecha**: 2026-03-18
**Alcance**: pronto-api, pronto-client, pronto-employees, pronto-static, pronto-libs
**Metodología**: Subagentes archivo por archivo

---

## RESUMEN EJECUTIVO

| Módulo | Status | Violaciones P0 | Warnings |
|--------|--------|----------------|----------|
| pronto-api | ❌ | 12 | 8 |
| pronto-client | ❌ | 6 | 4 |
| pronto-employees | ❌ | 1 | 0 |
| pronto-static | ❌ | 3 | 3 |
| pronto-libs | ❌ | 4 | 6 |
| **TOTAL** | **❌ REJECTED** | **26** | **21** |

---

## VIOLACIONES P0 (BLOQUEANTES)

### 1. PRONTO-API

#### 1.1 feedback.py - Runtime Errors
```python
# Líneas 215, 338
if not order.is_paid():  # AttributeError - método no existe
```
**Fix**: Usar `order.workflow_status == OrderStatus.PAID.value`

#### 1.2 invoices.py - Estados Hardcodeados
```python
# Línea 200
if order.workflow_status != "paid":  # String hardcodeado
```
**Fix**: `order.workflow_status != OrderStatus.PAID.value`

#### 1.3 invoices.py - Exposición PII Datos Fiscales
- tax_id, tax_name, tax_email expuestos sin masking

#### 1.4 notifications.py - Auth Incorrecta
```python
# Línea 21
POST /notifications/waiter/call usa @jwt_required (empleados)
# DEBE usar @require_customer_session (clientes)
```

#### 1.5 menu.py - RBAC Incorrecto
```python
# Línea 19-20
@scope_required(['waiter', 'chef', 'cashier', 'admin', 'system'])
# DEBE usar @require_permission(Permission.MENU_VIEW)
```

#### 1.6 menu_authorization.py - Sistema RBAC Paralelo (CRÍTICO)
- Implementa `PERMISSION_SCOPE_MAP` custom fuera del RBACService canónico
- Permisos con dot notation (`menu.taxonomy.manage`) no existen en enum `Permission`
- 36 usages en el codebase con `@menu_permission_required`

#### 1.7 shortcuts.py - Auth Faltante
```python
# Líneas 16-17
GET /shortcuts sin autenticación
# NO es excepción permitida por AGENTS.md 15
```

#### 1.8 promotions.py - Autorización Ausente
```python
# Líneas 51, 99, 129, 155
POST/PUT/DELETE sin @scope_required
# Cualquier empleado puede crear promociones
```

#### 1.9 employees/tables.py - Estado Inválido
```python
# Línea 68
table.get('status') == 'error'  # NO existe en TableStatus
```

---

### 2. PRONTO-CLIENT

#### 2.1 orders.py - flask.session Prohibido
```python
# Líneas 77-78
session["dining_session_id"] = dining_session_id
session.permanent = False
```
**Violación P0-6**: Solo `customer_ref` y `dining_session_id` en allowlist, pero mecanismo DEBE ser Redis, no flask.session

#### 2.2 config.py - Acceso DB Directo (CRÍTICO)
```python
# Líneas 16, 33-38
from pronto_shared.services.business_config_service import get_config_value
# Accede directamente a PostgreSQL/Redis
# NO es BFF proxy - viola 12.4.2
```

#### 2.3 shortcuts.py - Endpoint Propio
```python
# Retorna shortcuts hardcodeados
# NO es proxy a pronto-api
# Ubicación incorrecta según arquitectura
```

#### 2.4 web.py - Múltiples Violaciones
```python
# Línea 263
session.get('dining_session_id')  # NO está en allowlist

# Líneas 324-386
kiosk_start() - Lógica de negocio en SSR
# API endpoint que retorna JSON, no template rendering

# Líneas 160-175
Consultas SQL directas en funciones web
```

---

### 3. PRONTO-EMPLOYEES

#### 3.1 _scope_auth.py / auth.py - @csrf.exempt Faltante
```python
# _scope_auth.py línea 284
@bp.post('/login')  # Sin @csrf.exempt
```
**Impacto**: 5 logins (waiter, chef, cashier, admin, system) sin exención CSRF obligatoria

---

### 4. PRONTO-STATIC

#### 4.1 router/index.ts - Componente Faltante
```typescript
// Línea 80
component: Dashboard  // NO ESTÁ IMPORTADO
```
**Impacto**: Runtime error en navegación

#### 4.2 clients/App.vue - Manipulación DOM Directa
```javascript
// Líneas 201, 208, 216, 220, 323
document.getElementById('shortcuts-modal')
modal.querySelector('.shortcuts-close')
document.body.style.overflow = 'hidden'
```
**Violación P0-21.1**: Debe usar Vue refs/composables

---

### 5. PRONTO-LIBS

#### 5.1 permissions.py - Duplicate Key
```python
# Líneas 82-89
ROLE_PERMISSIONS = {
    'system': {...},  # Primera definición
    'system': {...},  # SOBRESCRIBE la primera
}
```

#### 5.2 permissions.py - Permisos Faltantes
- `waiter` necesita `ORDERS_CANCEL` (ORDER_TRANSITIONS lo permite)
- `admin` necesita `EMPLOYEES_DELETE` (consistencia)
- `cashier` necesita `TABLES_VIEW` (contexto de cobro)

#### 5.3 order_state_machine.py - Bypass State Machine (CRÍTICO)
```python
# order_state_machine_core.py líneas 394-399
mark_order_paid()  # Escritura directa sin pasar por state machine

# order_payment.py líneas 221-226
confirm_partial_payment() llama mark_order_paid()
# BYPASSEA validation de ORDER_TRANSITIONS
```

---

## WARNINGS (NO BLOQUEANTES PERO REQUIEREN ATENCIÓN)

### PRONTO-LIBS
- `constants.py`: `_NON_TERMINAL` duplicado de `OPEN_ORDER_STATUSES`
- `constants.py`: `OPEN_ORDER_STATUSES` debería ser `frozenset()`
- `jwt_service.py`: print de debug comentado (línea 342)

### PRONTO-API
- `employees/admin.py`: Endpoints de permisos stubs vacíos
- `stripe_webhooks.py`: Bien implementado
- `customers/split_bills.py`: SplitBillStatus no existe como enum

### PRONTO-CLIENT
- Múltiples módulos marcados como DEPRECATED sin fecha de retiro

### PRONTO-STATIC
- `employees/App.vue`: localStorage para estado UI (sidebar)

---

## PATRÓN RECURRENTE IDENTIFICADO

### Sistema RBAC Paralelo (menu_authorization.py)
El archivo implementa un sistema de permisos completamente separado del RBACService canónico:
- 36 usages de `@menu_permission_required` en 6 archivos
- Permisos con naming diferente (`menu.taxonomy.manage` vs `menu:manage`)
- No consulta BD para permisos dinámicos

**Archivos afectados**:
- `menu_home_modules.py`
- `menu_items.py`
- `product_schedules.py`
- `menu_subcategories.py`
- `menu_labels.py`
- `menu_categories.py`

---

## GATES DE VALIDACIÓN FALLIDOS

```bash
# Gate H: Order State Authority
rg -n --hidden "workflow_status\s*=" pronto-api/src | rg -v "order_state_machine\.py"
# OUTPUT: ✅ (verificado en routes)

# Gate L: HTTP Client Patterns
rg -n "localStorage.*session|session.*localStorage" pronto-static/src/vue/clients/
# OUTPUT: ✅ (solo para UI state)

# Gate 21: Pureza Vue
rg -n "document\.(getElementById|querySelector)" pronto-static/src/vue/
# OUTPUT: ⚠️ Encontrado en App.vue
```

---

## RECOMENDACIONES DE PRIORIDAD

### P0 - Inmediato
1. Corregir `order.is_paid()` → `workflow_status == OrderStatus.PAID.value`
2. Agregar `@csrf.exempt` a logins de empleados
3. Migrar `menu_authorization.py` a usar `RBACService`
4. Corregir `mark_order_paid()` para pasar por state machine
5. Eliminar acceso DB directo en `config.py` de pronto-client
6. Importar componente `Dashboard` faltante en router

### P1 - Esta Semana
1. Agregar `ORDERS_CANCEL` a permisos de waiter
2. Corregir `workflow_status != "paid"` → `OrderStatus.PAID.value`
3. Implementar auth correcta en `/notifications/waiter/call`
4. Migrar shortcuts a endpoint real de pronto-api

### P2 - Planeación
1. Consolidar `@menu_permission_required` → `@require_permission`
2. Eliminar `_NON_TERMINAL` duplicado
3. Convertir `OPEN_ORDER_STATUSES` a `frozenset`

---

## ARCHIVOS AUDITADOS

### pronto-api: 42 archivos
- ✅ Pass: 30
- ⚠️ Warnings: 8
- ❌ Violations: 12

### pronto-client: 18 archivos
- ✅ Pass: 11
- ⚠️ Warnings: 4
- ❌ Violations: 6

### pronto-employees: 10 archivos
- ✅ Pass: 9
- ❌ Violations: 1

### pronto-static: ~100+ archivos Vue/TS
- ✅ Pass: Mayoría
- ❌ Violations: 3

### pronto-libs: 100+ archivos
- ✅ Pass: Mayoría
- ❌ Violations: 4

---

## CONCLUSIÓN

**STATUS: ❌ REJECTED**

El codebase tiene **26 violaciones P0** que deben corregirse antes de cualquier release. Las violaciones más críticas son:

1. **Sistema RBAC paralelo** (`menu_authorization.py`) - arquitectural
2. **Bypass state machine** (`mark_order_paid()`) - integridad de negocio
3. **flask.session en pronto-client** - seguridad PII
4. **Auth incorrecta en endpoints** - accesibilidad no autorizada

**Acción requerida**: Corregir todas las violaciones P0 antes de continuar con nuevas funcionalidades.
