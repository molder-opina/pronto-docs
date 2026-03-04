ID: 20260304_employee_profile_preferences_still_live_in_pronto_employees
FECHA: 2026-03-04
PROYECTO: pronto-employees, pronto-api, pronto-static, pronto-tests
SEVERIDAD: alta
TITULO: El perfil de empleado sigue usando funcionalidad local en pronto-employees
DESCRIPCION:
El modal `Editar perfil` de las consolas de empleados sigue consumiendo `/<scope>/api/employees/me/preferences` y `/<scope>/api/employees/me/password`, lo que resuelve lógica funcional dentro de `pronto-employees`. El usuario pidió corregirlo de raíz: si existe proxy scopeado, debe apuntar a un endpoint canónico en `pronto-api`, no a funcionalidad implementada en la página de empleados.
PASOS_REPRODUCIR:
1. Abrir `/waiter/dashboard/waiter`.
2. Abrir `Editar perfil`.
3. Guardar perfil o contraseña.
4. Revisar Network.
RESULTADO_ACTUAL:
Las mutaciones pasan por `PUT /waiter/api/employees/me/preferences` y `PUT /waiter/api/employees/me/password`, con implementación funcional en `pronto-employees`.
RESULTADO_ESPERADO:
El frontend debe usar `/<scope>/api/me/preferences` y `/<scope>/api/me/password` como proxy técnico hacia endpoints canónicos `PUT /api/me/preferences` y `PUT /api/me/password` en `pronto-api`.
UBICACION:
- pronto-static/src/vue/employees/shared/components/ProfilePreferencesModal.vue
- pronto-employees/src/pronto_employees/routes/api/employees.py
- pronto-api/src/api_app/routes/employees/employees.py
EVIDENCIA:
- Network mostraba `PUT http://localhost:6081/waiter/api/employees/me/preferences`.
- `pronto-employees` expone `@employees_api_bp.get("/employees/me/preferences")` y `@employees_api_bp.put("/employees/me/preferences")`.
HIPOTESIS_CAUSA:
La migración de rutas de perfil a `pronto-api` quedó a medias y se mantuvo el prefijo `/employees/me/*` por compatibilidad histórica.
ESTADO: RESUELTO
SOLUCION:
Se movió el contrato del modal de perfil a rutas canónicas `GET/PUT /api/me/preferences` y `PUT /api/me/password` en `pronto-api`. `pronto-static` ahora consume `/<scope>/api/me/*` vía proxy scopeado, y `pronto-employees` dejó de implementar localmente `employees/me/preferences` y `employees/me/password`. Además se corrigió la carga de `PRONTO_API_URL` en `pronto-employees` para que el proxy realmente apunte a `pronto-api`.
COMMIT:
- pronto-api: PENDIENTE_COMMIT
- pronto-employees: PENDIENTE_COMMIT
- pronto-static: PENDIENTE_COMMIT
- pronto-tests: PENDIENTE_COMMIT
- pronto-scripts: PENDIENTE_COMMIT
- pronto-docs: PENDIENTE_COMMIT
FECHA_RESOLUCION: 2026-03-04
