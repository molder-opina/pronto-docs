# cart-transactional-buffer

Implementa un carrito transaccional temporal alineado a `OrderItem` para flujo cliente (`/api/customer/orders`).

## Objetivo
- Evitar que el carrito sea solo estado de UI.
- Mantener compatibilidad estructural con órdenes.
- Garantizar submit idempotente y soporte de múltiples envíos por sesión.

## Alcance aplicado
- `pronto-api`: idempotencia en creación de orden cliente y estado de carrito temporal en sesión de cliente.
- `pronto-client`: proxy BFF para endpoints de carrito y forward de `X-Idempotency-Key`.
- `pronto-static`: `cartStore` transaccional (merge de items equivalentes, sync backend, submit idempotente).
