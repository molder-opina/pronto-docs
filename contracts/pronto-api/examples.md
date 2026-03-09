## Ejemplos mínimos de request/response para `pronto-api`

### Auth · login employee
Request:
`POST /api/auth/login`

Body:
`{"email":"admin@pronto.local","password":"***","scope":"admin"}`

### Sessions · abrir sesión
Request:
`POST /api/sessions/open`

Body:
`{"table_id":"11111111-1111-1111-1111-111111111111"}`

### Orders · crear orden cliente
Request:
`POST /api/customer/orders`

Headers:
- `X-PRONTO-CUSTOMER-REF`
- `X-CSRFToken`

Body:
`{"items":[{"menu_item_id":"33333333-3333-3333-3333-333333333333","quantity":1}]}`

### Payments · checkout
Request:
`GET /api/customer/payments/sessions/{session_id}/checkout`

Header:
- `X-PRONTO-CUSTOMER-REF`

### Payments · pagar sesión
Request:
`POST /api/customer/payments/sessions/{session_id}/pay`

Body:
`{"payment_method":"cash"}`

### Invoices · solicitar factura
Request:
`POST /api/client/invoices/request`

Body:
`{"session_id":"22222222-2222-2222-2222-222222222222","rfc":"XAXX010101000","legal_name":"Cliente Demo SA de CV","email":"demo@example.com"}`