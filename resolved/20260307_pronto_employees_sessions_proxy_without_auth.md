ID: EMP-20260307-003
FECHA: 2026-03-07
PROYECTO: pronto-employees
SEVERIDAD: bloqueante
TITULO: sessions proxy expone endpoints de mutacion sin jwt_required
DESCRIPCION:
  `pronto-employees/src/pronto_employees/routes/api/sessions.py` exponía el proxy técnico de sesiones
  sin enforcement de autenticación en `POST /anon-id/<session_id>` y
  `POST /dining-sessions/<session_id>/close`; además `GET /dining-sessions/<session_id>` también
  quedaba accesible sin JWT válido.
PASOS_REPRODUCIR:
  1. Revisar `pronto-employees/src/pronto_employees/routes/api/sessions.py`.
  2. Confirmar ausencia de `@jwt_required` en las rutas declaradas.
RESULTADO_ACTUAL:
  Las rutas del proxy de sesiones exigen JWT antes de reenviar y el módulo dejó de depender de un upstream hardcodeado local.
RESULTADO_ESPERADO:
  Todo endpoint del proxy debe exigir autenticación válida y usar la configuración canónica del servicio para resolver upstream.
UBICACION:
  - `pronto-employees/src/pronto_employees/routes/api/sessions.py`
  - `pronto-employees/tests/test_sessions_proxy_security_regressions.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadió `@jwt_required` a las tres rutas de `sessions.py` (`anon-id`, `get_dining_session`, `close_dining_session`),
  cerrando el acceso anónimo al proxy técnico de sesiones en `pronto-employees`.
  Además, el módulo ahora resuelve el upstream desde `current_app.config['PRONTO_API_URL']` mediante `_get_api_base_url()` en lugar de usar
  `http://api:5000` hardcodeado localmente. Este ajuste reduce parcialmente el alcance del expediente de hosts hardcodeados,
  pero no cierra `EMP-20260307-005` porque todavía quedan otros módulos pendientes.
  Se añadieron regresiones self-contained en `pronto-employees/tests/test_sessions_proxy_security_regressions.py`.
  Validación: `python3 -m py_compile pronto-employees/src/pronto_employees/routes/api/sessions.py pronto-employees/tests/test_sessions_proxy_security_regressions.py` => OK;
  `PYTHONPATH=pronto-employees/src:pronto-libs/src pronto-api/.venv/bin/python -m pytest pronto-employees/tests/test_sessions_proxy_security_regressions.py -q` => `4 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
