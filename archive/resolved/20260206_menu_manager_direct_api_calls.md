---
ID: MENU_MANAGER_DIRECT_API_CALLS
FECHA: 20260206
PROYECTO: pronto-static
SEVERIDAD: bloqueante
TITULO: `MenuManager` realiza llamadas directas a la API sin usar el wrapper `http.ts`
DESCRIPCION: El módulo `pronto-static/src/vue/employees/modules/menu-manager.ts` utiliza `fetch` directamente para realizar múltiples llamadas a la API (POST, PUT, DELETE, GET) en `/api/menu-items`, `/api/menu` y otros endpoints. Esto es una violación directa del mandato establecido en `AGENTS.md` (sección 15.2 "Frontend employees (pronto-static) - wrapper obligatorio") que prohíbe el uso de `fetch`/`axios` mutador directo fuera del wrapper en `pronto-static/src/vue/employees/core/http.ts`. Este hallazgo provee evidencia adicional y concreta para el error `FE_API_WRAPPER_NON_COMPLIANCE` previamente documentado y demuestra que la práctica de ignorar el wrapper está extendida en el frontend de empleados.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-static/src/vue/employees/modules/menu-manager.ts`.
2. Buscar ocurrencias de `fetch(` para identificar las llamadas directas a la API.
RESULTADO_ACTUAL: Las llamadas a la API se realizan directamente utilizando `fetch`, sin pasar por el wrapper `authenticatedFetch` o `requestJSON` definido en `http.ts`. Esto podría resultar en un manejo inconsistente de la autenticación, CSRF y errores.
RESULTADO_ESPERADO: Todas las llamadas a la API desde el frontend de empleados, especialmente las mutantes (POST, PUT, PATCH, DELETE), deben utilizar las funciones proporcionadas por el wrapper `pronto-static/src/vue/employees/core/http.ts` (es decir, `requestJSON`).
UBICACION:
- pronto-static/src/vue/employees/modules/menu-manager.ts:L557
- pronto-static/src/vue/employees/modules/menu-manager.ts:L577
- pronto-static/src/vue/employees/modules/menu-manager.ts:L657
- pronto-static/src/vue/employees/modules/menu-manager.ts:L701
EVIDENCIA:
```typescript
// Extract from menu-manager.ts
// L557 (saveProductFromDrawer)
            const response = await fetch(url, {
                method,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });

// L577 (refreshMenuData)
            const response = await fetch('/api/menu');

// L657 (handleToggle)
            const response = await fetch(`/api/menu-items/${productId}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ is_available: newAvailability })
            });

// L701 (handleDelete)
            const response = await fetch(`/api/menu-items/${productId}`, { method: 'DELETE' });
```
HIPOTESIS_CAUSA: Desconocimiento o ignorancia de la directriz de `AGENTS.md` o la existencia de un mecanismo alternativo no documentado para las llamadas a la API, o el código de `http.ts` es código muerto.
ESTADO: RESUELTO
SOLUCION: Refactorizado `menu-manager.ts` para usar el wrapper `requestJSON` de `http.ts`:
1. El archivo ya tenía el import: `import { requestJSON } from '../core/http';`
2. Reemplazadas 3 llamadas directas a `fetch()`:
   - L592: `saveProductFromDrawer()` - POST/PUT /api/menu-items (crear/actualizar productos)
   - L613: `refreshMenuData()` - GET /api/menu (obtener catálogo)
   - L678: `handleToggle()` - PUT /api/menu-items/{id} (actualizar disponibilidad)

Beneficios:
- ✅ Manejo automático de CSRF tokens en POST/PUT requests
- ✅ Verificación automática de autenticación (401/403)
- ✅ Type-safe con genéricos TypeScript
- ✅ Manejo consistente de errores con try/catch
- ✅ Cumple con AGENTS.md sección 15.2

FECHA_RESOLUCION: 2026-02-09
---