ID: API-20260309-NESTED-TRAZABILIDAD-TUPLES
FECHA: 2026-03-09
PROYECTO: pronto-api / pronto-employees
SEVERIDAD: alta
TITULO: Múltiples rutas retornaban `trazabilidad_error` con tuplas anidadas y rompían respuestas Flask
DESCRIPCION: Se detectó un patrón transversal donde varias rutas en `pronto-api` y `pronto-employees` hacían `return trazabilidad_error(...), HTTPStatus.X` aunque `trazabilidad_error` ya devuelve `(jsonify(...), status)`. Esto produce tuplas anidadas `((Response, status), status)` y errores `TypeError` en Flask en rutas de error/validación.
PASOS_REPRODUCIR:
1. Ejecutar `rg -n --hidden 'trazabilidad_error\([^\)]*\)\s*,\s*HTTPStatus\.' pronto-api pronto-employees -S`.
2. Ejecutar `cd pronto-tests && PYTHONPATH=.:../pronto-api/src:../pronto-libs/src ../pronto-libs/.venv/bin/python -m pytest tests/unit/pronto-api/test_security_regressions.py -q`.
3. Observar fallos en casos de ownership/customer auth previos al fix.
RESULTADO_ACTUAL: El patrón fue corregido transversalmente; las rutas ahora delegan el status directamente a `trazabilidad_error(...)`, desapareció el patrón en búsqueda global y `tests/unit/pronto-api/test_security_regressions.py` pasa completo.
RESULTADO_ESPERADO: Ninguna ruta debe envolver dos veces el status de `trazabilidad_error`; toda respuesta de error debe ser válida para Flask y consistente con `pronto_shared.trazabilidad.error_response`.
UBICACION:
- pronto-api/src/api_app/routes/_customer_auth.py
- pronto-api/src/api_app/routes/client_auth.py
- pronto-api/src/api_app/routes/feedback.py
- pronto-api/src/api_app/routes/payments.py
- pronto-api/src/api_app/routes/customers/orders.py
- pronto-api/src/api_app/routes/customers/split_bills.py
- pronto-api/src/api_app/routes/customers/waiter_calls.py
- pronto-api/src/api_app/routes/employees/config.py
- pronto-api/src/api_app/routes/employees/orders.py
- pronto-api/src/api_app/routes/employees/sessions.py
- pronto-employees/src/pronto_employees/routes/api/business_info.py
- pronto-employees/src/pronto_employees/routes/api/notifications.py
- pronto-employees/src/pronto_employees/routes/api/permissions.py
- pronto-employees/src/pronto_employees/routes/api/promotions.py
- pronto-employees/src/pronto_employees/routes/api/realtime.py
- pronto-employees/src/pronto_employees/routes/api/reports.py
- pronto-employees/src/pronto_employees/routes/api/roles.py
- pronto-employees/src/pronto_employees/routes/api/sessions.py
- pronto-employees/src/pronto_employees/routes/api/table_assignments.py
EVIDENCIA:
- `PY_COMPILE_OK` en archivos tocados.
- `26 passed` en `tests/unit/pronto-api/test_security_regressions.py -q`.
- Búsqueda global del patrón tras el fix sin resultados.
HIPOTESIS_CAUSA: Uso incorrecto del helper `pronto_shared.trazabilidad.error_response` alias `trazabilidad_error`, asumiendo que devolvía solo body en vez de `(response, status)`.
ESTADO: RESUELTO
SOLUCION: Se normalizaron todas las rutas detectadas para pasar el status directamente como segundo argumento de `trazabilidad_error(...)` y evitar tuplas anidadas; además se mantuvieron/regresaron pruebas de regresión focalizadas que validan los caminos de ownership/customer auth sin disparar el fallo de Flask.
COMMIT: pronto-api:1c5387c; pronto-employees:489790e; pronto-tests:c8f292c; pronto-client:69a3f21; pronto-static:cc90357; pronto-scripts:4d155c7
FECHA_RESOLUCION: 2026-03-09

