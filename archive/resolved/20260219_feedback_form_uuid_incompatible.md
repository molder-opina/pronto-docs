ID: ERR-20260219-FEEDBACK-FORM-UUID
FECHA: 2026-02-19
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Ruta web de feedback parsea session_id y employee_id como int en dominio UUID
DESCRIPCION: La ruta `/feedback` convierte `session_id` y `employee_id` con `type=int`, pero `DiningSession` y `Employee` usan UUID. Esto rompe el acceso por query string valida y puede disparar errores de base de datos.
PASOS_REPRODUCIR:
1) Ejecutar `GET /feedback?session_id=550e8400-e29b-41d4-a716-446655440000`.
2) Ejecutar `GET /feedback?session_id=123`.
3) Revisar respuestas HTTP.
RESULTADO_ACTUAL: Con UUID devuelve `400 Session ID requerido` (porque `type=int` descarta el valor). Con entero devuelve `500 {"error":"Error de base de datos"}` por mismatch de tipo en consulta.
RESULTADO_ESPERADO: La ruta debe aceptar y validar UUID para `session_id` y `employee_id`, y retornar respuestas funcionales o errores de validacion controlados.
UBICACION: /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/routes/web.py:117, /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/routes/web.py:118, /Users/molder/projects/github-molder/pronto/pronto-libs/src/pronto_shared/models.py:452, /Users/molder/projects/github-molder/pronto/pronto-libs/src/pronto_shared/models.py:211
EVIDENCIA: `request.args.get(\"session_id\", type=int)` y `request.args.get(\"employee_id\", type=int)` en la ruta; pruebas manuales devolvieron 400 para UUID y 500 para entero.
HIPOTESIS_CAUSA: Codigo heredado de esquema previo con IDs numericos no actualizado tras migracion a UUID.
ESTADO: RESUELTO
SOLUCION: La ruta `/feedback` fue actualizada para parsear `session_id` y `employee_id` como UUID (no `int`), validar formato explícitamente y consultar `DiningSession` con tipo correcto. También se normalizó el render de valores en template.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-19
