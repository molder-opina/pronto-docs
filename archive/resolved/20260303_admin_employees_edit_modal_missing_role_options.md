ID: ERR-20260303-ADMIN-EMPLOYEES-EDIT-MODAL-MISSING-ROLE-OPTIONS
FECHA: 2026-03-03
PROYECTO: pronto-static, pronto-employees, pronto-api
SEVERIDAD: alta
TITULO: Modal de editar empleado no muestra roles actuales en el combo
DESCRIPCION: En `/admin/dashboard/employees`, al abrir `Editar` sobre un empleado, el combo de `Rol` no muestra los roles disponibles ni el rol actual del empleado, dejando el selector en el placeholder `Selecciona un rol...`.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/employees`.
2. Hacer clic en `Editar` sobre cualquier empleado.
3. Observar el campo `Rol` dentro del modal.
RESULTADO_ACTUAL: El selector no refleja el rol actual ni lista los roles canónicos disponibles.
RESULTADO_ESPERADO: El selector debe listar los roles canónicos vigentes y preseleccionar el rol actual del empleado.
UBICACION: pronto-static/src/vue/employees/admin/components/EmployeesManager.vue, pronto-api/src/, pronto-employees/src/
EVIDENCIA: Captura del usuario mostrando el combo vacío en `Editar empleado`.
HIPOTESIS_CAUSA: El endpoint `GET /admin/api/roles/roles` estaba devolviendo `[]` en este entorno y `EmployeesManager` lo consideraba un éxito definitivo, dejando el combo sin opciones. Además, el modal no preservaba explícitamente el rol actual si el inventario cargado llegaba vacío.
ESTADO: RESUELTO
SOLUCION: Se endureció `pronto-static/src/vue/employees/admin/components/EmployeesManager.vue` para fusionar siempre los roles canónicos con cualquier rol que llegue del API, usar opciones visibles por scope y, al abrir `Editar`, insertar también el rol actual del empleado si no existiera en las opciones cargadas. Tras recompilar `employees`, el modal volvió a mostrar los roles y preseleccionó correctamente `Administrador` en la validación real del navegador.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
