ID: API-20260307-005
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: critica
TITULO: client_auth interpreta X-PRONTO-CUSTOMER-REF como customer_id y rompe contrato de auth
DESCRIPCION:
  `client_auth.py` trataba `X-PRONTO-CUSTOMER-REF` como si fuera `customer_id` UUID, rompiendo el contrato canónico del header
  y permitiendo fallos/deriva en los endpoints `/api/client-auth/me`.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/client_auth.py`.
  2. Revisar `GET/PUT /api/client-auth/me`.
  3. Confirmar uso directo de `request.headers['X-PRONTO-CUSTOMER-REF']` como UUID de customer.
RESULTADO_ACTUAL:
  Los endpoints usan autenticación canónica de cliente vía `require_customer_session` y `get_current_customer()`.
RESULTADO_ESPERADO:
  Resolver cliente autenticado desde el session store, no desde parse directo del header como UUID.
UBICACION:
  - `pronto-api/src/api_app/routes/client_auth.py`
  - `pronto-api/tests/test_security_regressions.py`
ESTADO: RESUELTO
SOLUCION:
  Se aplicó `@require_customer_session` a `GET/PUT /api/client-auth/me` y se reemplazó el parse manual del header por el uso de
  `get_current_customer()` (alias importado) para resolver el `customer_id` canónico de la sesión. También se renombraron las funciones de ruta
  para evitar colisión con el helper importado. Validación: `python3 -m py_compile pronto-api/src/api_app/routes/client_auth.py pronto-api/tests/test_security_regressions.py` => OK;
  `pronto-api/.venv/bin/python -m pytest pronto-api/tests/test_security_regressions.py -q` => pasa, incluyendo los tests de contrato de `/api/client-auth/me`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
