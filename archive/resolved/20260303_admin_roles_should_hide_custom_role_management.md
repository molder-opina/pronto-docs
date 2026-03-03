ID: ERR-20260303-ADMIN-ROLES-SHOULD-HIDE-CUSTOM-ROLE-MANAGEMENT
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin roles)
SEVERIDAD: media
TITULO: Vista de Roles y Permisos expone roles personalizados y acciones de gestión no soportadas por el proyecto
DESCRIPCION: En `http://localhost:6081/admin/dashboard/roles`, la interfaz sigue mostrando creación, edición, eliminación y listado de roles personalizados aunque el proyecto solo opera con roles canónicos ya definidos.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/roles`.
2. Revisar el encabezado y las secciones inferiores.
3. Observar el botón `Nuevo Rol`, el bloque `Roles personalizados` y las acciones edit/delete.
RESULTADO_ACTUAL: La pantalla comunica un manejo de roles personalizados que no corresponde con el comportamiento real esperado.
RESULTADO_ESPERADO: La vista debe mostrar únicamente los roles canónicos definidos por el sistema y su explicación funcional, sin UI de creación/edición/eliminación de roles personalizados.
UBICACION: pronto-static/src/vue/employees/admin/components/RolesManager.vue; pronto-static/src/vue/employees/admin/components/roles/RoleCard.vue
EVIDENCIA: Solicitud directa del usuario en sesión.
HIPOTESIS_CAUSA: La vista de roles fue diseñada con un editor CRUD genérico RBAC y no fue restringida al modelo operativo actual del proyecto, que solo usa roles canónicos.
ESTADO: RESUELTO
SOLUCION: Se simplificó `RolesManager.vue` para dejar la pantalla en modo consulta: se eliminó la UI de `Nuevo Rol`, el listado de `Roles personalizados` y el modal de creación/edición. También `RoleCard.vue` recibió un modo `readonly` para ocultar acciones edit/delete cuando se muestra el inventario canónico. Se recompiló `employees` y se validó en runtime que `/admin/dashboard/roles` solo muestre la guía canónica y el bloque de roles oficiales detectados.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
