# PLAN

1. Exponer endpoints para perfil propio en employees API:
   - `GET /api/employees/me/preferences`
   - `PUT /api/employees/me/preferences`
   - `PUT /api/employees/me/password`
2. Persistir preferencias en `pronto_employee_preferences` (`key=profile`).
3. Bloquear cambios de email asignado desde flujo de perfil del empleado.
4. Agregar modal visual de edición de perfil en el menú de usuario compartido.
5. Sembrar preferencias base en init (`40_seeds`) para primer uso.
