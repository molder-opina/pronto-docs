ID: ERR-20260303-ADMIN-EMPLOYEES-SCOPE-LEAKS-SYSTEM-ACCOUNTS
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Panel de empleados en admin expone cuentas y rol system
DESCRIPCION: En `/admin/dashboard/employees`, la consola administrativa está mostrando empleados con rol `system` y permite que el formulario de personal contemple ese rol, cuando la gestión de cuentas `system` debe quedar reservada a `/system`.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/employees`.
2. Revisar la tabla de empleados y el combo de roles en el modal de alta/edición.
RESULTADO_ACTUAL: `admin` puede ver cuentas `system` y el selector de rol contempla `system`.
RESULTADO_ESPERADO: En `/admin` solo deben mostrarse y administrarse `waiter`, `chef`, `cashier` y `admin`. Las cuentas/rol `system` solo deben verse y gestionarse en `/system`.
UBICACION: pronto-static/src/vue/employees/admin/components/EmployeesManager.vue
EVIDENCIA: Solicitud del usuario indicando que los empleados de tipo `system` no deben verse en `/admin` y que su gestión corresponde a `/system`.
HIPOTESIS_CAUSA: La vista de empleados no estaba filtrando datos ni opciones de rol por scope actual y reutilizaba el mismo inventario canónico en `admin` y `system`.
ESTADO: RESUELTO
SOLUCION: `EmployeesManager.vue` ahora resuelve el scope actual (`admin` o `system`), filtra la tabla para ocultar cuentas `system` en `/admin`, limita el combo de roles a `waiter`, `chef`, `cashier` y `admin` en esa consola, y reserva el rol `system` para `/system`. También se añadió un guard de UI al guardar para rechazar roles no permitidos en la consola actual. Se validó en navegador que `/admin/dashboard/employees` muestra `20` cuentas visibles, `4` roles disponibles y que el modal de `Nuevo empleado` solo lista `Mesero`, `Cocina`, `Caja` y `Administrador`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
