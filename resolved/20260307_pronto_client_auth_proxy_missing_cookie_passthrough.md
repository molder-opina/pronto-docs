ID: CLI-20260307-004
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: proxy BFF auth cliente no reenvía cookies/session ni propaga Set-Cookie del upstream
DESCRIPCION:
  Tras corregir CSRF, el auth proxy seguía rompiendo la sesión porque no reenviaba cookies al API
  ni devolvía `Set-Cookie` del upstream al navegador.
PASOS_REPRODUCIR:
  1. Obtener token de `/api/client-auth/csrf`.
  2. Ejecutar `POST /api/client-auth/register`.
  3. Observar `The CSRF session token is missing.`.
RESULTADO_ACTUAL:
  El proxy auth no era transparente con cookies/headers.
RESULTADO_ESPERADO:
  El proxy debía reenviar cookies y propagar `Set-Cookie`.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/auth.py`
EVIDENCIA:
  - `_forward_to_api()` usaba requests sin `cookies=request.cookies`
  - la respuesta descartaba headers upstream
HIPOTESIS_CAUSA:
  Implementación incompleta del BFF auth.
ESTADO: RESUELTO
SOLUCION:
  Se convirtió el auth proxy en passthrough HTTP transparente para cookies y `Set-Cookie`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

