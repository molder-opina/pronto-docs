ID: ERR-20260303-EMPLOYEE-DEACTIVATION-NOT_ENFORCED_AT_CONSOLE_LOGIN
FECHA: 2026-03-03
PROYECTO: pronto-employees, pronto-api, pronto-libs, pronto-static
SEVERIDAD: alta
TITULO: Desactivación de empleado no está verificada al iniciar sesión en consolas
DESCRIPCION: La consola administrativa permite desactivar empleados desde `/admin/dashboard/employees`, pero es necesario validar que un empleado inactivo no pueda iniciar sesión en ninguna consola (`/waiter`, `/chef`, `/cashier`, `/admin`, `/system`).
PASOS_REPRODUCIR:
1. Desactivar un empleado desde `/admin/dashboard/employees`.
2. Intentar iniciar sesión con ese empleado en cualquiera de las consolas.
3. Verificar si el backend rechaza la autenticación por estado inactivo.
RESULTADO_ACTUAL: Antes del fix, las rutas SSR scopeadas de login validaban credenciales y permisos de scope, pero no verificaban `employee.is_active`, permitiendo que un empleado desactivado siguiera iniciando sesión si conocía su contraseña.
RESULTADO_ESPERADO: Todo empleado inactivo debe ser rechazado al crear sesión/login en cualquier consola.
UBICACION: pronto-static/src/vue/employees/admin/components/EmployeesManager.vue, pronto-employees/src/, pronto-api/src/, pronto-libs/src/
EVIDENCIA: Solicitud del usuario de validar el flujo real de desactivación en login.
HIPOTESIS_CAUSA: La UI actualizaba el estado, pero los logins SSR por scope (`/waiter/login`, `/chef/login`, `/cashier/login`, `/admin/login`, `/system/login`) bypassaban el chequeo de `is_active` que sí existía en el servicio canónico de autenticación.
ESTADO: RESUELTO
SOLUCION: Se añadió validación explícita de `employee.is_active` en las rutas SSR de login de `waiter`, `chef`, `cashier`, `admin` y `system`, devolviendo `401 Cuenta desactivada` antes de generar cookies/tokens. También se endureció `auth/me` en `pronto-employees` y `pronto-api` para rechazar sesiones vigentes de cuentas desactivadas. La validación end-to-end se hizo con la cuenta real `ana@pronto.com`: activa lograba `200` en `/waiter/login` y `/waiter/api/auth/me`; desactivada devolvió `401 Cuenta desactivada` en `/waiter/login`, `/chef/login`, `/cashier/login`, `/admin/login`, `/system/login` y `/waiter/api/auth/me`; finalmente la cuenta se reactivó para dejar el entorno intacto.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
