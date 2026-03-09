ID: TEST-20260307-022
FECHA: 2026-03-07
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: e2e Python cliente aún usa /api/auth/register en lugar de /api/client-auth/register
DESCRIPCION:
  El test live `test_client_api_business_logic_moved_to_api.py` seguía usando la ruta legacy
  `/api/auth/register` en vez del contrato actual `/api/client-auth/register`.
PASOS_REPRODUCIR:
  1. Ejecutar el e2e Python del cliente.
  2. Observar fallo durante el registro.
RESULTADO_ACTUAL:
  El e2e consumía una ruta legacy.
RESULTADO_ESPERADO:
  El e2e debía ejercitar el contrato actual publicado por el cliente/API.
UBICACION:
  - `pronto-tests/tests/functionality/e2e/test_client_api_business_logic_moved_to_api.py`
EVIDENCIA:
  - `session.post(f"{CLIENT_URL}/api/auth/register", ...)`
HIPOTESIS_CAUSA:
  Desalineación del test durante la migración a `client-auth`.
ESTADO: RESUELTO
SOLUCION:
  Se actualizó el e2e al namespace `client-auth` y se validó el flujo completo live en verde.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

