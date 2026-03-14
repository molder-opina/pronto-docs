# PLAN

1. D0: verificar existencia de flujo carrito y submit en frontend/backend.
2. Añadir endpoints de carrito temporal cliente en `pronto-api` sin DDL.
3. Añadir idempotencia de submit por `X-Idempotency-Key` en `POST /api/customer/orders`.
4. Propagar header idempotencia en BFF (`pronto-client`).
5. Actualizar `cartStore` para:
   - merge por firma de item (item + modifiers + componentes + notas)
   - sync de carrito activo al backend
   - submit idempotente a `/api/customer/orders`
6. Reapuntar checkout Vue a `cartStore.submitCart()`.
7. Validar con build y gates.
