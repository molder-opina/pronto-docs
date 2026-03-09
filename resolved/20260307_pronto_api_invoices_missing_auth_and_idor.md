ID: API-20260307-006
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: critica
TITULO: invoices expone mutaciones/lecturas sin auth robusta y permite operar sobre terceros
DESCRIPCION:
  `invoices.py` exponía múltiples endpoints cliente sin autenticación robusta. Además, `request_invoice`
  aceptaba `customer_id` del payload sin amarrarlo a la sesión autenticada, habilitando lectura y acciones
  de facturación sobre terceros.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/invoices.py`.
  2. Revisar endpoints `/client/invoices/*` y ausencia de auth/ownership.
  3. Verificar que `request_invoice` leía `customer_id` del body y que list/email/cancel no amarraban ownership.
RESULTADO_ACTUAL:
  Los endpoints cliente de invoices ahora exigen actor autenticado y aplican ownership real cuando el actor es cliente.
RESULTADO_ESPERADO:
  Requerir autenticación válida y validar ownership por sesión para clientes; permitir solo scopes autorizados para operaciones operativas de empleados.
UBICACION:
  - `pronto-api/src/api_app/routes/invoices.py`
  - `pronto-api/tests/test_security_regressions.py`
  - `pronto-tests/tests/functionality/invoice-flow.spec.ts`
ESTADO: RESUELTO
SOLUCION:
  Se añadió una capa local de auth en `invoices.py`:
  - clientes: resueltos desde `get_current_customer()` / `require_customer_session`
  - empleados permitidos: scopes `cashier`, `admin`, `system`
  Además:
  - `POST /client/invoices/request` ya no permite a un cliente facturar otro `customer_id`
  - si viene `order_id`, se valida ownership para cliente y consistencia `order.customer_id`/`customer_id` para empleado
  - `GET /client/invoices` se amarra a la sesión autenticada del cliente
  - `GET/POST` sobre `/<invoice_id>`, `email`, `cancel`, `pdf`, `xml` buscan primero el `Invoice` local y ocultan facturas ajenas con `404`
  Se añadieron regresiones en `pronto-api/tests/test_security_regressions.py` y se actualizó el contrato de `pronto-tests/tests/functionality/invoice-flow.spec.ts` para reflejar `401` anónimo.
  Validación: `python3 -m py_compile pronto-api/src/api_app/routes/invoices.py pronto-api/tests/test_security_regressions.py` => OK;
  `pronto-api/.venv/bin/python -m pytest pronto-api/tests/test_security_regressions.py -q` => `11 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
