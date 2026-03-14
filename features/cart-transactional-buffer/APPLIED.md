# APPLIED

## D0 (existencia previa)
- Existía `cartStore` local en frontend (`localStorage`) y creación de orden directa.
- No existía endpoint backend de carrito temporal.
- No existía idempotencia en submit de `customer/orders`.

## Cambios aplicados
- `pronto-api`:
  - `GET/PUT /api/customer/orders/cart`
  - `POST /api/customer/orders/cart/abandon`
  - `POST /api/customer/orders` con replay idempotente (`X-Idempotency-Key`) por ventana temporal.
  - Persistencia de `cart_buffer` y metadata de submit en `customer_session_store`.
- `pronto-client`:
  - Forward de `X-Idempotency-Key` al upstream.
  - Proxy de rutas `customer/orders/cart*`.
- `pronto-static`:
  - `cartStore` con merge por firma canónica.
  - sync best-effort del carrito activo al backend.
  - `submitCart()` idempotente.
  - checkout usa `submitCart()` (sin mutar directamente `/api/orders`).

## Validación
- `python3 -m py_compile` en rutas actualizadas de API/BFF: OK.
- `npm run build:clients`: OK.
- `npm run build:employees`: OK.
- `./pronto-scripts/bin/pronto-rules-check full`: OK.
- `./pronto-scripts/bin/pronto-no-legacy`: OK.
- `pytest` unitario central no ejecutable localmente por dependencia faltante (`flask`).
