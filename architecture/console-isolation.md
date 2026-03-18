# Aislamiento de Consolas - PRONTO

## Regla de Oro

> **"Cada consola es una app dentro de tu app"**

## Principio Arquitectónico

Cada consola de empleados es una unidad independiente y autocontenida con:
- Su propio contexto de ejecución
- Su propio estado aislado
- Sus propios componentes
- Sus propios guards de autorización

## Consolas

| Consola | Ruta | Rol | Dashboard |
|---------|------|-----|-----------|
| Waiter | `/waiter` | Meseros | WaiterDashboard |
| Chef | `/chef` | Cocina | ChefDashboard |
| Cashier | `/cashier` | Cajeros | CashierDashboard |
| Admin | `/admin` | Administradores | AdminDashboard |
| System | `/system` | Sistema | SystemDashboard |

## Aislamiento de Ejecución

### Session Model

```typescript
interface ConsoleSession {
  userId: string;
  roles: string[];
  activeConsole: ConsoleType;
  consolePermissions: Record<ConsoleType, Permission[]>;
}
```

**Reglas:**
1. `activeConsole` define el contexto de ejecución
2. Permisos evaluados por consola, no globalmente
3. NO cross-console state mutable
4. Backend valida scope en cada request

### Guards de Autorización

**Router Guard:**
```typescript
router.beforeEach((to, from, next) => {
  const consoleType = resolveConsoleFromPath(to.path);
  if (!canAccessConsole(user, consoleType)) {
    next('/authorization-error');
    return;
  }
  next();
});
```

**Component Guard:**
```typescript
onMounted(() => {
  if (!canAccessConsole(authStore.user, currentConsole)) {
    redirect('/authorization-error');
  }
});
```

### Stores

**Compartidos (shared/store/):**
- `auth.ts` - Con `activeConsole` en state
- `config.ts` - Configuración global
- `ui.ts` - Estado de UI genérico

**Por consola (opcional):**
- `{console}/store/specific.ts` - Estado específico de consola

**Prohibido:**
- Estado mutable compartido entre consolas
- Roles sin contexto de activeConsole

## Imports

### Permitido ✅

```typescript
// Desde shared (sin depender de consolas)
import { Spinner } from '@shared/components/Spinner.vue'
import { useAuthStore } from '@shared/store/auth'

// Dentro de la misma consola
import { TableNode } from './tables/TableNode.vue'

// System desde admin (excepción única, wrapper pattern)
import { EmployeesManager } from '@admin/components/EmployeesManager.vue'
```

### Prohibido ❌

```typescript
// Cross-console imports
import { WaiterBoard } from '@waiter/components/WaiterBoard.vue'
import { KitchenBoard } from '@chef/components/KitchenBoard.vue'

// Shared importando de consolas
import { WaiterCall } from '@waiter/modules/waiter/types'

// Dashboard compartido con condicionales
if (user.role === 'chef') { /* render chef UI */ }
```

## Matriz de Acceso

| Rol | waiter | chef | cashier | admin | system |
|-----|--------|------|---------|-------|--------|
| **waiter** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **chef** | ❌ | ✅ | ❌ | ❌ | ❌ |
| **cashier** | ❌ | ❌ | ✅ | ❌ | ❌ |
| **admin** | ✅ | ✅ | ✅ | ✅ | ❌ |
| **system** | ❌ | ❌ | ❌ | ✅ | ✅ |

## Justificación

### ¿Por qué aislamiento total?

1. **Seguridad** - Evita fuga de permisos entre roles
2. **Mantenibilidad** - Cambios en una consola no afectan otras
3. **Testing** - Tests aislados, sin efectos colaterales
4. **Performance** - Code splitting por consola
5. **Claridad** - Límites arquitectónicos explícitos

### ¿Por qué System es excepción?

System es un "super-admin" con:
- Acceso universal a admin + system
- Patrón wrapper consciente (no accidente)
- Dashboard propio y aislamiento de ejecución
- Sin duplicación de código (reutiliza admin intencionalmente)

## Validación

### Gate Pre-Commit

```bash
pronto-scripts/bin/pronto-console-isolation-check
```

**Valida:**
- Imports cruzados (debe ser 0)
- Estructura de directorios
- Dashboards propios
- System tiene estructura completa

### Agente IA

`Pronto-Console-Isolation-Agent` - Validación automática con reporte detallado

## Frase Clave

> **"El rol decide si puedes entrar. El activeConsole decide dónde estás."**

## Switch-Scope Flow

Cuando un usuario con múltiples scopes permitidos (ej: admin) navega entre consolas:

1. **Usuario navega** a `/chef` desde `/admin`
2. **Router detecta** scope mismatch (`active_scope='admin'` → necesita `chef`)
3. **Frontend llama** `POST /api/auth/switch-scope` con `{scope: 'chef'}`
4. **Backend valida** que admin puede acceder a chef (vía `ALLOWED_SCOPES_BY_ROLE`)
5. **Backend genera** nuevo JWT con `active_scope='chef'`
6. **Backend setea** cookie `access_token_chef` ( HttpOnly)
7. **Frontend actualiza** estado local (`activeConsole='chef'`)
8. **Navegación continúa** a `/chef`
9. **Requests siguientes** usan cookie `access_token_chef` automáticamente

### Matriz de Switch Válida

| Rol | Puede switchar a |
|-----|------------------|
| waiter | waiter |
| chef | chef |
| cashier | cashier |
| admin | admin, waiter, chef, cashier |
| system | system, admin |

---

## Historial

| Fecha | Versión | Cambio |
|-------|---------|--------|
| 2026-03-17 | 1.0699 | Documentación inicial de aislamiento |
