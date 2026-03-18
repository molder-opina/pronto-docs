ID: BUG-20260310-PRONTO-API-FEEDBACK-EMAIL-UUID-CAST-AND-DUPLICATE-QUESTIONS-ROUTE
FECHA: 2026-03-10
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: `feedback.py` introduce cast inválido UUID→int y duplica `feedback/questions` con contrato distinto
DESCRIPCION: Durante la curación de `pronto-api`, el diff actual agregó en `src/api_app/routes/feedback.py` un bloque nuevo para feedback por email. Ese bloque hacía `int(order_id)` y `int(session_id)` en `trigger_feedback_email()` aunque la ruta usa `<uuid:order_id>` y `DiningSession.id` es UUID. Además agregó un endpoint paralelo `GET /feedback/questions` aunque el contrato canónico ya existe como `POST /api/feedback/questions` en `menu.py`, con payload validado por tests.
PASOS_REPRODUCIR:
1. Revisar `src/api_app/routes/feedback.py`.
2. Verificar la ruta `@bp.post("/orders/<uuid:order_id>/feedback/email-trigger")`.
3. Observar el cast `int(order_id)` / `int(session_id)` y la ruta adicional `@bp.get("/questions")`.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: El trigger debe trabajar con UUID reales sin casts inválidos y no debe duplicarse `feedback/questions` con un contrato alterno.
UBICACION:
- pronto-api/src/api_app/routes/feedback.py
- pronto-api/src/api_app/routes/menu.py
EVIDENCIA:
- Búsqueda transversal mostró la recurrencia exacta de `int(order_id)` / `int(session_id)` en el bloque nuevo de feedback.
- `pronto-tests/tests/functionality/integration/test_feedback_questions_api.py` valida el contrato `POST /api/feedback/questions`.
- Nuevo test verde: `tests/unit/pronto-api/test_feedback_email_trigger_route.py`.
HIPOTESIS_CAUSA: Migración parcial del sistema de feedback/email que mezcló tipos legacy enteros con modelos/rutas UUID y duplicó una lectura ya existente en otro módulo.
ESTADO: RESUELTO
SOLUCION:
- Se eliminó de `feedback.py` la ruta duplicada `GET /questions` para dejar como canónico el endpoint ya existente en `menu.py`.
- Se corrigió `trigger_feedback_email()` para validar `session_id` como UUID real, verificar consistencia `order.session_id == session_uuid` y pasar UUIDs al servicio sin `int(...)`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

