ID: CLI-20260307-010
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: proxy de sesiones cliente no propaga Set-Cookie del upstream
DESCRIPCION:
  El wrapper de sesiones serializaba JSON y descartaba headers como `Set-Cookie`, rompiendo la persistencia
  de `pronto_client_session` emitida por `POST /api/sessions/open`.
PASOS_REPRODUCIR:
  1. Registrar cliente y fijar `table-context`.
  2. Llamar `POST /api/sessions/open` vía `:6080`.
  3. Perder la cookie de sesión en el cliente.
RESULTADO_ACTUAL:
  El proxy de sesiones descartaba headers upstream.
RESULTADO_ESPERADO:
  Debía actuar como passthrough HTTP transparente.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/sessions.py`
EVIDENCIA:
  - `_forward_to_api()` retornaba `success_response(response.json())`
HIPOTESIS_CAUSA:
  Patrón de serialización JSON en lugar de passthrough HTTP.
ESTADO: RESUELTO
SOLUCION:
  Se convirtió el proxy de sesiones en passthrough transparente, preservando cookies y headers upstream.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

