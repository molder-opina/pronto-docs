## Uso de la colección Insomnia de PRONTO

### Archivo
- `INSOMNIA_EXPORT.json`

### Qué cubre
- llamadas directas a `pronto-api` (`:6082`)
- llamadas al BFF de `pronto-client` (`:6080`)
- ejemplo vía proxy scope-aware de `pronto-employees` (`:6081`)
- carpetas por dominio: `auth`, `menu`, `orders`, `sessions`, `payments`, `invoices`, `reports`
- carpetas complementarias: `admin-rbac`, `tables-areas`, `notifications-realtime`, `branding-config`

### Cómo importarlo
1. Abre Insomnia.
2. Usa **Import / Export → Import Data → From File**.
3. Selecciona `pronto-docs/pronto-api/INSOMNIA_EXPORT.json`.
4. Ajusta en el environment las variables sensibles y de entorno.

### Variables importantes del environment
- `api_base_url`
- `client_base_url`
- `employees_base_url`
- `employee_scope`
- `csrf_token`
- `customer_ref`
- `order_id`
- `session_id`
- `invoice_rfc`
- `invoice_legal_name`
- `payment_method_id`
- `employee_email`
- `employee_password`
- `customer_email`
- `customer_password`

### Notas operativas
- `GET /health` es público.
- `POST /api/sessions/open` es la excepción pública controlada.
- Las mutaciones suelen requerir `X-CSRFToken`.
- En flujos cliente directos contra `pronto-api`, propaga `X-PRONTO-CUSTOMER-REF` cuando aplique.
- El proxy `/<scope>/api/*` de employees requiere una sesión válida del scope correspondiente.

### Referencias relacionadas
- `POSTMAN_USAGE.md`
- `API_CONSUMPTION_EXAMPLES.md`
- `SYSTEM_ROUTES_SPEC.md`
- `SYSTEM_ROUTES_MATRIX.md`
- `SYSTEM_ROUTES_CATALOG.md`
- `SYSTEM_ROUTES_ENDPOINTS.md`