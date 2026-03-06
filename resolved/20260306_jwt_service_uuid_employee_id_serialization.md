ID: AUTH-20260306-001
FECHA: 2026-03-06
PROYECTO: pronto-libs, pronto-tests
SEVERIDAD: alta
TITULO: jwt_service no serializa employee_id UUID en access/refresh tokens
DESCRIPCION:
  Las funciones `create_access_token()` y `create_refresh_token()` en `pronto_shared.jwt_service`
  guardaban `employee_id` crudo dentro del payload JWT. Cuando el ID llegaba como `uuid.UUID` —tipo
  canónico de empleados— `jwt.encode()` fallaba al serializar el payload JSON.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/integration/test_jwt_scope_guard.py -q`.
  2. Observar fallo en `create_access_token(employee_id=sample_employee.id, ...)`.
RESULTADO_ACTUAL:
  `TypeError: Object of type UUID is not JSON serializable` al serializar el claim `employee_id`.
RESULTADO_ESPERADO:
  Los helpers JWT deben aceptar IDs `UUID`, `str` o `int` y serializarlos consistentemente como
  strings dentro de los claims (`sub`, `employee_id`).
UBICACION:
  - `pronto-libs/src/pronto_shared/jwt_service.py`
EVIDENCIA:
  - Falla reproducible en suites JWT
  - `create_access_token()` ya convertía `sub` a `str(employee_id)` pero dejaba `employee_id` crudo
HIPOTESIS_CAUSA:
  El helper JWT quedó tipado históricamente para IDs enteros, pero el modelo canónico de empleados
  migró a UUID; el payload no se normalizó completamente para JSON.
ESTADO: RESUELTO
SOLUCION:
  Se agregó `_normalize_employee_claim_id(...)` en `jwt_service.py` y se normalizó `employee_id` en
  `create_access_token()` y `create_refresh_token()`. También se añadió `pronto-libs/tests/unit/test_jwt_service.py`
  para cubrir serialización de UUID en access/refresh tokens.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06