ID: BUG-20260215-001
FECHA: 2026-02-15
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Rutas API usan <int:id> para entidades que deben usar UUID
DESCRIPCION: Se encontraron 60+ rutas en pronto-employees/src/pronto_employees/routes/api/ usando <int:id> para entidades principales que según los modelos SQLAlchemy (pronto-libs/src/pronto_shared/models.py) usan UUID como clave primaria. Esto viola la sección 12.5 de AGENTS.md y causa inconsistencia tipo-ruta.
PASOS_REPRODUCIR: Ejecutar: rg -n --hidden "/<int:[a-z_]+_id>" pronto-employees/src/pronto_employees/routes/api/
RESULTADO_ACTUAL: Rutas como "/<int:customer_id>", "/<int:employee_id>", "/<int:session_id>", "/<int:order_id>", "/<int:table_id>" funcionan con enteros pero los modelos usan UUID
RESULTADO_ESPERADO: Las rutas deben usar <uuid:id> para entidades UUID y <int:id> solo para excepciones permitidas (Area, Role, DiscountCode, Promotion, ProductSchedule, WaiterCall, AdminShortcut)
UBICACION: pronto-employees/src/pronto_employees/routes/api/*.py
EVIDENCIA: Archivos afectados: customers.py, employees.py, sessions.py, tables.py, menu_items.py, modifiers.py, roles.py, areas.py, discount_codes.py, promotions.py, orders.py, admin_shortcuts.py, notifications.py, product_schedules.py
HIPOTESIS_CAUSA: Falta de validación durante desarrollo. Los modelos fueron migrados a UUID pero las rutas API no se actualizaron correspondientemente.
ESTADO: ABIERTO
