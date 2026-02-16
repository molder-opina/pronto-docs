---
ID: ERR-20260203-007
FECHA: 2026-02-03
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: /system_login expuesto en admin, chef y cashier fuera de /system
DESCRIPCION: Reaparece. Referencia ID anterior ERR-20260203-004. Existen endpoints /system_login en blueprints admin, chef y cashier. Las reglas indican que el handoff solo puede existir bajo /system.
PASOS_REPRODUCIR: 1) Abrir /admin/system_login, /chef/system_login, /cashier/system_login. 2) Enviar token.
RESULTADO_ACTUAL: Handoff ejecuta login desde scopes no system.
RESULTADO_ESPERADO: Handoff solo bajo /system.
UBICACION: pronto-employees/src/pronto_employees/routes/admin/auth.py:57-60; pronto-employees/src/pronto_employees/routes/chef/auth.py:235-238; pronto-employees/src/pronto_employees/routes/cashier/auth.py:209-212
EVIDENCIA: @admin_bp.route("/system_login"), @chef_bp.route("/system_login"), @cashier_bp.route("/system_login")
HIPOTESIS_CAUSA: Endpoints copiados desde system para reauth sin reubicación.
ESTADO: RESUELTO
---

SOLUCION: Se eliminó /system_login de admin/chef/cashier y se centralizó el handoff en POST /system/system_login.
COMMIT: 615eb584c198ea006f949125e0ade780a8b52c9d
FECHA_RESOLUCION: 2026-02-04
