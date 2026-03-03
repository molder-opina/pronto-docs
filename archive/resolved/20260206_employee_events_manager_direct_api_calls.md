---
ID: EMPLOYEE_EVENTS_MANAGER_DIRECT_API_CALLS
FECHA: 20260206
PROYECTO: pronto-static
SEVERIDAD: bloqueante
TITULO: `EmployeeEventsManager` realiza llamadas directas a la API sin usar el wrapper `http.ts`
DESCRIPCION: El módulo `pronto-static/src/vue/employees/modules/employee-events.ts` utiliza `fetch` directamente para realizar múltiples llamadas a la API (GET, POST, HEAD) a `/api/realtime/notifications`, `/api/notifications/waiter/pending`, `/api/notifications/waiter/confirm`, `/api/orders` y `/api/notifications/admin/call`. Esto es una violación directa del mandato establecido en `AGENTS.md` (sección 15.2 "Frontend employees (pronto-static) - wrapper obligatorio") que prohíbe el uso de `fetch`/`axios` mutador directo fuera del wrapper en `pronto-static/src/vue/employees/core/http.ts`. Este hallazgo provee evidencia adicional y concreta para el error `FE_API_WRAPPER_NON_COMPLIANCE` previamente documentado y demuestra que la práctica de ignorar el wrapper está extendida en el frontend de empleados.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-static/src/vue/employees/modules/employee-events.ts`.
2. Buscar ocurrencias de `fetch(` para identificar las llamadas directas a la API.
RESULTADO_ACTUAL: Las llamadas a la API se realizan directamente utilizando `fetch`, sin pasar por el wrapper `authenticatedFetch` o `requestJSON` definido en `http.ts`. Esto podría resultar en un manejo inconsistente de la autenticación, CSRF y errores.
RESULTADO_ESPERADO: Todas las llamadas a la API desde el frontend de empleados deben utilizar las funciones proporcionadas por el wrapper `pronto-static/src/vue/employees/core/http.ts` (es decir, `requestJSON` o `authenticatedFetch`).
UBICACION:
- pronto-static/src/vue/employees/modules/employee-events.ts:L139
- pronto-static/src/vue/employees/modules/employee-events.ts:L238
- pronto-static/src/vue/employees/modules/employee-events.ts:L307
- pronto-static/src/vue/employees/modules/employee-events.ts:L324
- pronto-static/src/vue/employees/modules/employee-events.ts:L493
EVIDENCIA:
```typescript
// Extract from employee-events.ts
// L139 (pollRealtimeEvents)
            const response = await fetch(`/api/realtime/notifications?after_id=${this.lastEventId}&limit=50&timeout_ms=5000`);

// L238 (loadClientRequests)
            const response = await fetch('/api/notifications/waiter/pending');

// L307 (confirmClientRequest)
            const response = await fetch(`/api/notifications/waiter/confirm/${requestId}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ employee_id: window.APP_DATA?.employee_id || null })
            });

// L324 (handleNewOrderNotification)
                const response = await fetch(`/api/orders/${order_id}`, {
                    method: 'HEAD',
                    credentials: 'include'
                });

// L493 (callAdmin)
            const response = await fetch('/api/notifications/admin/call', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message })
            });
```
HIPOTESIS_CAUSA: Desconocimiento o ignorancia de la directriz de `AGENTS.md` o la existencia de un mecanismo alternativo no documentado para las llamadas a la API, o el código de `http.ts` es código muerto.
ESTADO: RESUELTO
SOLUCION: Refactorizado `employee-events.ts` para usar los wrappers `requestJSON` y `authenticatedFetch` de `http.ts`:
1. Agregado import: `import { requestJSON, authenticatedFetch } from '../core/http';`
2. Reemplazadas 5 llamadas directas a `fetch()`:
   - L133: `pollRealtimeEvents()` - GET /api/realtime/notifications (requestJSON)
   - L243: `loadClientRequests()` - GET /api/notifications/waiter/pending (requestJSON)
   - L350: `confirmClientRequest()` - POST /api/notifications/waiter/confirm/{id} (requestJSON)
   - L371: `handleNewOrderNotification()` - HEAD /api/orders/{id} (authenticatedFetch)
   - L581: `callAdmin()` - POST /api/notifications/admin/call (requestJSON)

Beneficios:
- ✅ Manejo automático de CSRF tokens en POST requests
- ✅ Verificación automática de autenticación (401/403)
- ✅ Type-safe con genéricos TypeScript
- ✅ Manejo consistente de errores
- ✅ Cumple con AGENTS.md sección 15.2

Nota: Se usó `authenticatedFetch` para la petición HEAD ya que solo necesita verificar autenticación sin parsear JSON.

FECHA_RESOLUCION: 2026-02-09
---