# Top 10 Riesgos Históricos (Ejecutivo)

Fuente: pronto-docs/resueltos.txt + severidad en expedientes

## Criterio
- Orden: severidad (bloqueante > alta > media > baja > desconocida), luego fecha, luego ID
- Incluye BUG/ERR

## Top 10
1. [x] ERR-20260219-CHECKOUT-POST-CSRF | severidad=bloqueante | fecha=2026-02-19 | estado=RESUELTO | pronto-client
   Checkout cliente falla por mutaciones POST sin token CSRF
2. [x] ERR-20260219-EMPLOYEES-AUTH-LOGIN-CSRF-EXEMPT | severidad=bloqueante | fecha=2026-02-19 | estado=RESUELTO | pronto-api
   Endpoint de login de employees usa @csrf.exempt fuera de excepción permitida
3. [x] ERR-20260219-MENU-MAPPER-PAYMENT | severidad=bloqueante | fecha=2026-02-19 | estado=RESUELTO | pronto-libs, pronto-client
   /api/menu retorna 500 por mapper SQLAlchemy (Payment no resuelto)
4. [x] ERR-20260219-MISSING-BACKEND-ENDPOINTS | severidad=bloqueante | fecha=2026-02-19 | estado=RESUELTO | pronto-employees
   Endpoints de API no encontrados (falso positivo)
5. [x] ERR-20260219-UUID-IMPORT-MISSING | severidad=bloqueante | fecha=2026-02-19 | estado=RESUELTO | pronto-libs
   customer_service.py usa UUID sin importarlo
6. [x] ERR-20260218-001 | severidad=bloqueante | fecha=2026-02-18 | estado=RESUELTO | pronto-api
   Endpoints de orders sin autenticación JWT
7. [x] ERR-20260218-OSM-HANDLERS | severidad=bloqueante | fecha=2026-02-18 | estado=RESUELTO | pronto-libs
   OrderStateMachine handlers no cambian workflow_status
8. [x] BUG-20250215-001 | severidad=bloqueante | fecha=2026-02-15 | estado=RESUELTO | pronto-client
   Endpoints de pagos sin autenticación de cliente
9. [x] BUG-20260214-001 | severidad=bloqueante | fecha=2026-02-14 | estado=RESUELTO | pronto-client
   notifications.py usa JWT (modelo incorrecto para clientes)
10. [x] BUG-20260214-002 | severidad=bloqueante | fecha=2026-02-14 | estado=RESUELTO | pronto-libs
   Password hashing usa SHA256 con pepper estático
