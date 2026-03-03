# Auditoría de Inconsistencias - Multi-Console Authentication

**Fecha**: 2026-02-25
**Auditor**: Letta Code (Memo)
**Alcance**: pronto-api, pronto-employees, pronto-client, pronto-static
**Estado**: ✅ CERRADA - Todos los bugs P0 resueltos

---

## Resumen Ejecutivo

Se detectaron **3 bugs críticos** y **2 bugs medios**. Todos los P0 han sido corregidos siguiendo la arquitectura correcta:

| Dominio | Paradigma | Cookie |
|---------|-----------|--------|
| **Empleados** | JWT Stateless | `access_token_{scope}` |
| **Clientes** | Session + Redis | `pronto_client_session` |

---

## 🔴 BUGS CRÍTICOS (P0) - RESUELTOS

### ~~BUG-001: pronto-client mezcla flask.session con JWT~~ ✅ BY DESIGN

**Veredicto**: Falso positivo - El auth.py de clientes YA usa session + Redis correctamente.

**Lección**: Verificar código actualizado antes de reportar bugs.

---

### ~~BUG-002: pronto-client orders.py lee cookie genérica~~ ✅ RESUELTO

**Ubicación**: `pronto-client/src/pronto_clients/routes/api/orders.py`

**Acción tomada**:
- Eliminada propagación de cookie `access_token`
- El proxy ahora usa solo `X-PRONTO-CUSTOMER-REF` header

**Commit**: `70463e1` - "fix(client): remove JWT cookie propagation in orders proxy"

---

### ~~BUG-003: pronto-api client_sessions.py usa cookies genéricas~~ ✅ RESUELTO

**Ubicación**: `pronto-api/src/api_app/routes/client_sessions.py`

**Acción tomada**:
- Renombrada cookie de `access_token` a `pronto_client_session`
- Namespacing obligatorio para evitar colisión con empleados

**Commit**: `f9b8b85` - "fix(client-sessions): namespace client session cookie"

---

## 🟠 BUGS MEDIOS (P1)

### BUG-004: pronto-employees tiene blueprint /api/* heredado

**Estado**: ⏳ Pendiente - No blocking para multi-console

**Acción recomendada**: Eliminar endpoints de negocio del blueprint `/api/*` en employees, mantener solo el proxy console.

---

### ~~BUG-006: flask.session usado en 10+ archivos de pronto-client~~ ✅ BY DESIGN

**Veredicto**: Arquitectura correcta - Los clientes usan `flask.session` + Redis como paradigma.

---

## 📊 Estado Final

| Bug ID | Severidad | Estado | Acción |
|--------|-----------|--------|--------|
| BUG-001 | P0 | ✅ BY DESIGN | N/A |
| BUG-002 | P0 | ✅ RESUELTO | Eliminado cookie propagation |
| BUG-003 | P0 | ✅ RESUELTO | Namespaced client cookie |
| BUG-004 | P1 | ⏳ Pendiente | Refactor futuro |
| BUG-006 | P1 | ✅ BY DESIGN | Arquitectura correcta |

---

## 🏗️ Arquitectura Implementada

### Empleados (JWT Stateless)
```
Cookie: access_token_{scope}
Scope: waiter, chef, cashier, admin, system
Validación: scope en URL == scope en JWT
Logout: Solo borra cookies del scope actual
```

### Clientes (Session + Redis)
```
flask.session: customer_ref, dining_session_id
Redis: pronto:customer:{ref} → {customer_data}
Header: X-PRONTO-CUSTOMER-REF
```

### Sesiones de Dining (JWT de sesión, NO auth)
```
Cookie: pronto_client_session
Propósito: Identificar mesa/kiosk
NO es: Autenticación de usuario
```

---

## ✅ Commits de Corrección

| Repo | Commit | Descripción |
|------|--------|-------------|
| pronto-libs | `208bb47` | Token extractor soporta client session cookie |
| pronto-api | `f9b8b85` | Namespaced client session cookie |
| pronto-client | `70463e1` | Removed JWT cookie propagation |
| pronto-employees | `cc402ef` | Removed legacy cookie fallback |
| pronto-static | `6a11cde` | Scope-aware API wrapper |

---

## 📚 Documentación Generada

- `pronto-docs/architecture/AUTH_ARCHITECTURE.md` - Arquitectura canónica de autenticación

---

**Auditoría cerrada**: 2026-02-25 21:40 UTC
**Todos los bugs P0 resueltos**
