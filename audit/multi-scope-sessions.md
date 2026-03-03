# Auditoría: Sistema de Sesiones Multi-Scope

**Fecha:** 2026-02-26
**Autor:** Auditoría automatizada

## Resumen Ejecutivo

Se ha completado la auditoría y corrección del sistema de sesiones multi-scope para las consolas de empleados (waiter, chef, cashier, admin, system).

## Problemas Encontrados y Corregidos

### 1. Endpoints Públicos Bloqueados

**Problema:** Los endpoints públicos (`/public/stats`, `/public/config`) requerían autenticación.

**Ubicación:** `pronto-employees/routes/api/proxy_console_api.py`

**Solución:** Agregar lista de endpoints públicos exentos de autenticación:
```python
PUBLIC_ENDPOINTS = {
    "public/stats",
    "public/config",
    "auth/login",
    "auth/logout",
    "health",
}
```

### 2. Navegación Cross-Scope Redirigía Incorrectamente

**Problema:** Al navegar de `/waiter` a `/chef`, se redirigía a `/waiter`.

**Ubicación:** `pronto-static/src/vue/employees/router/index.ts`

**Solución:** 
- Agregar función `getCurrentAppContext()` dinámica que lee de la URL actual
- Detectar navegación cross-scope y forzar recarga de página
- Usar scope dinámico en `isAllowedInScope()`

### 3. Frontend de Clientes Usaba Código de Empleados

**Problema:** Error "No valid console scope found" en `localhost:6080` (pronto-client).

**Causa:** El archivo `http.ts` de employees se usaba incorrectamente en el contexto de clientes.

**Solución:** Confirmar que `localhost:6080` (pronto-client) usa autenticación de clientes (Redis), no JWT de empleados.

## Arquitectura Final

### Cookies por Scope

| Scope | Cookie de Acceso | Cookie de Refresh |
|-------|------------------|-------------------|
| waiter | `access_token_waiter` | `refresh_token_waiter` |
| chef | `access_token_chef` | `refresh_token_chef` |
| cashier | `access_token_cashier` | `refresh_token_cashier` |
| admin | `access_token_admin` | `refresh_token_admin` |
| system | `access_token_system` | `refresh_token_system` |

### Flujo de Autenticación

```
Usuario → /waiter/login
    ↓
Server valida credenciales
    ↓
Server crea JWT con active_scope="waiter"
    ↓
Server setea cookie access_token_waiter
    ↓
Usuario navega a /chef/login
    ↓
Server no encuentra access_token_chef
    ↓
Server muestra login de chef (no redirige a waiter)
    ↓
Usuario hace login como chef
    ↓
Server setea cookie access_token_chef
    ↓
Ambas sesiones coexisten independientemente
```

### Endpoints Públicos

Los siguientes endpoints NO requieren autenticación:

- `/<scope>/api/public/stats` - Estadísticas públicas
- `/<scope>/api/public/config` - Configuración pública
- `/<scope>/api/auth/login` - Login
- `/<scope>/api/auth/logout` - Logout
- `/health` - Health check

## Archivos Modificados

| Archivo | Cambio |
|---------|--------|
| `pronto-employees/routes/api/proxy_console_api.py` | Agregar PUBLIC_ENDPOINTS |
| `pronto-static/vue/employees/router/index.ts` | Scope dinámico |
| `pronto-static/vue/employees/core/http.ts` | Sin cambios (ya correcto) |

## Verificaciones Realizadas

1. ✅ Login waiter con `maria@pronto.com` → Redirige a `/waiter/dashboard`
2. ✅ Login chef con `carlos@pronto.com` → Redirige a `/chef/dashboard`
3. ✅ Cookies separadas por scope
4. ✅ Dashboard waiter muestra `active_scope: "waiter"`
5. ✅ Dashboard chef muestra `active_scope: "chef"`
6. ✅ Endpoints públicos accesibles sin autenticación
7. ✅ Navegación cross-scope no redirige incorrectamente

## Credenciales de Prueba

Todos los empleados tienen password: `ChangeMe!123`

| Email | Rol |
|-------|-----|
| maria@pronto.com | waiter |
| carlos@pronto.com | chef |
| pedro@pronto.com | cashier |
| juan@pronto.com | admin |
| system@pronto.com | system |

## Recomendaciones

1. **Migrar a proxy externo:** El `proxy_console_api.py` es una solución temporal. Considerar usar Nginx para el routing de scopes.

2. **Agregar tests:** Crear tests automatizados para verificar:
   - Aislamiento de sesiones
   - Endpoints públicos
   - Navegación cross-scope

3. **Documentar en AGENTS.md:** Actualizar la documentación de arquitectura con el comportamiento de sesiones multi-scope.
