## Dominio `Invoices`

### Superficie principal
- `pronto-api`

### Rutas clave cliente
- `/api/client/invoices`
- `/api/client/invoices/<invoice_id>`
- `/api/client/invoices/<invoice_id>/pdf`
- `/api/client/invoices/<invoice_id>/xml`
- `/api/client/invoices/request`

### Rutas clave admin
- `/api/admin/invoices`
- `/api/admin/invoices/<invoice_id>`
- `/api/admin/invoices/stats`

### Reglas importantes
- Facturación depende del contexto de cliente/sesión ya pagada o elegible.
- Cancelación y envío por correo son mutaciones sujetas a auth y validaciones de negocio.
- Este dominio convive con catálogos SAT y vistas administrativas.

### Flujos típicos
1. Cliente consulta facturas o solicita una nueva.
2. Descarga PDF/XML o solicita envío por correo.
3. Admin revisa métricas y detalle de facturación.

### Documentos relacionados
- `../SYSTEM_ROUTES_CATALOG.md`
- `../SYSTEM_ROUTES_ENDPOINTS.md`
- `../SYSTEM_ROUTES_SPEC.md`
- `../pronto-api/POSTMAN_USAGE.md`
- `../contracts/pronto-api/domain_contracts.md`