ID: CLI-20260307-002
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: proxy BFF auth de pronto-client está montado sin prefijo /client-auth
DESCRIPCION:
  El blueprint técnico de auth exponía `/api/login|register|logout|csrf` en lugar de
  `/api/client-auth/*`, causando 404 desde el frontend cliente actual.
PASOS_REPRODUCIR:
  1. Probar `POST /api/client-auth/register` en `:6080`.
  2. Observar 404.
RESULTADO_ACTUAL:
  El BFF no exponía el prefijo esperado.
RESULTADO_ESPERADO:
  El BFF debía publicar `/api/client-auth/*`.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/auth.py`
EVIDENCIA:
  - `Blueprint("client_auth", __name__)` sin `url_prefix`
HIPOTESIS_CAUSA:
  Migración incompleta del namespace auth cliente.
ESTADO: RESUELTO
SOLUCION:
  Se añadió `url_prefix="/client-auth"` al blueprint de auth y se recargó `pronto-client`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

