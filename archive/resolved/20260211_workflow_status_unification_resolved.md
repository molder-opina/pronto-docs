---
ID: WIDESPREAD_LEGACY_WORKFLOW_STATUS_HANDLING
FECHA: 20260211
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Unificación de Workflow Status a Canonical [RESUELTO]
DESCRIPCION: Se ha eliminado la dualidad entre `LegacyWorkflowStatus` y `CanonicalWorkflowStatus` en el portal de empleados. El sistema ahora utiliza exclusivamente el modelo canónico definido en `shared/workflow/status.ts`, reduciendo la deuda técnica y el riesgo de inconsistencias.
ESTADO: RESUELTO
---
SOLUCION:
1.  **Estandarización**: Confirmado `CanonicalWorkflowStatus` como el estándar único en `pronto-static/src/vue/shared/workflow/status.ts`.
2.  **Refactorización de Cashier Board**: 
    - Eliminado el tipo `LegacyWorkflowStatus` y el mapeo `CANONICAL_TO_LEGACY` en `cashier-board.ts`.
    - Reemplazada la función local `normalizeWorkflowStatus` por el helper compartido `toCanonical`.
    - Actualizadas las interfaces `OrderInfo` y la lógica de renderizado para operar exclusivamente con estados canónicos.
3.  **Auditoría de Módulos**: Verificado que los módulos de mesero (`waiter-board.ts`), cocina (`kitchen-board.ts`) y órdenes (`orders-board.ts`) ya utilizan correctamente el modelo canónico.
4.  **Verificación**: Build de empleados completado exitosamente sin errores de tipos.
---
