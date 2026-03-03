ID: ERR-20260303-ADMIN-ROLES-RBAC-VIEW-MISALIGNED
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Vista de Roles y Permisos en admin no refleja el RBAC real ni explica el acceso efectivo por rol
DESCRIPCION: Al entrar a `/admin/dashboard/roles`, la pantalla muestra un estado vacío o tarjetas basadas en un esquema legacy (`role_code`, `role_name`, `color`, `icon`, `is_active`) que no coincide con la respuesta real del backend RBAC. La vista tampoco explica los roles canónicos ni el control de acceso efectivo entre consolas para empleados, administradores y system.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/roles`.
2. Observar la lista de roles y la información contextual disponible.
3. Ver que la pantalla no describe de forma correcta los roles canónicos ni consume el shape real devuelto por el backend.
RESULTADO_ACTUAL: La vista depende de un shape legacy, puede mostrar estado vacío incorrecto y no comunica claramente qué hace cada rol ni qué consolas puede usar cada tipo de empleado.
RESULTADO_ESPERADO: La pantalla debe renderizarse con el shape RBAC real (`name`, `display_name`, `description`, `is_custom`, `permissions`) y mostrar un módulo explicativo de roles canónicos, funciones y control de acceso efectivo por rol/admin/system.
UBICACION: pronto-static/src/vue/employees/shared/composables/use-rbac.ts; pronto-static/src/vue/employees/admin/components/RolesManager.vue; pronto-static/src/vue/employees/admin/components/roles/RoleCard.vue; pronto-static/src/vue/employees/admin/components/roles/RoleEditorModal.vue
EVIDENCIA: Captura compartida por el usuario en sesión.
HIPOTESIS_CAUSA: El frontend de administración de roles quedó acoplado a un contrato legacy distinto al implementado por `RBACService`, y la vista no reutiliza las reglas canónicas ya presentes en `pronto_shared/permissions.py`, `auth.ts` y `router/index.ts`.
ESTADO: RESUELTO
SOLUCION: Se reescribió la capa `use-rbac.ts` para consumir el contrato real de `RBACService` (`name`, `display_name`, `description`, `is_custom`, `permissions`) y se sustituyó la vista de `Roles y Permisos` por un módulo que explica los roles canónicos, sus funciones y el control de acceso efectivo por scope. También se actualizó el editor para crear/editar roles usando `name/display_name/description` y enviar permisos como códigos reales al backend.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
