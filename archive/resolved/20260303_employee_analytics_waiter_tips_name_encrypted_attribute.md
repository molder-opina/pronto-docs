ID: ERR-20260303-EMPLOYEE-ANALYTICS-WAITER-TIPS-NAME-ENCRYPTED-ATTRIBUTE
FECHA: 2026-03-03
PROYECTO: pronto-libs, pronto-employees
SEVERIDAD: alta
TITULO: Analytics de meseros usa `Employee.name_encrypted` aunque el modelo actual ya no tiene ese atributo
DESCRIPCION: El bloque de `waiter-tips` en reportes responde `500` porque `EmployeeAnalytics` consulta `Employee.name_encrypted`, pero el modelo vigente usa `first_name`, `last_name` y `name` como hybrid property.
PASOS_REPRODUCIR:
1. Autenticarse en admin.
2. Consultar `/admin/api/reports/waiter-tips?start_date=2026-02-24&end_date=2026-03-03`.
3. Observar respuesta de error interno y traceback en logs.
RESULTADO_ACTUAL: El endpoint falla con `AttributeError: type object 'Employee' has no attribute 'name_encrypted'`.
RESULTADO_ESPERADO: El endpoint debe calcular propinas de mesero usando el modelo actual y responder `200`.
UBICACION: pronto-libs/src/pronto_shared/services/analytics/employee_analytics.py
EVIDENCIA: Logs de `pronto-employees-1` mostrando `AttributeError` en `reports_waiter_tips`.
HIPOTESIS_CAUSA: El servicio de analytics quedó desfasado respecto al refactor del modelo `Employee`.
ESTADO: RESUELTO
SOLUCION: `employee_analytics.py` dejó de consultar `Employee.name_encrypted` y ahora agrupa por `first_name` y `last_name`, resolviendo el nombre completo de forma compatible con el modelo vigente. Con esto `/admin/api/reports/waiter-tips` vuelve a responder `200`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
