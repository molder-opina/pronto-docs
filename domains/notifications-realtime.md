## Dominio `Notifications / Realtime`

### Superficie principal
- `pronto-api`

### Rutas clave
- `/api/notifications/waiter/call`
- `/api/notifications/waiter/pending`
- `/api/notifications/waiter/confirm/<int:call_id>`
- `/api/notifications/admin/call`
- `/api/notifications/admin/pending`
- `/api/notifications/admin/confirm/<int:notification_id>`
- `/api/realtime/orders`
- `/api/realtime/notifications`

### Reglas importantes
- Este dominio conecta llamadas operativas y visibilidad en tiempo real.
- Suele consumirse por employees autenticados.
- Confirmaciones de llamadas/notificaciones son mutaciones y deben respetar auth y trazabilidad.

### Flujos típicos
1. Generar una llamada de waiter/admin.
2. Consultar pendientes.
3. Confirmar atención.
4. Complementar con endpoints realtime para visualización operativa.

### Documentos relacionados
- `../API_DOMAINS_INDEX.md`
- `../SYSTEM_ROUTES_ENDPOINTS.md`
- `../SYSTEM_ROUTES_MATRIX.md`
- `../pronto-api/POSTMAN_USAGE.md`
- `../contracts/pronto-api/domain_contracts.md`
- `../contracts/pronto-employees/domain_contracts.md`