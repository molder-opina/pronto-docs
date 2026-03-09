ID: CLI-20260307-007
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: proxies técnicos del cliente no reenvían cookies/session al upstream de forma consistente
DESCRIPCION:
  Tras corregir auth, el mismo patrón apareció en otros proxies del cliente: faltaba `cookies=request.cookies`.
PASOS_REPRODUCIR:
  1. Registrar cliente vía BFF.
  2. Invocar mutaciones protegidas por CSRF.
  3. Observar `The CSRF session token is missing.`.
RESULTADO_ACTUAL:
  Los proxies cliente perdían la sesión CSRF al reenviar mutaciones.
RESULTADO_ESPERADO:
  Todo BFF técnico cliente debía reenviar cookies al API.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/feedback_email.py`
  - `pronto-client/src/pronto_clients/routes/api/orders.py`
  - `pronto-client/src/pronto_clients/routes/api/payments.py`
  - `pronto-client/src/pronto_clients/routes/api/sessions.py`
EVIDENCIA:
  - helpers `_forward_to_api()` sin `cookies=request.cookies`
HIPOTESIS_CAUSA:
  Implementación parcial del patrón de proxy técnico.
ESTADO: RESUELTO
SOLUCION:
  Se añadió passthrough de cookies en los proxies cliente afectados y se validó el flujo funcional completo.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

