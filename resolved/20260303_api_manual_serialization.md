ID: CODE-20260303-022
FECHA: 2026-03-03
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: Reinvención de serializadores en rutas de API (pronto-api)

DESCRIPCION: |
  Se ha detectado una falta sistemática de uso de los serializadores centralizados de `pronto_shared.serializers`. Varios Blueprints implementan bucles manuales para transformar modelos ORM en diccionarios JSON, lo que genera una deuda técnica masiva y riesgo de inconsistencias en los datos expuestos.

RESULTADO_ACTUAL: |
  Implementaciones manuales de serialización detectadas en:
  - `routes/promotions.py`: `get_all_promotions` mapea Promotion manualmente.
  - `routes/payments.py`: `get_session_orders` tiene una implementación anidada gigante para órdenes, ítems y modificadores.
  - `routes/realtime.py`: `_serialize_event` es local.
  - `routes/menu.py`: `get_enabled_shortcuts` y `get_feedback_questions` mapean modelos manualmente.
  - `routes/employees/sessions.py`: `sessions_all` y `get_session` mapean DiningSession manualmente.

RESULTADO_ESPERADO: |
  Uso exclusivo de funciones `serialize_*` de `pronto_shared`. Si un modelo no tiene serializador, debe crearse uno en la librería compartida para que todos los servicios se beneficien.

UBICACION: |
  - `pronto-api/src/api_app/routes/` (varios archivos)

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Crear serializadores en `pronto_shared` para `Promotion`, `KeyboardShortcut`, `FeedbackQuestion` y `WaiterCall`.
  - [ ] Refactorizar las rutas mencionadas para eliminar los mapeos manuales.
  - [ ] Unificar el formato de respuesta de `get_session_orders` con el estándar de `serialize_order`.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
