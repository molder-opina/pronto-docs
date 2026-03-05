# APPLIED

## Backend

- `pronto-libs/src/pronto_shared/services/employee_service.py`
  - Nuevas funciones:
    - `get_employee_preferences(...)`
    - `update_employee_preferences(...)`
    - `update_employee_password(...)`
  - Validación de email personal y contraseñas.
  - Bloqueo de campos de email asignado (`email`, `assigned_email`, `employee_email`).

- `pronto-api/src/api_app/routes/employees/employees.py`
  - Manejo con `ValidationError` para preferencias.
  - Nuevo endpoint `PUT /employees/me/password`.

## Frontend

- `pronto-static/src/vue/employees/shared/components/ProfilePreferencesModal.vue`
  - Modal flotante con formularios de:
    - datos de perfil
    - cambio de contraseña

- `pronto-static/src/vue/employees/shared/components/Header.vue`
  - Nuevo item `Editar Perfil` en el dropdown de usuario.

- `pronto-static/src/vue/employees/App.vue`
  - Integración global del modal para todas las consolas employees.

## Init/Seeds

- `pronto-scripts/init/sql/40_seeds/0365__employee_preferences.sql`
  - Seed idempotente para crear registro `profile` por empleado en
    `pronto_employee_preferences` con campos base nulos.
