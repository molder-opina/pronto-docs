ID: EMP-20260307-001
FECHA: 2026-03-07
PROYECTO: pronto-employees
SEVERIDAD: bloqueante
TITULO: registro de api_bp por scope genera prefijos duplicados /{scope}/api/api/*
DESCRIPCION:
  El expediente asumía que `api_bp = Blueprint(..., url_prefix="/api")` más `app.register_blueprint(api_bp, url_prefix=f"/{scope}/api")` producirían rutas efectivas `/{scope}/api/api/*`.
PASOS_REPRODUCIR:
  1. Revisar `pronto-employees/src/pronto_employees/routes/api/__init__.py` y `app.py`.
  2. Construir el `url_map` real de `create_app()` en `PRONTO_ROUTES_ONLY=1`.
RESULTADO_ACTUAL:
  Las rutas scopeadas reales registradas por Flask son `/{scope}/api/*`, sin duplicación de `/api`.
RESULTADO_ESPERADO:
  Las rutas scope-aware deben resolver a `/{scope}/api/*` sin duplicar `/api`.
UBICACION:
  - `pronto-employees/src/pronto_employees/routes/api/__init__.py`
  - `pronto-employees/src/pronto_employees/app.py`
ESTADO: RESUELTO
SOLUCION:
  No fue necesario modificar código. Se verificó que el `url_prefix` pasado a `app.register_blueprint(...)` está sobrescribiendo el prefijo del blueprint padre en el registro efectivo, por lo que Flask expone rutas como `/admin/api/config`, `/waiter/api/config`, etc., no `/admin/api/api/config`.
  Evidencia de validación: `create_app()` en routes-only imprime rutas reales como `/admin/api/config`, `/waiter/api/config`, `/chef/api/config`, `/cashier/api/config`, `/system/api/config`; además `rg -n '/api/api/' pronto-tests pronto-static pronto-employees` no encontró consumidores ni referencias activas a un prefijo duplicado.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
