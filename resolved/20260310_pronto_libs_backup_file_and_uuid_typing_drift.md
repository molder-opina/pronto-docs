ID: LIBS-20260310-BACKUP-FILE-AND-UUID-TYPING-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: `pronto-libs` mantiene un `.bak` dentro de `src/` y expone type hints `int` para `order_id/session_id` en servicios sobre entidades UUID
DESCRIPCION: Durante la curación del lote activo de `pronto-libs` se detectó un artefacto `menu_service_impl.py.bak` dentro de `src/pronto_shared/services/` y drift de tipado en servicios tocados recientemente (`dining_session_service_impl.py`, `feedback_email_service_core.py`), donde `order_id` y `session_id` seguían anotados como `int` aunque `Order` y `DiningSession` son UUID canónicos.
PASOS_REPRODUCIR:
1. Buscar `*.bak` dentro de `pronto-libs/src/`.
2. Buscar patrones `order_id: int` y `session_id: int` en `pronto-libs/src/pronto_shared/services/`.
3. Comparar contra modelos `Order` y `DiningSession` con `UUID(as_uuid=True)`.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: No hay archivos backup/temporales dentro de `src/` y los servicios sensibles usan type hints compatibles con UUID para `order_id/session_id`.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_service_impl.py.bak
- pronto-libs/src/pronto_shared/services/dining_session_service_impl.py
- pronto-libs/src/pronto_shared/services/feedback_email_service_core.py
EVIDENCIA:
- `rg --glob "*.bak"` en el monorepo devolvió solo `pronto-libs/src/pronto_shared/services/menu_service_impl.py.bak`.
- `rg "(order_id|session_id): int"` devolvió múltiples ocurrencias históricas; las del lote activo están en `dining_session_service_impl.py` y `feedback_email_service_core.py`.
- `Order` y `DiningSession` se definen con `UUID(as_uuid=True)` en `pronto_shared/models/order_models.py`.
HIPOTESIS_CAUSA: Refactor parcial de servicios con extracción/migración de código y respaldo manual local dentro de `src/`, sin terminar de alinear type hints con el modelo canónico UUID.
ESTADO: RESUELTO
SOLUCION:
- Se eliminó `pronto-libs/src/pronto_shared/services/menu_service_impl.py.bak`, único backup localizado dentro de `src/` tras la búsqueda transversal con `rg --glob "*.bak"`.
- Se alinearon los type hints sensibles aislables del lote activo a UUID en `dining_session_service_impl.py` (`request_checkout`) y en `feedback_email_service_core.py` (`has_existing_feedback_for_order`, `has_active_token_for_order`, `create_feedback_token`, `should_send_feedback_email`, `trigger_feedback_email`).
- Se validó el fix con `python3 -m py_compile` sobre los archivos tocados y con una nueva búsqueda `rg` que ya no devolvió el `.bak` ni los patrones corregidos.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

