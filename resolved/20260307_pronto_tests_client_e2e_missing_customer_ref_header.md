ID: TEST-20260307-023
FECHA: 2026-03-07
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: e2e cliente no reutiliza customer_ref devuelto por register para rutas protegidas
DESCRIPCION:
  El e2e del cliente no reutilizaba `customer_ref` después de registrar al usuario.
PASOS_REPRODUCIR:
  1. Registrar cliente vía `:6080`.
  2. Invocar rutas protegidas sin `X-PRONTO-CUSTOMER-REF`.
  3. Observar 401 `No autenticado`.
RESULTADO_ACTUAL:
  El test omitía el header canónico de identidad cliente.
RESULTADO_ESPERADO:
  El e2e debía extraer `customer_ref` del response de register y reutilizarlo.
UBICACION:
  - `pronto-tests/tests/functionality/e2e/test_client_api_business_logic_moved_to_api.py`
EVIDENCIA:
  - `register` devuelve `data.customer_ref`
HIPOTESIS_CAUSA:
  Suposición antigua de auth implícita por cookie.
ESTADO: RESUELTO
SOLUCION:
  Se actualizó el e2e para capturar `customer_ref` y enviarlo en los requests subsiguientes.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

