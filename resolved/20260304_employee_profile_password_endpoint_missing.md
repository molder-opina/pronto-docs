ID: 20260304_employee_profile_password_endpoint_missing
FECHA: 2026-03-04
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: El modal Editar perfil no puede actualizar contraseña porque falta el endpoint
DESCRIPCION: En las consolas de empleados, el modal "Editar perfil" guarda los datos de perfil, pero el formulario "Cambiar contraseña" falla al enviar porque `/employees/me/password` no está implementado en `pronto-employees`.
PASOS_REPRODUCIR:
1. Iniciar sesión como empleado.
2. Abrir el modal "Editar perfil".
3. Capturar la contraseña actual y una nueva contraseña válida.
4. Hacer clic en "Actualizar contraseña".
RESULTADO_ACTUAL: La consola del navegador registra error al cargar el recurso de `/waiter/api/employees/me/password` y la contraseña no cambia.
RESULTADO_ESPERADO: El endpoint debe existir, validar la contraseña actual, actualizarla y devolver éxito al modal.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/api/employees.py
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/components/ProfilePreferencesModal.vue
EVIDENCIA: Validación en runtime desde `/waiter/dashboard/waiter`; el formulario de perfil persistió correctamente, pero el submit de contraseña produjo un error de recurso faltante.
HIPOTESIS_CAUSA: El frontend del modal fue conectado a `PUT /api/employees/me/password`, pero `pronto-employees` solo implementó preferencias y omitió el endpoint de cambio de contraseña aunque el servicio compartido `update_employee_password()` ya existe en `pronto-libs`.
ESTADO: RESUELTO
SOLUCION:
- Se implementó `PUT /employees/me/password` en `pronto-employees` y se conectó al servicio compartido `update_employee_password()` de `pronto-libs`.
- Se validó el flujo completo sobre `/waiter/dashboard`: lectura de email asignado, guardado de perfil, reapertura para confirmar persistencia, cambio de contraseña a un valor temporal y restauración posterior al valor original.
- Se agregó cobertura Playwright para el modal completo en `pronto-tests/tests/functionality/ui/playwright-tests/employees/profile-preferences.spec.ts`.
COMMIT: 034f2bf,2373870,9cb0699
FECHA_RESOLUCION: 2026-03-04
