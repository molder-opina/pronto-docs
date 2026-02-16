ID: ERR-20260213-LOGIN-SCOPE-403
FECHA: 2026-02-13
PROYECTO: pronto-libs / pronto-employees / pronto-static
SEVERIDAD: bloqueante
TITULO: Login de empleados retorna 403 por validación de scope incompleta
DESCRIPCION: El flujo de login por rol (waiter/chef/cashier/admin/system) rechazaba credenciales válidas debido a validación de scope que no consideraba el rol principal y provocaba errores encadenados en auth.
PASOS_REPRODUCIR:
1. Abrir /waiter/login (o cualquier rol) en localhost:6081.
2. Usar credenciales válidas prellenadas.
3. Enviar formulario.
RESULTADO_ACTUAL: POST /<rol>/login respondía 403 (luego 500 al alcanzar path de serialización UUID) y frontend redirigía a /authorization-error.
RESULTADO_ESPERADO: POST /<rol>/login responde 200/302 para credenciales válidas del rol correspondiente.
UBICACION: pronto-libs/src/pronto_shared/models.py (Employee.has_scope), pronto-employees/src/pronto_employees/routes/*/auth.py, pronto-static/src/vue/employees/core/http.ts
EVIDENCIA: Playwright temporal de login por rol pasó 5/5 después de los fixes; `npm run test:functionality` pasó 36/36.
HIPOTESIS_CAUSA: Employee.has_scope() solo evaluaba allow_scopes, y auth JSON/JWT intentaba serializar UUID sin normalizar a string.
ESTADO: RESUELTO
SOLUCION: Se corrigió `Employee.get_scopes/has_scope` para integrar role/additional_roles/allow_scopes con jerarquía canónica; se normalizó `employee_id` e `id` a string en auth routes/JWT; y se evitó redirect automático de 403 cuando la pantalla actual es login.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
