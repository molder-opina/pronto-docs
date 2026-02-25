# Arquitectura de Autenticación - PRONTO

**Versión**: 2.0
**Fecha**: 2026-02-25
**Estado**: Canónico

---

## 🔒 Principios Absolutos P0

### 1. Separación de Dominios

| Dominio | Paradigma | Cookie | Storage |
|---------|-----------|--------|---------|
| **Empleados** | JWT Stateless | `access_token_{scope}` | Redis (revocación) |
| **Clientes** | Session + Redis | `pronto_client_session` | Redis + flask.session |

**NUNCA mezclar paradigmas entre dominios.**

### 2. Namespacing Obligatorio

```python
# ✅ CORRECTO - Empleados
access_token_waiter
access_token_chef
access_token_cashier
access_token_admin
access_token_system

# ✅ CORRECTO - Clientes
pronto_client_session

# ❌ PROHIBIDO - Cookies genéricas
access_token      # BORRADO
refresh_token     # BORRADO
```

### 3. Allowlist Estricta en flask.session (Clientes)

```python
# ✅ PERMITIDO en flask.session
session["customer_ref"]      # Redis key para datos de cliente
session["dining_session_id"] # ID de sesión de mesa

# ❌ PROHIBIDO en flask.session
# Cualquier otro dato
```

---

## 📐 Flujo de Autenticación

### Empleados (JWT Stateless)

```
1. POST /waiter/login → create_access_token(scope="waiter")
2. Set-Cookie: access_token_waiter=...; HttpOnly; Secure
3. Request: Cookie: access_token_waiter=...
4. Backend: decode_token() → employee_id, role, scope
5. Validación: scope in URL path == scope in JWT
```

### Clientes (Session + Redis)

```
1. POST /auth/login → customer_session_store.create_customer_ref()
2. flask.session["customer_ref"] = ref
3. Redis: SET pronto:customer:{ref} {customer_data} TTL 1h
4. Request: Cookie: session=... (flask session)
5. Backend: session.get("customer_ref") → Redis lookup
```

### Sesiones de Dining (JWT de sesión, NO de auth)

```
1. POST /sessions/open → create_client_token(mode="anonymous|client|kiosk")
2. Set-Cookie: pronto_client_session=...; HttpOnly; Secure
3. Token contiene: session_id, table_id, mode
4. NO contiene: customer credentials, auth data
```

---

## 🏗️ Componentes

### pronto-libs

**jwt_service.py**:
- `create_access_token()` - Solo para empleados
- `create_client_token()` - Solo para sesiones de dining
- `extract_token_from_request()` - Busca cookies namespaced
- `CLIENT_SESSION_COOKIE_NAME = "pronto_client_session"`

**console_ctx.py**:
- `resolve_console_from_path()` - Extrae scope de URL
- `access_cookie(scope)` - Retorna nombre de cookie

### pronto-api

**routes/employees/auth.py**:
- Login → `access_token_{scope}` cookies
- Refresh → Requiere `X-App-Context` header
- Logout → Borra solo cookies del scope

**routes/client_sessions.py**:
- Sesiones de dining → `pronto_client_session` cookie
- NO es autenticación de usuario
- NO usa `access_token` genérico

### pronto-client

**routes/api/auth.py**:
- Login/Register → `flask.session["customer_ref"]`
- Redis para datos de cliente
- Sin JWT

**routes/api/orders.py**:
- Proxy a pronto-api con `X-PRONTO-CUSTOMER-REF` header
- Sin propagación de cookies JWT

### pronto-employees

**routes/{scope}/auth.py**:
- Login → `access_token_{scope}` cookies
- Logout → Borra solo cookies del scope
- Sin fallback a cookies genéricas

---

## 🚫 Anti-Patrones (PROHIBIDOS)

### 1. Mezclar flask.session con JWT

```python
# ❌ PROHIBIDO
session["customer_ref"] = ref
response.set_cookie("access_token", token)  # Mezcla paradigmas
```

### 2. Cookies genéricas

```python
# ❌ PROHIBIDO
response.set_cookie("access_token", token)
response.delete_cookie("access_token")
token = request.cookies.get("access_token")
```

### 3. Sesión en DB

```python
# ❌ PROHIBITO - Estado de sesión en DB para empleados
employee.session_token = token  # NO
```

### 4. PII en JWT

```python
# ❌ PROHIBIDO
create_access_token(email=customer_email)  # Usar include_pii=True solo si necesario
```

---

## ✅ Checklist de Implementación

- [x] Cookies namespaced por scope (empleados)
- [x] Cookie `pronto_client_session` para clientes
- [x] Sin cookies genéricas (`access_token`, `refresh_token`)
- [x] flask.session allowlist estricta (solo `customer_ref`, `dining_session_id`)
- [x] Logout scoped (solo borra cookies del scope actual)
- [x] Sin JWT en autenticación de clientes
- [x] Token extractor busca cookies namespaced

---

## 📊 Matriz de Cookies

| Cookie | Dominio | Propósito | TTL |
|--------|---------|-----------|-----|
| `access_token_waiter` | Empleado | Auth mesero | 24h |
| `access_token_chef` | Empleado | Auth cocinero | 24h |
| `access_token_cashier` | Empleado | Auth cajero | 24h |
| `access_token_admin` | Empleado | Auth admin | 24h |
| `access_token_system` | Empleado | Auth sistema | 24h |
| `pronto_client_session` | Cliente | Sesión dining | 1h / 10y (kiosk) |
| `session` | Flask | Sesion web | 1h |
| `csrf_token` | Ambos | CSRF | Session |

---

## 🔄 Migración de Legacy

### Antes (Legacy)

```
Empleado: access_token, refresh_token (genéricos)
Cliente: access_token (genérico) + flask.session
```

### Después (Actual)

```
Empleado: access_token_{scope} (namespaced)
Cliente: flask.session + Redis + pronto_client_session (dining)
```

### Breaking Changes

1. **Empleados con cookies viejas**: Deben re-login
2. **Clientes con cookies viejas**: Deben re-login
3. **APIs sin X-App-Context**: Refresh fallará

---

**Documento canónico**: Este archivo es la fuente de verdad para autenticación en PRONTO.
Cualquier cambio requiere actualización de este documento.

**Referencias**:
- AGENTS.md Sección 12 (Autenticación)
- ERR-20260225-001 (Multi-console sessions)
