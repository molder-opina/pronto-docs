# Top 10 Riesgos Históricos (Ejecutivo)

Fuente: pronto-docs/resueltos.txt + severidad en expedientes

## Criterio
- Orden: severidad (bloqueante > alta > media > baja > desconocida), luego fecha, luego ID
- Incluye BUG/ERR

## Top 10
1. [x] ERR-20260219-MENU-MAPPER-PAYMENT | severidad=bloqueante | fecha=2026-02-19 | estado=RESUELTO | pronto-libs, pronto-client
   /api/menu retorna 500 por mapper SQLAlchemy (Payment no resuelto)
2. [x] ERR-20260219-MISSING-BACKEND-ENDPOINTS | severidad=bloqueante | fecha=2026-02-19 | estado=RESUELTO | pronto-employees
   Endpoints de API no encontrados (falso positivo)
3. [x] ERR-20260219-UUID-IMPORT-MISSING | severidad=bloqueante | fecha=2026-02-19 | estado=RESUELTO | pronto-libs
   customer_service.py usa UUID sin importarlo
4. [x] ERR-20260218-001 | severidad=bloqueante | fecha=2026-02-18 | estado=RESUELTO | pronto-api
   Endpoints de orders sin autenticación JWT
5. [x] ERR-20260218-OSM-HANDLERS | severidad=bloqueante | fecha=2026-02-18 | estado=RESUELTO | pronto-libs
   OrderStateMachine handlers no cambian workflow_status
6. [x] BUG-20250215-001 | severidad=bloqueante | fecha=2026-02-15 | estado=RESUELTO | pronto-client
   Endpoints de pagos sin autenticación de cliente
7. [x] BUG-20260214-001 | severidad=bloqueante | fecha=2026-02-14 | estado=RESUELTO | pronto-client
   notifications.py usa JWT (modelo incorrecto para clientes)
8. [x] BUG-20260214-002 | severidad=bloqueante | fecha=2026-02-14 | estado=RESUELTO | pronto-libs
   Password hashing usa SHA256 con pepper estático
9. [x] BUG-20260214-007 | severidad=bloqueante | fecha=2026-02-14 | estado=RESUELTO | pronto-client
   waiter_calls.py name shadowing flask.session vs SQLAlchemy session
10. [x] ERR-20260213-LOGIN-SCOPE-403 | severidad=bloqueante | fecha=2026-02-13 | estado=RESUELTO | pronto-libs, pronto-employees, pronto-static
   Login de empleados retorna 403 por validación de scope incompleta
