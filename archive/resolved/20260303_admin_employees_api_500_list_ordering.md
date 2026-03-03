ID: ERR-20260303-ADMIN-EMPLOYEES-API-500-LIST-ORDERING
FECHA: 2026-03-03
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: alta
TITULO: Endpoint de empleados en admin responde 500 al listar personal
DESCRIPCION: Tras corregir la presentación de `/admin/dashboard/employees`, la vista sigue mostrando un error porque la carga de personal falla en `/admin/api/employees` con `500 Internal Server Error`.
PASOS_REPRODUCIR:
1. Iniciar sesión en `/admin`.
2. Abrir `http://localhost:6081/admin/dashboard/employees`.
3. Observar la solicitud `GET /admin/api/employees`.
RESULTADO_ACTUAL: La solicitud devuelve `500` y la vista muestra el alert `No se pudo cargar la vista de empleados`.
RESULTADO_ESPERADO: El endpoint debe devolver la lista de empleados o una respuesta vacía válida para que el ABC funcione.
UBICACION: pronto-libs/src/pronto_shared/services/employee_service.py; pronto-api/src/api_app/routes/employees/employees.py
EVIDENCIA: Validación en navegador con Playwright durante esta sesión; `GET http://localhost:6081/admin/api/employees => 500`.
HIPOTESIS_CAUSA: `employee_service.list_employees()` intenta ordenar por `Employee.name_encrypted`, columna inexistente en el modelo actual `Employee`, provocando una excepción SQLAlchemy al construir el query.
ESTADO: RESUELTO
SOLUCION: Se corrigió `pronto_shared.services.employee_service.list_employees()` para ordenar por `Employee.first_name`, `Employee.last_name` y `Employee.id`, que sí existen en el modelo actual. Después se reinició `pronto-employees-1` para recargar la librería compartida y la ruta `/admin/api/employees` volvió a responder `200 OK`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03

