---
ID: PRONTO-ERR-20260203-001
FECHA: 2026-02-03
PROYECTO: pronto-static, pronto-employees
SEVERIDAD: alta
TITULO: Rol "supervisor" usado en UI aunque no es canónico
DESCRIPCION: Se usa el rol "supervisor" en UI de empleados y lógica de eventos, pero los roles canónicos permitidos son waiter, chef, cashier, admin, system. Esto crea inconsistencias de permisos, badges y notificaciones.
PASOS_REPRODUCIR: 1) Abrir dashboard de empleados. 2) Revisar gestión de roles o notificaciones. 3) Observar referencias a "supervisor" en UI/eventos.
RESULTADO_ACTUAL: UI acepta/expone "supervisor" y notificaciones lo tratan como rol válido.
RESULTADO_ESPERADO: No existir referencias a "supervisor" o debe mapearse explícitamente a rol canónico aprobado.
UBICACION: pronto-static/src/vue/employees/modules/employee-events.ts; pronto-static/src/vue/employees/modules/employees-manager.ts; pronto-static/src/vue/employees/components/EmployeesManager.vue; pronto-employees/src/pronto_employees/templates/dashboard.html; pronto-employees/src/pronto_employees/templates/includes/_admin_sections.html
EVIDENCIA: "const allowed = ['system', 'admin', 'supervisor'];" y opciones <option value="supervisor">Supervisor</option> en templates.
HIPOTESIS_CAUSA: Restos de un rol legacy o feature no alineada con la lista canónica de roles.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
