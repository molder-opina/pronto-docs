ID: ERR-20260303-ADMIN-ROLES-VIEW-SHOULD-ONLY-SHOW-ROLES-TAB
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Vista de roles en admin muestra tabs administrativos adicionales
DESCRIPCION: En `/admin/dashboard/roles`, la barra superior está mostrando `Empleados`, `Reportes` y `Configuración` junto a `Roles`, cuando en esa vista solo debe aparecer el tab `Roles`.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/roles`.
2. Revisar la barra de tabs superior.
RESULTADO_ACTUAL: Se muestran `Empleados`, `Roles`, `Reportes` y `Configuración`.
RESULTADO_ESPERADO: En esa vista solo debe mostrarse el tab `Roles`.
UBICACION: pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Captura del usuario mostrando los cuatro tabs en la vista de roles.
HIPOTESIS_CAUSA: El shell administrativo reutiliza un grupo de tabs compartido para las vistas administrativas sin discriminar que `roles` debe renderizar un grupo unitario.
ESTADO: RESUELTO
SOLUCION: `DashboardView.vue` ahora trata `roles` como un grupo de tabs unitario en `admin/system`, de modo que la vista de roles solo expone el tab `Roles` y deja de mezclar `Empleados`, `Reportes` y `Configuración` en esa pantalla.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
