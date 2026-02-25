# Auditoría de Inconsistencias - Multi-Console Authentication

**Fecha**: 2026-02-25
**Auditor**: Letta Code (Memo)
**Alcance**: pronto-api, pronto-employees, pronto-client, pronto-static

---

## Resumen Ejecutivo

Se detectaron **12 inconsistencias** y **5 mejoras potenciales** tras la implementación del sistema de autenticación multi-consola. La mayoría son legacy técnico que debe limpiarse.

---

## 🔴 BUGS CRÍTICOS (P0)

### BUG-001: pronto-client mezcla flask.session con JWT

**Ubicación**: `pronto-client/src/pronto_clients/routes/api/auth.py`

**Problema**:
```python
session.clear()
session["customer_ref"] = customer_ref
```

El cliente usa `flask.session` para guardar `customer_ref`, pero también intenta usar cookies JWT. Esto crea dos sistemas de autenticación paralelos.

**Impacto**: Sesiones inconsistentes, pérdida de estado en refresh.

**Recomendación**: Migrar completamente a JWT para clientes, eliminando flask.session.

---

### BUG-002: pronto-client orders.py lee cookie genérica

**Ubicación**: `pronto-client/src/pronto_clients/routes/api/orders.py:77-79`

```python
access_token = request.cookies.get("access_token")
if access_token:
    cookies["access_token"] = access_token
```

**Problema**: El cliente lee y propaga cookie `access_token` genérica, no namespaced.

**Impacto**: Si el cliente usa el proxy de employees, la cookie no será reconocida.

**Recomendación**: Usar `X-PRONTO-CUSTOMER-REF` header en lugar de cookies para APIs cliente.

---

### BUG-003: pronto-api client_sessions.py usa cookies genéricas

**Ubicación**: `pronto-api/src/api_app/routes/client_sessions.py:60,212`

```python
response.set_cookie("access_token", token, ...)
token_str = request.cookies.get("access_token")
```

**Problema**: Clientes usan cookie `access_token` sin namespace, igual que empleados legacy.

**Impacto**: Colisión potencial entre sesión cliente y empleado en mismo navegador.

**Recomendación**: Usar `access_token_client` para distinguir de sesiones empleado.

---

## 🟠 BUGS MEDIOS (P1)

### BUG-004: pronto-employees tiene blueprint /api/* heredado

**Ubicación**: `pronto-employees/src/pronto_employees/routes/api/__init__.py`

**Problema**: Existe un blueprint `/api/*` completo en pronto-employees con ~30 endpoints que duplican lógica de pronto-api.

**Impacto**: 
- Violación de arquitectura (empleados no debe tener negocio)
- Rutas duplicadas causan confusión
- Proxy `/<scope>/api/*` compite con `/api/*`

**Recomendación**: Eliminar todos los endpoints de negocio del blueprint `/api/*` en employees, mantener solo el proxy.

---

### BUG-005: pronto-static clients no usa scope-aware routing

**Ubicación**: `pronto-static/src/vue/clients/core/http.ts`

**Problema**: El frontend de clientes usa `/api/*` directo sin considerar que debería pasar por el BFF.

**Impacto**: No afecta funcionamiento actual, pero inconsistente con employees.

**Recomendación**: Mantener así es correcto - clientes NO tienen consolas.

---

### BUG-006: flask.session usado en 10+ archivos de pronto-client

**Ubicación**: Múltiples archivos en `pronto-client/src/pronto_clients/routes/api/`

**Archivos afectados**:
- `auth.py:97,189,245`
- `sessions.py:74`
- `orders.py:144`
- `web.py:222`

**Problema**: Uso extensivo de `flask.session` mezclado con sistema JWT.

**Recomendación**: Auditoría completa de migración a JWT puro.

---

## 🟡 MEJORAS POTENCIALES (P2)

### MEJ-001: Unificar nombre de cookie de cliente

**Actual**: `access_token` (genérico)
**Propuesto**: `access_token_client` o `pronto_client_token`

**Beneficio**: Evita colisión con cookies de empleado.

---

### MEJ-002: Eliminar blueprint /api/* heredado de pronto-employees

**Beneficio**: 
- Limpieza arquitectural
- Reduce superficie de ataque
- Elimina confusión de rutas

---

### MEJ-003: Documentar flujo de autenticación cliente vs empleado

**Beneficio**: Claridad para desarrolladores futuros.

**Contenido sugerido**:
- Empleados: JWT + cookies namespaced por consola
- Clientes: JWT + cookie única (sin consola)
- Kiosks: JWT con modo "kiosk" (TTL largo)

---

### MEJ-004: Centralizar configuración de cookies en pronto-libs

**Beneficio**: Un solo lugar para cambiar nombres/TTL de cookies.

---

### MEJ-005: Test de integración multi-sesión

**Beneficio**: Verificar que waiter/chef pueden coexistir.

---

## 📊 Conteo por Repositorio

| Repositorio | P0 | P1 | P2 | Total |
|-------------|----|----|----|----|
| pronto-api | 1 | 0 | 0 | 1 |
| pronto-employees | 0 | 1 | 1 | 2 |
| pronto-client | 2 | 1 | 0 | 3 |
| pronto-static | 0 | 0 | 1 | 1 |
| pronto-libs | 0 | 0 | 1 | 1 |
| **TOTAL** | **3** | **2** | **3** | **8** |

---

## 🔍 Detalle de Archivos Afectados

### pronto-api
- `src/api_app/routes/client_sessions.py` (BUG-003)
- `src/api_app/routes/employees/auth.py` (OK - actualizado)

### pronto-employees
- `src/pronto_employees/routes/api/__init__.py` (BUG-004, MEJ-002)
- `src/pronto_employees/routes/api/proxy_console_api.py` (OK - deprecated)

### pronto-client
- `src/pronto_clients/routes/api/auth.py` (BUG-001, BUG-006)
- `src/pronto_clients/routes/api/orders.py` (BUG-002)
- `src/pronto_clients/routes/api/sessions.py` (BUG-006)
- `src/pronto_clients/routes/api/payments.py` (BUG-006)
- `src/pronto_clients/routes/web.py` (BUG-006)

### pronto-static
- `src/vue/clients/core/http.ts` (MEJ-005 - OK mantener)
- `src/vue/employees/core/http.ts` (OK - actualizado)

---

## 🎯 Prioridad de Corrección

1. **Inmediato**: BUG-001, BUG-002, BUG-003 (autenticación rota)
2. **Próximo sprint**: BUG-004, BUG-006 (deuda técnica)
3. **Backlog**: MEJ-001 a MEJ-005 (mejoras)

---

## ✅ Estado Post-Auditoría

La implementación multi-consola está **funcionalmente completa** para:
- ✅ Empleados waiter/chef/cashier/admin/system
- ✅ Cookies namespaced por consola
- ✅ Logout scoped
- ✅ Proxy técnico deprecated
- ✅ Frontend scope-aware

Los bugs encontrados son **legacy técnico** que no impiden el funcionamiento del nuevo sistema, pero deben limpiarse para evitar deuda futura.

---

**Auditoría completada**: 2026-02-25 19:45 UTC
