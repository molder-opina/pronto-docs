---
ID: ERR-20260208-017
FECHA: 2026-02-11
PROYECTO: pronto-api / pronto-client
SEVERIDAD: media
TITULO: Desfase de estado entre JWT y Base de Datos (Session Sync) [RESUELTO]
DESCRIPCION: Se ha implementado una validación estricta del estado de la sesión de comedor tanto en el endpoint de validación de identidad del cliente como en el servicio de creación de órdenes. Esto evita que clientes con tokens JWT válidos pero sesiones cerradas en la DB puedan seguir operando.
ESTADO: RESUELTO
---
SOLUCION:
1.  **Backend (Shared Lib)**: Refactorizado `SessionManager.resolve_or_create` para validar que, si se provee un ID de sesión, esta debe estar en estado 'open'. De lo contrario, se lanza un `OrderValidationError` con código HTTP 409 (Conflict) o 410 (Gone).
2.  **Backend (API)**: Mejorado el endpoint `/api/sessions/me` para retornar información detallada y código 410 cuando la sesión está cerrada.
3.  **Frontend (Client)**: Actualizado `client-base.ts` para detectar específicamente el error 410, notificar al usuario que su sesión ha terminado y redirigirlo automáticamente para limpiar el estado local.
---
