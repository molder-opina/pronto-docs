ID: EMP-20260307-002
FECHA: 2026-03-07
PROYECTO: pronto-employees
SEVERIDAD: bloqueante
TITULO: promociones expone POST PUT DELETE sin autenticacion obligatoria
DESCRIPCION:
  El módulo `pronto-employees/src/pronto_employees/routes/api/promotions.py` exponía endpoints de lectura y mutación sin enforcement de autenticación/rol, en contradicción con el guardrail P0.
PASOS_REPRODUCIR:
  1. Revisar decorators en `pronto-employees/src/pronto_employees/routes/api/promotions.py`.
  2. Verificar ausencia de `@jwt_required` y control de rol en `GET/POST/PUT/DELETE`.
RESULTADO_ACTUAL:
  El proxy de promociones exige JWT admin/system y además reenvía correctamente las credenciales al upstream.
RESULTADO_ESPERADO:
  Toda operación de promociones en `pronto-employees` debe requerir autenticación válida y rol autorizado.
UBICACION:
  - `pronto-employees/src/pronto_employees/routes/api/promotions.py`
  - `pronto-employees/tests/test_promotions_proxy_security_regressions.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadió `@jwt_required` + `@admin_required` a todos los handlers del proxy (`list`, `create`, `get`, `update`, `delete`) en `promotions.py`.
  Además, `_forward_to_api()` ahora reenvía `Authorization`, `Cookie`, `X-App-Context`, `X-CSRFToken` y `X-Correlation-ID`, alineando el proxy con el patrón ya usado en `config.py` para que quede seguro y funcional.
  Se agregaron regresiones self-contained en `pronto-employees/tests/test_promotions_proxy_security_regressions.py` cubriendo 401 anónimo para list/create/update/delete y propagación de headers al upstream.
  Validación: `python3 -m py_compile pronto-employees/src/pronto_employees/routes/api/promotions.py pronto-employees/tests/test_promotions_proxy_security_regressions.py` => OK;
  `PYTHONPATH=pronto-employees/src:pronto-libs/src pronto-api/.venv/bin/python -m pytest pronto-employees/tests/test_promotions_proxy_security_regressions.py -q` => `5 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
