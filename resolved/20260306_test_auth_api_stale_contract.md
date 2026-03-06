ID: TEST-20260306-004
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: test_auth_api.py sigue esperando shape legacy de login y logout sin X-App-Context
DESCRIPCION:
  El suite `pronto-tests/tests/functionality/integration/test_auth_api.py` quedó desalineado del
  contrato actual de auth employees. `test_login_success` seguía esperando `data.success` dentro de la
  respuesta, mientras el endpoint retorna `success_response({...})` con el payload real bajo `data`
  sin ese flag. Además, `test_logout` invocaba `/api/auth/logout` sin `X-App-Context`, pero el endpoint
  actual exige ese header para resolver las cookies namespaced por scope.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/integration/test_auth_api.py -q`.
  2. Observar `KeyError: 'success'` en `test_login_success`.
  3. Observar `400 BAD REQUEST` en `test_logout` por falta de `X-App-Context`.
RESULTADO_ACTUAL:
  El suite fallaba aunque el contrato actual del endpoint estuviera funcionando según diseño vigente.
RESULTADO_ESPERADO:
  Los tests deben validar el shape real de login y enviar `X-App-Context` en logout para ejercitar el
  flujo namespaced de cookies de employees.
UBICACION:
  - `pronto-tests/tests/functionality/integration/test_auth_api.py`
EVIDENCIA:
  - `KeyError: 'success'` al leer `data["data"]["success"]`
  - `400 BAD REQUEST` en `/api/auth/logout` sin `X-App-Context`
HIPOTESIS_CAUSA:
  El suite conserva expectativas previas al endurecimiento del contrato por scope/cookies namespaced
  en auth employees.
ESTADO: RESUELTO
SOLUCION:
  Se alineó `test_auth_api.py` al contrato vigente: `login_success` ahora valida `status`,
  `error`, `data.message`, `data.employee`, `data.access_token` y la emisión de cookies
  `access_token_waiter`/`refresh_token_waiter`; `logout` ahora envía `X-App-Context: waiter`
  y valida el shape real de `success_response`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06