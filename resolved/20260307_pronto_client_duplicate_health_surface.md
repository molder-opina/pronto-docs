ID: CLIENT-20260307-010
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: baja
TITULO: superficie de health duplicada con /health y /api/health
DESCRIPCION:
  El servicio exponía health por dos caminos distintos: ruta directa en `app.py` (`/health`) y blueprint API legacy
  (`/api/health`). AGENTS define excepción pública explícita para `/health`; mantener dos superficies aumentaba
  ambigüedad operativa y deriva de contrato.
PASOS_REPRODUCIR:
  1. Revisar `app.py` y `routes/api/health.py`.
  2. Verificar definición de ambos endpoints.
RESULTADO_ACTUAL:
  Queda un único endpoint canónico de health: `/health`.
RESULTADO_ESPERADO:
  Mantener un único endpoint canónico de health (`/health`) con versión vigente.
UBICACION:
  - `pronto-client/src/pronto_clients/app.py`
  - `pronto-client/src/pronto_clients/routes/api/__init__.py`
  - `pronto-tests/scripts/diagnostic/api/backend_diagnostic.py`
  - `pronto-tests/scripts/diagnostic/ui/frontend_diagnostic.py`
  - `pronto-docs/pronto-clients/README.md`
ESTADO: RESUELTO
SOLUCION:
  Se retiró el registro del blueprint `health_bp` de `routes/api/__init__.py`, se eliminó el módulo legacy
  `routes/api/health.py`, y se actualizaron diagnósticos y README para consultar/documentar `GET /health` en lugar
  de `/api/health`. Validación: `python3 -m py_compile` sobre `routes/api/__init__.py` y scripts diagnósticos => OK;
  `test ! -f pronto-client/src/pronto_clients/routes/api/health.py` => OK; grep en código/diagnósticos/docs vivas =>
  sin referencias activas a `/api/health` en `pronto-client`, `pronto-tests/scripts/diagnostic` ni `pronto-docs/pronto-clients/README.md`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
