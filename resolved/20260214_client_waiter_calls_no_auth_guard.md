ID: BUG-20260214-005
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: waiter_calls.py sin protección de autenticación ni anti-abuso
DESCRIPCION: |
  POST /api/call-waiter acepta cualquier table_number sin verificar que el
  llamante tenga un dining_session_id válido asociado a esa mesa.
  Cualquier persona puede enviar llamadas de mesero para cualquier mesa
  sin estar autenticada. Los endpoints de status (GET /api/call-waiter/status/<id>)
  tampoco verifican autenticación.
  Esto permite abuso (spam de llamadas) y enumeración de mesas/sesiones.
PASOS_REPRODUCIR: |
  1. Enviar POST /api/call-waiter con body `{"table_number": "A1"}` sin autenticación.
  2. Observar que la llamada se crea exitosamente.
  3. Repetir para cualquier table_number sin restricción.
RESULTADO_ACTUAL: |
  No hay verificación de customer_ref, dining_session_id ni rate limiting.
  Cualquier request con un table_number válido crea una llamada de mesero.
RESULTADO_ESPERADO: |
  Validar que el llamante tiene un dining_session_id en flask.session que
  corresponda al table_number proporcionado. O al menos requerir customer_ref.
  Rate limiting por session/IP.
UBICACION: pronto-client/src/pronto_clients/routes/api/waiter_calls.py (función call_waiter(), línea 17)
EVIDENCIA: La función no importa ni consulta flask.session["customer_ref"] ni dining_session_id en ningún punto.
HIPOTESIS_CAUSA: Se priorizó funcionalidad sobre seguridad en la implementación inicial. El cooldown de 2 minutos (recent_call check) mitiga parcialmente pero no reemplaza autenticación.
ESTADO: RESUELTO
SOLUCION: Corregido en versión 1.0038
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-14
