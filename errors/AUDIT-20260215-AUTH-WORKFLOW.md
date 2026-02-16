# Auditoría de Autenticación y Workflow de Órdenes

**Fecha:** 2026-02-15  
**Auditor:** AI Agent  
**Proyecto:** PRONTO  
**Versión:** 1.0000

---

## Resumen Ejecutivo

Se realizó una auditoría completa del sistema de autenticación y workflow de órdenes de PRONTO. **No se encontraron bugs bloqueantes.** El sistema cumple con las especificaciones de AGENTS.md.

---

## Componentes Auditados

### 1. Autenticación de Clientes (pronto-client)

**Ubicación:** `pronto-client/src/pronto_clients/routes/api/auth.py`

**Hallazgos:**
- ✅ Usa `customer_ref` en Flask session (permitido según AGENTS.md sección 6)
- ✅ Almacena sesión en Redis con TTL 60m: `pronto:client:customer_ref:<uuid>`
- ✅ PII fuera de sesión
- ✅ Header `X-PRONTO-CUSTOMER-REF` usado para comunicar con API

**Estado:** CORRECTO

---

### 2. Autenticación de Empleados (pronto-api)

**Ubicación:** `pronto-api/src/api_app/routes/employees/`

**Hallazgos:**
- ✅ JWT stateless implementado correctamente
- ✅ Decoradores `@jwt_required`, `@role_required`, `@admin_required` funcionando
- ✅ No se usa Flask session para empleados (cumple regla P0 #5)

**Estado:** CORRECTO

---

### 3. Workflow de Órdenes (Order State Machine)

**Ubicación:** 
- `pronto-libs/src/pronto_shared/constants.py`
- `pronto-libs/src/pronto_shared/services/order_state_machine.py`
- `pronto-libs/src/pronto_shared/services/order_service.py`

**Estados definidos:**
```
new → queued → preparing → ready → delivered → paid
```

**Hallazgos:**
- ✅ Transiciones con validación de scopes por actor
- ✅ Quick-serve soportado (skip kitchen para items is_quick_serve=true)
- ✅ ORDER_TRANSITIONS define todas las transiciones válidas

**Transiciones verificadas:**

| Desde | Hacia | Acción | Scopes Permitidos |
|-------|-------|--------|-------------------|
| new | queued | accept_or_queue | waiter, admin, system |
| new | cancelled | cancel | client, waiter, admin, system |
| queued | preparing | kitchen_start | chef, admin, system |
| queued | ready | skip_kitchen | system |
| queued | cancelled | cancel | client, waiter, admin, system |
| preparing | ready | kitchen_complete | chef, admin, system |
| preparing | cancelled | cancel | waiter, admin, system |
| ready | delivered | deliver | waiter, admin, system |
| ready | cancelled | cancel | admin, system |
| delivered | awaiting_payment | mark_awaiting_payment | cashier, admin, system |
| delivered | paid | pay_direct | admin, system |
| delivered | cancelled | cancel | admin, system |
| awaiting_payment | paid | pay | cashier, admin, system |
| awaiting_payment | cancelled | cancel | admin, system |

**Estado:** CORRECTO

---

### 4. Endpoints de Órdenes

**Ubicación:** `pronto-api/src/api_app/routes/employees/orders.py`

**Endpoints verificados:**
- ✅ `POST /orders/<id>/accept` - waiter acepta orden
- ✅ `POST /orders/<id>/kitchen/start` - chef inicia preparación  
- ✅ `POST /orders/<id>/kitchen/ready` - chef marca lista
- ✅ `POST /orders/<id>/deliver` - waiter entrega
- ✅ `POST /orders/<id>/cancel` - cancelar orden
- ✅ `POST /orders/<id>/request-check` - pedir cuenta

**Estado:** CORRECTO

---

## Reglas AGENTS.md Verificadas

| Regla | Descripción | Estado |
|-------|-------------|--------|
| P0 #5 | Prohibido flask.session en api/employees | ✅ CUMPLE |
| P0 #6 | Sesión cliente con allowlist específico | ✅ CUMPLE |
| P0 #7 | JWT inmutable para empleados | ✅ CUMPLE |
| P0 #12 | API canónica /api/* | ✅ CUMPLE |
| P0 #16 | Roles canónicos | ✅ CUMPLE |

---

##结论

**No se encontraron bugs bloqueantes.**

El sistema de autenticación y workflow de órdenes está correctamente implementado según la arquitectura especificada en AGENTS.md.

---

## Evidencia de Archivos Analizados

- `pronto-client/src/pronto_clients/routes/api/auth.py`
- `pronto-client/src/pronto_clients/routes/web.py`
- `pronto-client/src/pronto_clients/routes/api/orders.py`
- `pronto-api/src/api_app/routes/employees/orders.py`
- `pronto-libs/src/pronto_shared/constants.py`
- `pronto-libs/src/pronto_shared/services/order_state_machine.py`
- `pronto-libs/src/pronto_shared/services/order_service.py`
