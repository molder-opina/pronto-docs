ID: AUTH-009
FECHA: 2026-02-14
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: API orders - Usar decorator require_customer_session
DESCRIPCION: 
Endpoint de órdenes en pronto-api no valida customer_ref.
Debe usar @require_customer_session para autenticar clientes.
PASOS_REPRODUCIR:
1. POST /api/orders sin auth
2. Error de autenticación genérico
RESULTADO_ACTUAL:
Sin decorador de validación customer
RESULTADO_ESPERADO:
- @require_customer_session en endpoint
- get_current_customer() obtiene customer_id
UBICACION:
- pronto-api/src/api_app/routes/orders.py (o equivalente)
EVIDENCIA:
No hay import de require_customer_session
HIPOTESIS_CAUSA:
No existía decorator
ESTADO: RESUELTO
DEPENDENCIAS: AUTH-004 (requiere decorator)
BLOQUEA: AUTH-010
SOLUCION:
- Creado /pronto-api/src/api_app/routes/customers/orders.py
- POST /api/customer/orders - crear orden con @require_customer_session
- GET /api/customer/orders - listar ordenes del cliente
- GET /api/customer/orders/<id> - obtener orden especifica
- Agregado get_orders_by_customer_id() a order_service.py
- Reorganizado customers.py -> customers/{__init__.py, admin.py, orders.py}
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-14