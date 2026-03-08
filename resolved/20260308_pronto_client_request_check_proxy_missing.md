ID: CLI-20260308-012
FECHA: 2026-03-08
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: BFF cliente no expone request-check para sesiones de órdenes del cliente
DESCRIPCION:
  El API canónico soporta `POST /api/customer/orders/session/<session_id>/request-check`,
  pero `pronto-client` no ofrecía el wrapper equivalente en `:6080`, por lo que el flujo cliente
  de pedir la cuenta terminaba en 404.
PASOS_REPRODUCIR:
  1. Registrar cliente y abrir sesión.
  2. Crear una orden válida.
  3. Invocar `POST /api/customer/orders/session/<session_id>/request-check` vía `:6080`.
  4. Observar 404, mientras el mismo request a `:6082` devuelve 200.
RESULTADO_ACTUAL:
  El BFF cliente carecía del proxy para `request-check`.
RESULTADO_ESPERADO:
  Debe exponer el wrapper y reenviar al endpoint canónico del API.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/orders.py`
EVIDENCIA:
  - `pronto-api/src/api_app/routes/customers/orders.py:@bp.post("/session/<session_id>/request-check")`
HIPOTESIS_CAUSA:
  Wrapper cliente incompleto para el flujo de checkout del cliente.
ESTADO: RESUELTO
SOLUCION:
  Se añadió el proxy `POST /api/customer/orders/session/<session_id>/request-check` en `pronto-client`
  y se validó end-to-end con el e2e live del cliente.
COMMIT: 3cc0011
FECHA_RESOLUCION: 2026-03-08

