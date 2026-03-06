ID: TEST-20260306-001
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: conftest.py resuelve mal repo root y rompe imports de api_app en suites JWT
DESCRIPCION:
  El `conftest.py` central de `pronto-tests` calculaba rutas de descubrimiento usando
  `Path(__file__).parent.parent.parent`, lo que desde `pronto-tests/conftest.py` apuntaba fuera del
  workspace `pronto/`. Como consecuencia, el fixture `flask_app` no podía importar
  `api_app.app.create_app` y las suites JWT fallaban con `ModuleNotFoundError` antes de ejecutar sus asserts.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/integration/test_jwt_scope_guard.py -q`.
  2. Observar error en fixture `flask_app`.
RESULTADO_ACTUAL:
  `ModuleNotFoundError: No module named 'api_app'` en `pronto-tests/conftest.py`.
RESULTADO_ESPERADO:
  El harness debe resolver correctamente el root del workspace e incluir `pronto-api/src` en
  `sys.path` para que los tests puedan importar `api_app.app`.
UBICACION:
  - `pronto-tests/conftest.py`
EVIDENCIA:
  - `Path(__file__).parent.parent.parent` desde `pronto-tests/conftest.py` resolvía a `/Users/molder/projects/github-molder`, no a `/Users/molder/projects/github-molder/pronto`
  - `pytest` fallaba con `ModuleNotFoundError: No module named 'api_app'`
HIPOTESIS_CAUSA:
  El harness asumió una jerarquía de directorios anterior y también asumió que `pronto-api` estaba
  instalado en editable, dejando de insertar explícitamente `pronto-api/src` al `sys.path`.
ESTADO: RESUELTO
SOLUCION:
  Se corrigió el cálculo de `repo_root` a partir de `Path(__file__).resolve().parent.parent` y se
  restauró la inserción explícita de `pronto-api/src` y `pronto-client/src` al `sys.path` en
  `pronto-tests/conftest.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06