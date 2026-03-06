ID: OPS-20260306-001
FECHA: 2026-03-06
PROYECTO: pronto-employees, pronto-scripts
SEVERIDAD: alta
TITULO: Imports huérfanos en API de employees y falso positivo en routes-only/parity
DESCRIPCION:
  `pronto-employees/src/pronto_employees/routes/api/__init__.py` importaba y registraba
  `areas_bp` y `tables_bp`, pero los módulos `areas.py` y `tables.py` no existían en el
  árbol actual. Durante la introspección con `PRONTO_ROUTES_ONLY=1`, el script
  `pronto-scripts/lib/api_parity_check.py` capturaba la excepción como `EMP_ERR` en stderr,
  pero aun así devolvía un resultado exitoso, generando una falsa señal verde en
  `pronto-routes-only-check employees` y contaminando `pronto-api-parity-check employees`.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-scripts/bin/pronto-routes-only-check employees --json`.
  2. Observar `EMP_ERR: No module named 'pronto_employees.routes.api.areas'` en stderr.
  3. Verificar que el comando igualmente devolvía `{"ok": true, ...}`.
  4. Inspeccionar `pronto-employees/src/pronto_employees/routes/api/__init__.py`.
RESULTADO_ACTUAL:
  La validación de routes-only/parity podía reportar éxito aunque la app de employees no
  cargara completamente sus blueprints API por imports inexistentes. Adicionalmente,
  `pronto-rules-check` podía caer por una coincidencia histórica en `AI_VERSION_LOG.md`.
RESULTADO_ESPERADO:
  Los imports inexistentes deben eliminarse o alinearse con archivos reales, y el checker
  debe fallar loud si la introspección de employees/api produce errores. El chequeo de
  PostgreSQL legacy no debe leer bitácoras históricas de versionado.
UBICACION:
  - `pronto-employees/src/pronto_employees/routes/api/__init__.py`
  - `pronto-scripts/lib/api_parity_check.py`
  - `pronto-scripts/bin/pronto-rules-check`
EVIDENCIA:
  - `EMP_ERR: No module named 'pronto_employees.routes.api.areas'`
  - `python3 ./pronto-scripts/bin/pronto-rules-check` fallaba por coincidencia histórica en `pronto-docs/versioning/AI_VERSION_LOG.md`
HIPOTESIS_CAUSA:
  Refactor incompleto de rutas API en employees y manejo demasiado tolerante de errores
  en la introspección interna de parity/routes-only.
ESTADO: RESUELTO
SOLUCION:
  Se eliminaron de `pronto-employees/routes/api/__init__.py` los imports, registros y
  exports huérfanos de `areas_bp` y `tables_bp`; en `pronto-scripts/lib/api_parity_check.py`
  la introspección de backend ahora falla explícitamente ante `EMP_ERR` o `API_ERR`
  propagando error real del subproceso; y en `pronto-rules-check` se corrigió la ruta
  canónica a `AGENTS.md` y se excluyó `pronto-docs/versioning/**` del grep de PostgreSQL 13.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06