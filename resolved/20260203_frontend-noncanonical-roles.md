---
ID: ERR-20260203-003
FECHA: 2026-02-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Roles no canonicos en UI de empleados
DESCRIPCION: La UI de empleados incluye roles no canonicos (system, supervisor, staff, guest, cook). Esto rompe la regla de roles canonicos y puede generar permisos o temas inconsistentes entre frontend y backend.
PASOS_REPRODUCIR: Revisar role-context y employee-events en pronto-static.
RESULTADO_ACTUAL: role-context normaliza system/cook y define guest; employee-events permite system/supervisor y usa staff como fallback.
RESULTADO_ESPERADO: Solo roles canonicos (waiter, chef, cashier, admin, system) sin aliases.
UBICACION: pronto-static/src/vue/employees/modules/role-context.ts; pronto-static/src/vue/employees/modules/employee-events.ts
EVIDENCIA: pronto-static/src/vue/employees/modules/role-context.ts:1-118; pronto-static/src/vue/employees/modules/employee-events.ts:459-481
HIPOTESIS_CAUSA: Alias historicos o compatibilidad con versiones anteriores no removida.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
