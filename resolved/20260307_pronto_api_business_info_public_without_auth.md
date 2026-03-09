ID: API-20260307-009
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: /api/business-info expone endpoint público sin autenticación
DESCRIPCION:
  `GET /api/business-info` estaba expuesto sin autenticación en `pronto-api`, aunque el endpoint representa superficie administrativa.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/employees/business_info.py`.
  2. Revisar `get_business_info`.
  3. Confirmar ausencia de decoradores auth.
RESULTADO_ACTUAL:
  El endpoint requiere JWT con scope admin/system.
RESULTADO_ESPERADO:
  Proteger `/api/business-info` como endpoint administrativo autenticado.
UBICACION:
  - `pronto-api/src/api_app/routes/employees/business_info.py`
  - `pronto-api/tests/test_security_regressions.py`
  - `pronto-tests/tests/functionality/integration/test_business_config_api.py`
  - `pronto-tests/tests/functionality/api/api-tests/test_business_config_api.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadió `@jwt_required` + `@scope_required(["admin", "system"])` a `GET /api/business-info`, alineándolo con el comportamiento ya exigido por `pronto-employees`.
  También se actualizaron tests contractuales duplicados en `pronto-tests` para reflejar que acceso anónimo devuelve 401.
  Validación: `python3 -m py_compile pronto-api/src/api_app/routes/employees/business_info.py pronto-api/tests/test_security_regressions.py pronto-tests/tests/functionality/integration/test_business_config_api.py pronto-tests/tests/functionality/api/api-tests/test_business_config_api.py` => OK;
  `pronto-api/.venv/bin/python -m pytest pronto-api/tests/test_security_regressions.py -q` => pasa, incluyendo 401 anónimo y 200 admin autenticado para `/api/business-info`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
