---
ID: WIDESPREAD_LEGACY_WORKFLOW_STATUS_HANDLING
FECHA: 20260206
PROYECTO: pronto-static, pronto-api
SEVERIDAD: media
TITULO: Gestión extendida de `LegacyWorkflowStatus` y `CanonicalWorkflowStatus`
DESCRIPCION: Múltiples módulos tanto en el frontend de Vue/TypeScript como en el backend de Flask/Python implementan explícitamente tipos `LegacyWorkflowStatus` y `CanonicalWorkflowStatus`, junto con lógica de normalización y mapeo (`CANONICAL_TO_LEGACY`, `normalizeWorkflowStatus`). Esto indica una coexistencia o una estrategia de transición en curso entre dos modelos de estado de flujo de trabajo. Aunque la lógica está presente para manejar esta dualidad, añade una complejidad considerable a la base de código y aumenta el riesgo de inconsistencias si no se mantiene de manera rigurosa.
PASOS_REPRODUCIR:
1. Inspeccionar archivos como `pronto-static/src/vue/employees/modules/cashier-board.ts`, `pronto-static/src/vue/employees/modules/kitchen-board.ts`, `pronto-static/src/vue/employees/modules/waiter-board.ts`, `pronto-static/src/vue/clients/modules/active-orders.ts`, `pronto-static/src/vue/clients/modules/thank-you.ts` y `pronto-api/src/api_app/routes/orders.py`.
2. Observar las definiciones de tipos como `LegacyWorkflowStatus` y `CanonicalWorkflowStatus`, y las funciones `normalizeWorkflowStatus` o comentarios que mencionan "compatibility flags".
RESULTADO_ACTUAL: La base de código gestiona activamente dos conjuntos de definiciones de estado para los flujos de trabajo de órdenes, lo que introduce complejidad en la comprensión y el mantenimiento del sistema.
RESULTADO_ESPERADO: Se debería migrar completamente a un único `CanonicalWorkflowStatus` para simplificar la lógica y reducir la superficie de error, o justificar la necesidad a largo plazo de mantener ambos y documentar exhaustivamente su interacción.
UBICACION:
- pronto-static/src/vue/employees/modules/cashier-board.ts:L14, L24, L34, L86, L97
- pronto-static/src/vue/employees/modules/kitchen-board.ts:L17, L27, L37, L99, L110
- pronto-static/src/vue/employees/modules/waiter-board.ts:L194, L4236
- pronto-static/src/vue/clients/modules/active-orders.ts:L71
- pronto-static/src/vue/clients/modules/thank-you.ts:L335, L431
- pronto-api/src/api_app/routes/orders.py:L4 (comentario), L58 (comentario)
EVIDENCIA:
```typescript
// Extract from pronto-static/src/vue/employees/modules/cashier-board.ts
type LegacyWorkflowStatus = /* ... */ ;
type CanonicalWorkflowStatus = /* ... */ ;
type WorkflowStatus = LegacyWorkflowStatus | CanonicalWorkflowStatus;
// ...
const CANONICAL_TO_LEGACY: Record<CanonicalWorkflowStatus, LegacyWorkflowStatus> = { /* ... */ };
const normalizeWorkflowStatus = (status: WorkflowStatus, legacy?: LegacyWorkflowStatus): LegacyWorkflowStatus => { /* ... */ };
```
```python
# Extract from pronto-api/src/api_app/routes/orders.py
Source of truth: Order.workflow_status.
# ...
# Keep compatibility flags if caller uses include_closed/include_delivered.
```
HIPOTESIS_CAUSA: La migración de un sistema de estados anterior a uno canónico no se ha completado, o existe una necesidad específica de mantener compatibilidad con versiones anteriores o sistemas externos que aún utilizan los estados legacy.
ESTADO: ABIERTO
---