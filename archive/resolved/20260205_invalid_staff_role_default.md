---
ID: ERR-20260205-INVALID-STAFF-ROLE-DEFAULT
FECHA: 2026-02-05
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Rol por defecto "staff" no es canonico y viola allowlist
DESCRIPCION: El modelo Employee y el schema asociado usan "staff" como rol por defecto. Este rol no es canonico (roles permitidos: waiter, chef, cashier, admin, system) y puede introducir empleados con rol invalido, rompiendo ScopeGuard y drift de permisos.
PASOS_REPRODUCIR: 1) Crear empleado sin especificar role. 2) Revisar que se persiste role="staff". 3) Intentar acceder a vistas protegidas por ScopeGuard.
RESULTADO_ACTUAL: Se pueden crear/mostrar empleados con rol "staff".
RESULTADO_ESPERADO: Default debe ser un rol canonico y no debe existir "staff" como rol del sistema.
UBICACION: pronto-libs/src/pronto_shared/models.py (Employee.role default), pronto-libs/src/pronto_shared/schemas.py, pronto-libs/src/pronto_shared/services/employee_service.py, pronto-libs/src/pronto_shared/constants.py (Roles.STAFF)
EVIDENCIA: role: mapped_column(... default=\"staff\"); schema Field(default=\"staff\"); service data.get(\"role\", \"staff\")
HIPOTESIS_CAUSA: Placeholder historico no migrado a roles canonicos.
ESTADO: RESUELTO
---

SOLUCION: Se removio el rol no canonico "staff" de defaults y constants. Default de role en Employee/CreateEmployeeRequest/employee_service ahora es "waiter" y se elimino SUPER_ADMIN/STAFF del enum Roles para evitar aliases/drift.
COMMIT: b1b4855
FECHA_RESOLUCION: 2026-02-05
