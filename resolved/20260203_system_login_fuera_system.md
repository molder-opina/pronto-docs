---
ID: ERR-20260203-004
FECHA: 2026-02-03
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Endpoint /system_login fuera de /system
DESCRIPCION: Existe un endpoint /system_login en el blueprint waiter. Las reglas indican que handoff solo puede existir bajo /system.
PASOS_REPRODUCIR: 1) Abrir /waiter/system_login. 2) Enviar token.
RESULTADO_ACTUAL: Handoff ejecuta login desde scope waiter.
RESULTADO_ESPERADO: Handoff solo bajo /system.
UBICACION: pronto-employees/src/pronto_employees/routes/waiter/auth.py:227-229
EVIDENCIA: @waiter_bp.route("/system_login", ...)
HIPOTESIS_CAUSA: Endpoint copiado desde system sin reubicación.
ESTADO: RESUELTO
---

SOLUCION: Se eliminó /system_login de blueprints no system y se centralizó el handoff en POST /system/system_login.
COMMIT: 615eb584c198ea006f949125e0ade780a8b52c9d
FECHA_RESOLUCION: 2026-02-04
