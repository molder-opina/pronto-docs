ID: API-20260307-008A
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: critica
TITULO: split_bills cliente permite acceso débil e IDOR sobre sesiones/divisiones ajenas
DESCRIPCION:
  Las rutas cliente de `split_bills.py` confiaban en un helper de auth débil basado solo en `X-PRONTO-CUSTOMER-REF`
  y no amarraban correctamente `session_id` / `split_id` / `order_item_id` al cliente autenticado.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/customers/split_bills.py`.
  2. Revisar `create/get/assign/calculate/summary/pay`.
  3. Confirmar que `_require_customer_auth()` solo valida presencia/revocación del header y no ownership real.
RESULTADO_ACTUAL:
  Las rutas cliente exigen sesión válida de cliente y filtran `DiningSession` / `SplitBill` por ownership real.
RESULTADO_ESPERADO:
  Requerir autenticación canónica de cliente y ocultar recursos ajenos con `404`.
UBICACION:
  - `pronto-api/src/api_app/routes/customers/split_bills.py`
  - `pronto-api/tests/test_security_regressions.py`
ESTADO: RESUELTO
SOLUCION:
  Se reemplazó el helper débil por `@require_customer_session` + `get_current_customer()` para resolver el cliente autenticado.
  Se añadieron helpers locales para ownership real de `DiningSession` y `SplitBill`, usados por `create/get/assign/calculate/summary/pay`.
  Además, `assign_item_to_person` ahora valida que el `OrderItem` pertenezca a la misma sesión de la división.
  Validación: `python3 -m py_compile pronto-api/src/api_app/routes/customers/split_bills.py pronto-api/tests/test_security_regressions.py` => OK;
  `pronto-api/.venv/bin/python -m pytest pronto-api/tests/test_security_regressions.py -q` => `17 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
