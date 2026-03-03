ID: AUTH-013
FECHA: 2026-02-14
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: API admin kioskos - CRUD y filtros por kind
DESCRIPCION: 
No hay endpoints en admin para gestionar cuentas kiosko.
Se requiere listar, crear, eliminar kioskos y filtrar clientes por kind.
PASOS_REPRODUCIR:
1. curl http://localhost:6081/api/customers/kiosks
2. 404 Not Found
RESULTADO_ACTUAL:
No hay endpoints de gestión kiosko
RESULTADO_ESPERADO:
- GET /api/customers/kiosks - Lista kioskos
- POST /api/customers/kiosks - Crear kiosko
- DELETE /api/customers/kiosks/<id> - Eliminar kiosko
- GET /api/customers/search?kind=kiosk - Filtrar
UBICACION:
- pronto-employees/src/pronto_employees/routes/api/customers.py
EVIDENCIA:
No hay función list_kiosks o create_kiosk
HIPOTESIS_CAUSA:
Funcionalidad no implementada
ESTADO: RESUELTO
DEPENDENCIAS: AUTH-005 (requiere customer_service con kind)
BLOQUEA: AUTH-014
SOLUCION:
- GET /api/customers/kiosks - Lista todos los kioskos
- POST /api/customers/kiosks - Crea nuevo kiosk (requiere location)
- DELETE /api/customers/kiosks/<id> - Elimina kiosk (hard delete)
- GET /api/customers/search?kind=kiosk - Filtra por kind
- Scope: admin, cashier, system
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-14