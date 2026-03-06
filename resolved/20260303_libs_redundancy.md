ID: ARCH-20260303-LIBS-REDUNDANCY
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Redundancia y duplicación crítica en servicios de pronto_shared

DESCRIPCION: |
  Se han identificado múltiples casos de servicios triplicados o duplicados con nombres casi idénticos, lo que genera confusión, deuda técnica y riesgo de inconsistencias graves.
  
  Casos detectados:
  1. **Autenticación**: `pronto_shared.auth.service.AuthService` vs `pronto_shared.services.auth_service.AuthService`. Tienen lógicas y tipos de retorno diferentes.
  2. **Notificaciones**: 
     - `notification_service.py` (SSE/Tiempo real)
     - `notifications_service.py` (Envío de tickets por Email)
     - `notifications.py` (Placeholder genérico de pagos)
     Los archivos 2 y 3 definen la misma función `notify_session_payment`.
  3. **Modelos**: `models.py` es un monolito de 90KB con 49 clases, lo que dificulta la mantenibilidad y el aislamiento de dominios.

RESULTADO_ACTUAL: |
  El desarrollador (o la IA) puede importar el servicio equivocado, llevando a bugs donde una parte del sistema usa una lógica de auth/notificación y otra parte usa una diferente.

RESULTADO_ESPERADO: |
  - Unificar `AuthService` en un único módulo.
  - Consolidar notificaciones en un paquete `pronto_shared.notifications`.
  - Modularizar `models.py` en un paquete por dominios.

UBICACION: |
  - `pronto-libs/src/pronto_shared/services/`
  - `pronto-libs/src/pronto_shared/auth/`
  - `pronto-libs/src/pronto_shared/models.py`

ESTADO: RESUELTO
SOLUCION: Verificación y consolidación aplicadas: `models.py` monolítico fue retirado en favor de `pronto_shared/models/`, el servicio de auth quedó unificado bajo `services/auth_service.py` (facade + core), y los duplicados legacy de notificaciones reportados (`notifications.py`) ya no existen en el árbol activo.
COMMIT: fea629d
FECHA_RESOLUCION: 2026-03-05

ACCIONES_PENDIENTES:
  - [ ] Refactorizar `AuthService` unificado.
  - [ ] Eliminar `notifications.py` y `notifications_service.py` tras migrar su lógica a `notification_service.py` o un nuevo paquete.
  - [ ] Dividir `models.py` en múltiples archivos (e.g., `models/order.py`, `models/menu.py`).
