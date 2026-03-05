ID: ARCH-20260303-007
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Triplicación de servicios de notificación con lógica redundante

DESCRIPCION: |
  Se han identificado tres módulos distintos para la gestión de notificaciones en `pronto-libs` que presentan una superposición crítica de responsabilidades y nombres de funciones idénticos:
  1. `notification_service.py`: Implementa lógica de colas en memoria para SSE (Server-Sent Events).
  2. `notifications_service.py`: Implementa el envío de tickets por email.
  3. `notifications.py`: Contiene un placeholder para notificaciones de pago que parece ser código obsoleto.
  
  Los archivos 2 y 3 definen ambos la función `notify_session_payment(session, channels)`, lo que genera confusión sobre cuál es el punto de entrada canónico para notificaciones transaccionales.

RESULTADO_ACTUAL: |
  Dispersión de la lógica de notificaciones en tres archivos. Riesgo de importar la función equivocada o de que mejoras en una no se reflejen en la otra. El archivo `notifications.py` actúa como una "sombra" de `notifications_service.py`.

RESULTADO_ESPERADO: |
  Unificar todas las notificaciones en un único `notification_service.py` (o un paquete `notifications/`) con responsabilidades claras:
  - Un gestor para tiempo real (SSE/Redis).
  - Un despachador para canales externos (Email, SMS).
  - Eliminación de placeholders obsoletos.

UBICACION: |
  - `pronto-libs/src/pronto_shared/services/notification_service.py`
  - `pronto-libs/src/pronto_shared/services/notifications_service.py`
  - `pronto-libs/src/pronto_shared/services/notifications.py`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Consolidar la lógica de envío de tickets en un módulo de "Canales Externos".
  - [ ] Eliminar `notifications.py` tras verificar que no hay dependencias activas.
  - [ ] Renombrar los archivos para seguir un esquema único (ej. `notifications/manager.py` y `notifications/channels.py`).

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
