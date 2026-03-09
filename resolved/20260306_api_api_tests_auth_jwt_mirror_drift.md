ID: TEST-20260306-007
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: Copias auth/JWT bajo api/api-tests siguen desalineadas del contrato actual
DESCRIPCION:
  Los suites duplicados en `pronto-tests/tests/functionality/api/api-tests/` para auth/JWT
  mantienen expectativas legacy aunque sus equivalentes en `integration/` ya fueron reanclados
  al contrato canónico actual. Persisten rutas viejas, shapes de respuesta obsoletos,
  imports stale y/o uso de headers incompletos.
PASOS_REPRODUCIR:
  1. Ejecutar los suites `test_auth_api.py`, `test_employee_auth.py`, `test_jwt_scope_guard.py` y `test_jwt_roles.py` bajo `api/api-tests`.
  2. Observar fallos por rutas legacy, contratos obsoletos o asserts desalineados.
RESULTADO_ACTUAL:
  Las copias bajo `api/api-tests` no validan el contrato vigente de auth employees y generan fallos falsos.
RESULTADO_ESPERADO:
  Las copias deben reflejar el contrato actual usado por `api_app`: `/api/auth/*`, JWT con scope activo,
  cookies namespaced cuando aplique y endpoints canónicos `/api/*` sin prefixes legacy.
UBICACION:
  - `pronto-tests/tests/functionality/api/api-tests/test_auth_api.py`
  - `pronto-tests/tests/functionality/api/api-tests/test_employee_auth.py`
  - `pronto-tests/tests/functionality/api/api-tests/test_jwt_scope_guard.py`
  - `pronto-tests/tests/functionality/api/api-tests/test_jwt_roles.py`
EVIDENCIA:
  - Duplicidad de suites respecto a `integration/`
  - Persistencia de patrones legacy detectados por auditoría (`/api/employees/auth/*`, `shared.*`, rutas scopeadas legacy, `cookie_jar`, etc.)
HIPOTESIS_CAUSA:
  El árbol `api/api-tests` conserva copias antiguas que no se actualizaron junto con las suites principales de `integration/`.
ESTADO: RESUELTO
SOLUCION:
  Se eliminó el árbol duplicado `api/api-tests` para auth/JWT (`test_auth_api.py`,
  `test_employee_auth.py`, `test_jwt_scope_guard.py` y `test_jwt_roles.py`) y la
  cobertura canónica quedó únicamente en `pronto-tests/tests/functionality/integration/`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07