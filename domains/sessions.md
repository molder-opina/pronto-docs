## Dominio `Sessions`

### Superficies principales
- `pronto-api` como backend canónico
- `pronto-client` para contexto de mesa y sesión activa
- `pronto-employees` para operación sobre sesiones

### Rutas clave
- `/api/sessions/open`
- `/api/sessions/me`
- `/api/sessions/table-context`
- `/api/sessions/<uuid:session_id>/timeout`
- `/api/sessions/<uuid:session_id>/pay`

### Reglas importantes
- `POST /api/sessions/open` es excepción pública controlada con `table_id` válido.
- `table-context` ayuda a persistir el contexto técnico de mesa del cliente.
- El checkout cliente vive en el dominio `Payments` bajo `/api/customer/payments/sessions/<uuid:session_id>/checkout`.
- El dominio de sesión conecta órdenes, pagos, ticketing y facturación.

### Flujos típicos
1. Apertura de sesión.
2. Bootstrap del contexto de mesa.
3. Órdenes durante la sesión.
4. Checkout, cobro y cierre.

### Documentos relacionados
- `../API_CONSUMPTION_MASTER.md`
- `../SYSTEM_ROUTES_SPEC.md`
- `../SYSTEM_ROUTES_MATRIX.md`
- `../pronto-api/POSTMAN_USAGE.md`
- `../contracts/pronto-api/domain_contracts.md`
- `../contracts/pronto-client/domain_contracts.md`
- `../contracts/pronto-employees/domain_contracts.md`