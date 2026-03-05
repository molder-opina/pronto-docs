# Employee Profile Preferences

## Objetivo

Agregar edición de perfil desde el menú de usuario en consolas de empleados (`:6081`) para:

- Datos de contacto personal
- Contacto de emergencia
- Cambio de contraseña propia

Respetando la regla de negocio:

- El email asignado al crear la cuenta es inmutable para el empleado.
- Solo `admin` puede cambiar ese email desde `/admin`.

## Alcance

- Frontend shared de employees (todas las consolas waiter/chef/cashier/admin/system).
- API canonical en `pronto-api` bajo `/api/employees/me/*`.
- Persistencia en `pronto_employee_preferences` con clave `profile`.
- Seed inicial en init para cargar preferencias base por empleado.
