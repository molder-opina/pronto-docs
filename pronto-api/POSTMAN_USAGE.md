## Uso de la colección Postman de PRONTO

### Archivos
- `POSTMAN_COLLECTION.json`
- `POSTMAN_ENVIRONMENT.json`

### Qué cubre
- llamadas directas a `pronto-api` (`:6082`)
- llamadas al BFF de `pronto-client` (`:6080`)
- ejemplo de consumo vía proxy scope-aware de `pronto-employees` (`:6081`)
- carpetas por dominio: `auth`, `menu`, `orders`, `sessions`, `payments`, `invoices`, `reports`
- carpetas complementarias: `admin-rbac`, `tables-areas`, `notifications-realtime`, `branding-config`

### Pasos recomendados
1. Importa la colección y el environment en Postman.
2. Activa el environment `PRONTO Local`.
3. Ajusta variables sensibles:
   - `employee_password`
   - `customer_password`
   - `csrf_token`
   - `table_id`, `menu_item_id`, `order_id`, `session_id`, `customer_ref` si aplica
   - `invoice_rfc`, `invoice_legal_name`, `payment_method_id` si aplica
4. Usa el cookie jar de Postman para conservar sesión entre requests.

### Notas operativas
- `GET /health` es público.
- `POST /api/sessions/open` es la excepción pública controlada para apertura de mesa.
- Mutaciones suelen requerir `X-CSRFToken`.
- Para `pronto-api` en flujos cliente, propaga `X-PRONTO-CUSTOMER-REF` cuando aplique.
- El proxy `/<scope>/api/*` de `pronto-employees` asume que ya existe una sesión válida del scope correspondiente.

### Referencias relacionadas
- `API_CONSUMPTION_EXAMPLES.md`
- `SYSTEM_ROUTES_SPEC.md`
- `SYSTEM_ROUTES_MATRIX.md`
- `SYSTEM_ROUTES_CATALOG.md`
- `SYSTEM_ROUTES_ENDPOINTS.md`