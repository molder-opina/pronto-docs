ID: API-20260308-013
FECHA: 2026-03-08
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: crear orden cliente con modificador requerido faltante devuelve 500 en lugar de error de validación
DESCRIPCION:
  Cuando el cliente crea una orden con un producto que exige modificadores obligatorios y el payload no los incluye,
  el API canónico respondía `500 Error interno al procesar la orden` en lugar de un error de validación consumible.
PASOS_REPRODUCIR:
  1. Registrar cliente y abrir sesión.
  2. Hacer `POST /api/customer/orders` con un item con modificador requerido sin seleccionar opciones.
  3. Observar 500 tanto vía `:6080` como directo a `:6082`.
RESULTADO_ACTUAL:
  El flujo de validación de modificadores obligatorios escapaba como 500.
RESULTADO_ESPERADO:
  Debe responder con error de validación 4xx y mensaje claro para el cliente.
UBICACION:
  - `pronto-api/src/api_app/routes/customers/orders.py`
  - `pronto-libs/src/pronto_shared/services/order_write_service_core.py`
EVIDENCIA:
  - `POST :6082/api/customer/orders` devolvía 500 `Error interno al procesar la orden`.
HIPOTESIS_CAUSA:
  `order_write_service_core` definía una excepción local distinta a la que levantan los validadores,
  por lo que el error de modifiers no era atrapado como `OrderValidationError`.
ESTADO: RESUELTO
SOLUCION:
  Se unificó `OrderValidationError` con la excepción canónica de `pronto_shared.services.orders`
  y se agregó manejo explícito para devolver `400` con mensaje de validación.
COMMIT: eeb1e2e
FECHA_RESOLUCION: 2026-03-08

