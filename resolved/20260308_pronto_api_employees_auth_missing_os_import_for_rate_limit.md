ID: API-20260308-EMP-AUTH-OS-IMPORT
FECHA: 2026-03-08
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: employees auth rompe create_app por os no importado en rate_limit
DESCRIPCION: La ruta `pronto-api/src/api_app/routes/employees/auth.py` cambió el decorador de login para usar `os.getenv("FLASK_DEBUG", "0")` en el cálculo dinámico de `max_requests`, pero el módulo no importa `os`. Al importar blueprints desde `api_app.app`, Flask falla con `NameError: name 'os' is not defined`, bloqueando suites que construyen la app.
PASOS_REPRODUCIR:
1. Ejecutar `cd pronto-tests && PYTHONPATH=.:../pronto-api/src:../pronto-libs/src ../pronto-libs/.venv/bin/python -m pytest tests/functionality/integration/test_menu_home_publish_api.py -q`
2. Observar el fallo durante `from api_app.app import create_app`
3. Ver `NameError` en `pronto-api/src/api_app/routes/employees/auth.py:36`
RESULTADO_ACTUAL: La app carga correctamente y las suites vuelven a construir `create_app()` sin errores.
RESULTADO_ESPERADO: El módulo debe importar `os` y permitir que `create_app()` cargue normalmente tanto en runtime como en pruebas.
UBICACION: pronto-api/src/api_app/routes/employees/auth.py
EVIDENCIA: `NameError: name 'os' is not defined` al construir Flask app en suites de `pronto-tests`.
HIPOTESIS_CAUSA: Se introdujo rate limiting dinámico dependiente de `FLASK_DEBUG` sin actualizar el bloque de imports del módulo.
ESTADO: RESUELTO
SOLUCION: Se añadió `import os` al módulo `employees/auth.py` para sostener el decorador `@rate_limit(...)` ya presente y se validó el comportamiento con `ruff` y `pytest` sobre `tests/test_security_regressions.py`; además se aprovecharon las suites ya desbloqueadas para agregar cobertura de feedback público de menú, publish/preview de menu-home, side-effects de notificaciones de órdenes y dedupe intra-módulo.
COMMIT: 74cf5de,b268f1d
FECHA_RESOLUCION: 2026-03-08

