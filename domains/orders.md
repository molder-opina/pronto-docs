## Dominio `Orders`

### Superficies principales
- `pronto-api` para flujo canónico de órdenes
- `pronto-client` para órdenes del cliente
- `pronto-employees` para operación por consola/proxy

### Rutas clave cliente
- `/api/customer/orders`
- `/api/customer/orders/session/<session_id>/request-check`
- `/api/orders/<uuid:order_id>`

### Rutas clave employees
- `/api/orders`
- `/api/orders/<order_id>/accept`
- `/api/orders/<order_id>/cancel`
- `/api/orders/<order_id>/kitchen-start`
- `/api/orders/<order_id>/kitchen-ready`
- `/api/orders/<order_id>/serve`
- `/api/orders/<order_id>/deliver`

### Reglas importantes
- La autoridad de estados vive en `pronto-libs` con `OrderStateMachine`.
- Toda mutación operativa requiere auth y normalmente CSRF.
- Hay rutas de detalle cliente y rutas operativas employees; no confundir actor ni scope.

### Flujos típicos
1. Cliente crea orden.
2. Waiter acepta o la orden auto-acepta según reglas.
3. Chef inicia y marca lista.
4. Waiter sirve/entrega.
5. Se continúa con `sessions` y `payments`.

### Documentos relacionados
- `../SYSTEM_ROUTES_MATRIX.md`
- `../SYSTEM_ROUTES_SPEC.md`
- `../SYSTEM_ROUTES_ENDPOINTS.md`
- `../SYSTEM_ROUTES_CATALOG.md`
- `../contracts/pronto-api/domain_contracts.md`
- `../contracts/pronto-client/domain_contracts.md`
- `../contracts/pronto-employees/domain_contracts.md`