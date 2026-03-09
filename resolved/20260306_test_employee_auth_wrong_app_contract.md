ID: TEST-20260306-005
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: test_employee_auth.py apunta a SSR console routes/imports legacy pero corre contra api_app
DESCRIPCION:
  El suite `pronto-tests/tests/functionality/integration/test_employee_auth.py` fue escrito para rutas
  SSR de `pronto-employees` (`/login`, `/waiter/login`, `/waiter/dashboard`, `/waiter/logout`,
  `/waiter/system_login`), pero el fixture `employee_client` que usa en esta batería monta `api_app.app`.
  Por eso recibía `404` sobre rutas inexistentes en `pronto-api`. Además importaba módulos legacy que ya
  no existen (`shared.models`, `shared.security`, `shared.jwt_service`, `shared.datetime_utils`) y usaba
  la API antigua del cliente de Flask (`cookie_jar`).
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/integration/test_employee_auth.py -q`.
  2. Observar `404 NOT FOUND` en `/login`, `/waiter/login`, `/waiter/dashboard`, `/logout`, etc.
  3. Observar `ModuleNotFoundError: No module named 'shared'` y `AttributeError: 'FlaskClient' object has no attribute 'cookie_jar'`.
RESULTADO_ACTUAL:
  El suite fallaba por apuntar a otra superficie de aplicación y por usar imports/APIs de test obsoletos.
RESULTADO_ESPERADO:
  El archivo debe validar autenticación employees sobre el contrato real disponible en este harness:
  `/api/auth/login`, `/api/auth/logout`, `/api/auth/me`, cookies namespaced por scope, y JWT emitido
  por `pronto_shared.jwt_service`.
UBICACION:
  - `pronto-tests/tests/functionality/integration/test_employee_auth.py`
EVIDENCIA:
  - `404` en rutas SSR no expuestas por `api_app`
  - `ModuleNotFoundError: No module named 'shared'`
  - `AttributeError: 'FlaskClient' object has no attribute 'cookie_jar'`
HIPOTESIS_CAUSA:
  El suite fue copiado desde una etapa previa orientada a `pronto-employees` y nunca se reancló al
  fixture/API real mantenido hoy en `pronto-tests`.
ESTADO: RESUELTO
SOLUCION:
  Se reescribió el archivo completo sobre el contrato canónico `/api/auth/*`: login JSON, cookies
  namespaced por scope, helpers actuales de `pronto_shared`, validación del access token emitido,
  aislamiento de cookies por scope y logout con `X-App-Context`. También se reemplazó el uso de
  `cookie_jar` por `FlaskClient.get_cookie(...)`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06