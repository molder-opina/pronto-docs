ID: EMP-20260307-008
FECHA: 2026-03-07
PROYECTO: pronto-employees
SEVERIDAD: bloqueante
TITULO: proxy_console_api permite admin/system en scope distinto en vez de bloquear mismatch
DESCRIPCION:
  El proxy scope-aware permitía acceso cruzado cuando `jwt_role` era `admin` o `system`, contradiciendo el guardrail AGENTS 12.4.4 que exige `403 SCOPE_MISMATCH` para cualquier `jwt_role != scope`.
PASOS_REPRODUCIR:
  1. Revisar `_validate_scope_match` en `proxy_console_api.py`.
  2. Confirmar el bloque que devolvía `True` para `admin/system` aunque scope difiriera.
RESULTADO_ACTUAL:
  Cualquier mismatch entre rol del JWT y scope de URL se bloquea con `SCOPE_MISMATCH`, incluido admin/system.
RESULTADO_ESPERADO:
  Cualquier mismatch `jwt_role != scope` debe responder `403 SCOPE_MISMATCH`.
UBICACION:
  - `pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py`
  - `pronto-employees/tests/test_proxy_console_scope_mismatch.py`
ESTADO: RESUELTO
SOLUCION:
  Se eliminó la excepción que permitía `admin/system` en scopes distintos dentro de `_validate_scope_match()`.
  Ahora el proxy solo acepta `jwt_role == scope`; cualquier desalineación devuelve el error de mismatch previsto por el contrato.
  Se añadieron regresiones self-contained en `pronto-employees/tests/test_proxy_console_scope_mismatch.py` para el caso válido y para rechazar cruces `admin->waiter` y `system->cashier`.
  Validación: `python3 -m py_compile pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py pronto-employees/tests/test_proxy_console_scope_mismatch.py` => OK;
  `PYTHONPATH=pronto-employees/src:pronto-libs/src pronto-api/.venv/bin/python -m pytest pronto-employees/tests/test_proxy_console_scope_mismatch.py -q` => `3 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
