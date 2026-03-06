ID: TEST-20260306-003
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: Suites JWT de scope/roles siguen apuntando a rutas scopeadas legacy e imports obsoletos
DESCRIPCION:
  Los tests de integración `test_jwt_scope_guard.py` y `test_jwt_roles.py` seguían usando rutas
  `/{scope}/api/*` y endpoints legacy que el `api_app` de pruebas ya no expone, porque el contrato
  canónico actual es `/api/*`. Eso producía falsos `404` que hacían pasar algunos casos por accidente
  y fallar otros con expectativas incorrectas. Además, `test_jwt_roles.py` importaba `shared.jwt_service`,
  módulo inexistente en el repo actual.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/integration/test_jwt_scope_guard.py -q`.
  2. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/integration/test_jwt_roles.py -q`.
  3. Observar `404 NOT FOUND` sobre `/{scope}/api/*` y `ModuleNotFoundError: No module named 'shared'`.
RESULTADO_ACTUAL:
  Las suites no verificaban correctamente `scope_required`, `role_required` ni `admin_required` contra
  endpoints reales del app montado en tests.
RESULTADO_ESPERADO:
  Los tests deben usar rutas canónicas `/api/*` que existan realmente y reflejen el contrato actual
  del backend, además de importar `pronto_shared.jwt_service`.
UBICACION:
  - `pronto-tests/tests/functionality/integration/test_jwt_scope_guard.py`
  - `pronto-tests/tests/functionality/integration/test_jwt_roles.py`
EVIDENCIA:
  - `404 NOT FOUND` en `/waiter/api/orders`, `/admin/api/employees`, `/system/api/settings`, etc.
  - `ModuleNotFoundError: No module named 'shared'` en `test_no_role_in_token_denied`
HIPOTESIS_CAUSA:
  Los suites quedaron anclados a una etapa previa de proxy scopeado y no se actualizaron cuando la
  API employees migró a rutas canónicas `/api/*` dentro de `pronto-api`.
ESTADO: RESUELTO
SOLUCION:
  Se reescribieron ambos suites para usar endpoints canónicos reales (`/api/sessions/all`,
  `/api/menu`, `/api/employees`, `/api/admin/shortcuts`, `/api/areas/areas`, `/api/tables/tables`,
  `/api/sessions/not-a-valid-session/resend`) y se alinearon las expectativas con el contrato actual.
  También se reemplazó el import legacy `shared.jwt_service` por `pronto_shared.jwt_service` y se
  completaron los claims mínimos requeridos al construir el token negativo sin rol.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06