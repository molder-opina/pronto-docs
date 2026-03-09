ID: API-20260307-010
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: config expone múltiples endpoints públicos sin autenticación
DESCRIPCION:
  El módulo `pronto-api/src/api_app/routes/config.py` exponía endpoints operativos sin autenticación:
  `store_cancel_reason`, `client_session_validation_interval_minutes` y el alias legacy `GET /api/config/public`.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/config.py`.
  2. Revisar los decoradores de `store_cancel_reason`, `client_session_validation_interval_minutes` y `get_public_config`.
  3. Confirmar ausencia de auth en esas rutas.
RESULTADO_ACTUAL:
  Las rutas cliente específicas exigen sesión de cliente y el alias legacy `/api/config/public` ya no es público.
RESULTADO_ESPERADO:
  Restringir acceso a endpoints operativos y mantener el bootstrap público solo en la ruta canónica `/api/public/config`.
UBICACION:
  - `pronto-api/src/api_app/routes/config.py`
  - `pronto-employees/src/pronto_employees/routes/api/config.py`
  - `pronto-api/tests/test_security_regressions.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadió `@require_customer_session` a `GET /api/config/store_cancel_reason` y `GET /api/config/client_session_validation_interval_minutes`.
  Además, `GET /api/config/public` quedó restringido con `@jwt_required` + `@admin_required` como alias legacy, mientras que el proxy de `pronto-employees`
  fue actualizado para consumir la ruta pública canónica `GET /api/public/config`.
  Se agregaron regresiones self-contained en `pronto-api/tests/test_security_regressions.py` cubriendo 401 anónimo y acceso con sesión para `store_cancel_reason`.
  Validación: `python3 -m py_compile pronto-api/src/api_app/routes/config.py pronto-employees/src/pronto_employees/routes/api/config.py pronto-api/tests/test_security_regressions.py` => OK;
  `pronto-api/.venv/bin/python -m pytest pronto-api/tests/test_security_regressions.py -q` => `21 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
