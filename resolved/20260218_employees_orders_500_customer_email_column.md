ID: ERR-20260218-EMPLOYEES-ORDERS-500-CUSTOMER-EMAIL
FECHA: 2026-02-18
PROYECTO: pronto-libs, pronto-employees, pronto-tests
SEVERIDAD: alta
TITULO: GET /api/orders en employees falla 500 por columna customer.email inexistente
DESCRIPCION: El endpoint de empleados `GET /api/orders` devolvía 500 con `Error de base de datos` al listar órdenes activas.
PASOS_REPRODUCIR: 1) Login waiter en `http://localhost:6081/waiter/login`. 2) Invocar `GET http://localhost:6081/api/orders` con cookie de sesión/JWT.
RESULTADO_ACTUAL: Respuesta HTTP 500 y traceback SQLAlchemy `UndefinedColumn: column pronto_customers_1.email does not exist`.
RESULTADO_ESPERADO: Respuesta HTTP 200 con payload canónico de órdenes.
UBICACION: pronto-libs/src/pronto_shared/services/order_service.py
EVIDENCIA: Logs de `pronto-employees-1` y fallo de Playwright `employees/orders.spec.ts` (test "waiter can read active orders with canonical payload").
HIPOTESIS_CAUSA: Query eager-load en `get_orders_advanced()` incluía `joinedload(Order.customer)` y el modelo customer referencia columna `email` no presente en esquema runtime.
ESTADO: RESUELTO
SOLUCION: Se eliminó `joinedload(Order.customer)` en `get_orders_advanced()` y se endureció el bloque de warnings para IDs UUID sin cast `int()`. Se reconstruyó/reinició employees y se levantó api para validar.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
