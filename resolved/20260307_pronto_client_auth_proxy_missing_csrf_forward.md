ID: CLI-20260307-003
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: proxy BFF de auth cliente no reenvía X-CSRFToken al pronto-api
DESCRIPCION:
  El BFF auth aceptaba mutaciones cliente pero no propagaba `X-CSRFToken` al `pronto-api`.
PASOS_REPRODUCIR:
  1. Obtener CSRF en `:6080`.
  2. Hacer `POST /api/client-auth/register`.
  3. Observar `The CSRF token is missing.`.
RESULTADO_ACTUAL:
  El backend rechazaba mutaciones auth por CSRF faltante.
RESULTADO_ESPERADO:
  El proxy técnico debía reenviar `X-CSRFToken`.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/auth.py`
EVIDENCIA:
  - `_forward_to_api()` no incluía `X-CSRFToken` en headers reenviados
HIPOTESIS_CAUSA:
  Implementación incompleta del proxy auth.
ESTADO: RESUELTO
SOLUCION:
  Se propagó `X-CSRFToken` desde el request cliente hacia el upstream API.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

