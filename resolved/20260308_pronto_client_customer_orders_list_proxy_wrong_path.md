ID: CLI-20260308-011
FECHA: 2026-03-08
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: BFF cliente lista órdenes en /api/customers/orders pero el API canónico vive en /api/customer/orders
DESCRIPCION:
  El flujo cliente live permitía crear órdenes vía `POST /api/customer/orders`, pero el listado por el BFF
  fallaba porque `pronto-client` reenviaba `GET /api/customer/orders` hacia `/api/customers/orders`.
PASOS_REPRODUCIR:
  1. Registrar cliente y abrir sesión.
  2. Crear una orden válida vía `:6080`.
  3. Llamar `GET /api/customer/orders` vía `:6080`.
  4. Observar 403/flujo roto, mientras `GET :6082/api/customer/orders` responde 200.
RESULTADO_ACTUAL:
  El BFF cliente usaba un path upstream incorrecto para listar órdenes del cliente.
RESULTADO_ESPERADO:
  Debe reenviar a `/api/customer/orders`.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/orders.py`
EVIDENCIA:
  - `get_customer_orders()` usaba `path = "/api/customers/orders"`.
HIPOTESIS_CAUSA:
  Drift de naming singular/plural en el wrapper cliente.
ESTADO: RESUELTO
SOLUCION:
  Se corrigió el proxy para apuntar al endpoint canónico `/api/customer/orders` y se revalidó
  el flujo cliente de crear orden + listar órdenes vía `:6080`.
COMMIT: 3cc0011
FECHA_RESOLUCION: 2026-03-08

