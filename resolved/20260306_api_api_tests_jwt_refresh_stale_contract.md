ID: TEST-20260306-006
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: test_jwt_refresh.py bajo api/api-tests mantiene contrato legacy de refresh employees
DESCRIPCION:
  La copia del suite `pronto-tests/tests/functionality/api/api-tests/test_jwt_refresh.py` seguía usando
  el contrato legacy de auth employees: rutas `/api/employees/auth/*`, esperaba `refresh_token` en el
  body del login, asumía `data.success` en refresh y no enviaba `X-App-Context` para resolver cookies
  namespaced. Bajo el `api_app` actual, eso generaba fallos sistemáticos aunque el flujo canónico de
  refresh (`/api/auth/*`) ya funcionara y estuviera cubierto por la copia principal del suite.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/api/api-tests/test_jwt_refresh.py -q`.
  2. Observar múltiples fallos por `refresh_token` ausente y refresh sin `X-App-Context`.
RESULTADO_ACTUAL:
  El suite duplicado no validaba el contrato actual de refresh employees y fallaba por expectativas stale.
RESULTADO_ESPERADO:
  La copia bajo `api/api-tests` debe usar rutas canónicas `/api/auth/*`, cookies namespaced por scope,
  `X-App-Context` y el shape real de la respuesta vigente.
UBICACION:
  - `pronto-tests/tests/functionality/api/api-tests/test_jwt_refresh.py`
EVIDENCIA:
  - `KeyError: 'refresh_token'` tras login
  - `400 BAD REQUEST` al hacer POST a refresh sin `X-App-Context`
  - asserts contra `/api/employees/auth/*` y `data["data"]["success"]`
HIPOTESIS_CAUSA:
  El árbol `api/api-tests` conservó una copia previa de los suites JWT que no se actualizó cuando el
  contrato employees migró a `/api/auth/*` con cookies namespaced por scope.
ESTADO: RESUELTO
SOLUCION:
  Se reancló la copia completa del suite al mismo contrato vigente ya validado en `integration/test_jwt_refresh.py`:
  rutas `/api/auth/login` y `/api/auth/refresh`, header `X-App-Context: waiter`, refresh por cookie
  `refresh_token_waiter`, validación de claims vía `decode_token(...)` y bypass explícito del rate limit
  en testing. La copia quedó alineada con el comportamiento real del `api_app` bajo prueba.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06