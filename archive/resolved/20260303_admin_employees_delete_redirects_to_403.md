ID: ERR-20260303-ADMIN-EMPLOYEES-DELETE-REDIRECTS-TO-403
FECHA: 2026-03-03
PROYECTO: pronto-static, pronto-employees, pronto-api
SEVERIDAD: alta
TITULO: Acción Eliminar en Empleados redirige a authorization-error 403 desde admin
DESCRIPCION: En `/admin/dashboard/employees`, al hacer clic en `Eliminar`, el panel redirige a `/admin/authorization-error` con código 403 en lugar de ejecutar correctamente la operación de eliminación/desactivación para un administrador.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/employees`.
2. Hacer clic en `Eliminar` sobre un empleado.
3. Confirmar la acción.
4. Observar redirección a `/admin/authorization-error?...403...`.
RESULTADO_ACTUAL: La acción no es usable en el panel y termina en autorización denegada.
RESULTADO_ESPERADO: Un admin debe poder eliminar/desactivar empleados desde este panel con feedback usable.
UBICACION: pronto-static/src/vue/employees/admin/components/EmployeesManager.vue, pronto-employees/src/, pronto-api/src/
EVIDENCIA: Captura del usuario mostrando redirección a `/admin/authorization-error?code=403...&from=%2Fadmin%2Fdashboard%2Femployees`.
HIPOTESIS_CAUSA: El DELETE a empleados estaba siendo bloqueado en el proxy SSR de `pronto-employees` por una validación CSRF incompatible con requests JSON de Vue, lo que devolvía `403 CSRF_ERROR` y disparaba la redirección global a `authorization-error`.
ESTADO: RESUELTO
SOLUCION: Se corrigió `pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py` para validar mutaciones con `flask_wtf.csrf.validate_csrf()` usando el token real emitido en `meta[name="csrf-token"]`, en lugar de compararlo contra `request.form` o una cookie `csrf_token` inexistente en este flujo. Tras reiniciar `pronto-employees-1`, el `DELETE /admin/api/employees/:id` devolvió `200` y ejecutó la desactivación correctamente desde el panel admin.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
