---
ID: ERR-20260203-001
FECHA: 2026-02-03
PROYECTO: pronto-static/pronto-employees
SEVERIDAD: alta
TITULO: Rol no canónico "supervisor" expuesto en UI empleados
DESCRIPCION: Reaparece. Referencia ID anterior PRONTO-ERR-20260203-001. Se expone y utiliza el rol "supervisor" en UI de empleados, pero los roles canónicos no incluyen supervisor. Esto permite seleccionar un rol inválido y rompe permisos/seguridad.
PASOS_REPRODUCIR: 1) Abrir gestión de empleados. 2) Forzar fallback de roles (error en /api/roles) o usar formulario admin. 3) Seleccionar "Supervisor".
RESULTADO_ACTUAL: Se permite seleccionar/mostrar rol supervisor.
RESULTADO_ESPERADO: Solo roles canónicos: waiter, chef, cashier, admin, system.
UBICACION: pronto-static/src/vue/employees/components/EmployeesManager.vue:69-75; pronto-employees/src/pronto_employees/templates/includes/_admin_sections.html:1812-1816
EVIDENCIA: fallback incluye { value: 'supervisor' } y template HTML incluye <option value="supervisor">.
HIPOTESIS_CAUSA: Rol agregado en UI sin sincronizar con canon de roles.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
