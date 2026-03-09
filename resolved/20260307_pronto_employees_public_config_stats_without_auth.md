ID: EMP-20260307-004
FECHA: 2026-03-07
PROYECTO: pronto-employees
SEVERIDAD: bloqueante
TITULO: endpoints publicos en config y stats fuera de excepciones permitidas
DESCRIPCION:
  `pronto-employees` exponía `/public/config`, `/public/stats` y `/stats/public` sin autenticación,
  aunque el guardrail P0 solo permite excepciones muy acotadas.
PASOS_REPRODUCIR:
  1. Revisar `pronto-employees/src/pronto_employees/routes/api/config.py` y `stats.py`.
  2. Confirmar ausencia de `@jwt_required` en las rutas públicas.
RESULTADO_ACTUAL:
  Los endpoints técnicos de config/stats en `pronto-employees` requieren JWT válido.
RESULTADO_ESPERADO:
  Fuera de login/register pages, todo endpoint del SSR employees debe requerir autenticación válida.
UBICACION:
  - `pronto-employees/src/pronto_employees/routes/api/config.py`
  - `pronto-employees/src/pronto_employees/routes/api/stats.py`
  - `pronto-employees/tests/test_public_endpoint_security_regressions.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadió `@jwt_required` a `GET /public/config` en `config.py` y a `GET /public/stats` / `GET /stats/public` en `stats.py`.
  En el mismo lote, `config.py` pasó a resolver `PRONTO_API_URL` desde `current_app.config` para evitar otro hardcodeo local.
  Se agregaron regresiones self-contained en `pronto-employees/tests/test_public_endpoint_security_regressions.py` cubriendo 401 anónimo para las tres rutas.
  Validación: `python3 -m py_compile pronto-employees/src/pronto_employees/routes/api/stats.py pronto-employees/src/pronto_employees/routes/api/config.py pronto-employees/src/pronto_employees/app.py pronto-employees/tests/test_public_endpoint_security_regressions.py pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py` => OK;
  `PYTHONPATH=pronto-employees/src:pronto-libs/src pronto-api/.venv/bin/python -m pytest pronto-employees/tests/test_public_endpoint_security_regressions.py -q` => `3 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
