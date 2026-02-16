---
ID: ERR-20260203-001
FECHA: 2026-02-03
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Uso de rol/scope "system" en consola /system
DESCRIPCION: La consola /system usa el rol/scope "system" en rutas, guards y templates, pero los roles canónicos definen "system" como único superusuario. Esto crea una inconsistencia con las reglas de roles y puede bloquear el acceso correcto o permitir un rol no canónico.
PASOS_REPRODUCIR: Revisar el guard y el flujo de login en rutas /system y las condiciones de templates.
RESULTADO_ACTUAL: ScopeGuard app_scope="system", el login exige employee.has_scope("system"), y templates consideran "system" como rol válido.
RESULTADO_ESPERADO: Usar únicamente roles canónicos (system) y scopes definidos por guardrails.
UBICACION: pronto-employees/src/pronto_employees/routes/system/auth.py; pronto-employees/src/pronto_employees/templates/base.html; pronto-employees/src/pronto_employees/templates/includes/_dashboard_scripts.html; pronto-employees/src/pronto_employees/templates/includes/_menu_chef.html
EVIDENCIA: pronto-employees/src/pronto_employees/routes/system/auth.py:44-97, 130-136; pronto-employees/src/pronto_employees/templates/base.html:1534-1536; pronto-employees/src/pronto_employees/templates/includes/_dashboard_scripts.html:29; pronto-employees/src/pronto_employees/templates/includes/_menu_chef.html:753
HIPOTESIS_CAUSA: Migracion incompleta de system a system en consola /system.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
