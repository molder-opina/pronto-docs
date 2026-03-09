## Ejemplos mínimos para `pronto-client`

### Obtener CSRF
`GET /api/client-auth/csrf`

### Login cliente
`POST /api/client-auth/login`

Body:
`{"email":"demo@example.com","password":"***"}`

### Consultar menú
`GET /api/menu`

### Persistir contexto de mesa
`POST /api/sessions/table-context`

Body:
`{"table_id":"11111111-1111-1111-1111-111111111111","table_source":"qr"}`

### Crear orden cliente
`POST /api/customer/orders`

Body:
`{"items":[{"menu_item_id":"33333333-3333-3333-3333-333333333333","quantity":1}]}`