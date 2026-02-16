---
ID: WIDESPREAD_LEGACY_WORKFLOW_STATUS_HANDLING
FECHA: 20260211
PROYECTO: pronto-static, pronto-api
SEVERIDAD: media
TITULO: Unificación de Workflow Status a Canonical [RESUELTO]
DESCRIPCION: Se ha eliminado completamente la dualidad de estados de flujo de trabajo (Legacy vs Canonical). El sistema ahora utiliza exclusivamente el modelo canónico en todos los niveles: base de datos, serializadores de API y componentes de frontend.
ESTADO: RESUELTO
---
SOLUCION:
1.  **Frontend (Employees)**: 
    - Refactorizado `cashier-board.ts` para eliminar `LegacyWorkflowStatus` y `CANONICAL_TO_LEGACY`.
    - Actualizados los templates de dashboard para usar `new`, `queued`, `preparing`, etc., en lugar de los términos antiguos.
2.  **Frontend (Clients)**:
    - Refactorizado `active-orders.ts` para eliminar mapeos redundantes como `open_order` y `billed`.
    - Actualizado `thank_you.html` (SSR) para alinear sus constantes de estado con el modelo canónico.
3.  **Backend**:
    - Verificado que `pronto_shared.serializers` y `pronto_shared.services.order_service` ya operan bajo el estándar canónico de forma nativa.
4.  **Verificación**: Construcción exitosa de todos los módulos de frontend y verificación de tipos TypeScript.
---
