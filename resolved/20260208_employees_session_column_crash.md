---
ID: ERR-20260208-007
FECHA: 2026-02-08
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Crash en listado de sesiones por columna inexistente (customer_name)
DESCRIPCION: El endpoint de sesiones del BFF de empleados intenta acceder a DiningSession.customer_name en una consulta de SQLAlchemy. Esta columna no existe en el modelo canónico, lo que provoca una excepción inmediata al cargar la tabla de sesiones en el dashboard.
PASOS_REPRODUCIR:
1) Iniciar pronto-employees con el blueprint de API registrado.
2) Llamar a GET /api/sessions/all.
3) Observar error AttributeError o UndefinedColumn.
RESULTADO_ACTUAL: Excepción en runtime que rompe la carga de sesiones.
RESULTADO_ESPERADO: Obtener el nombre del cliente mediante un JOIN con la tabla pronto_customers.
UBICACION: pronto-employees/src/pronto_employees/routes/api/sessions.py
EVIDENCIA: Línea 48 de sessions.py referencia DiningSession.customer_name.
HIPOTESIS_CAUSA: El BFF no se actualizó tras la eliminación de la columna customer_name en favor del modelo normalizado.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Modificar la consulta select() en sessions_all() para incluir Customer.first_name.
2. Actualizar el mapeo de resultados para usar la columna del join.
3. Sincronizar también get_session() para usar la relación s.customer.name.
