ID: ERR-20260303-ADMIN-REPORTS-VIEW-SHOULD-ONLY-SHOW-REPORTS-TAB
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Vista de reportes en admin muestra tabs administrativos adicionales
DESCRIPCION: En `/admin/dashboard/reports`, la barra superior está mostrando `Empleados`, `Roles` y `Configuración` junto a `Reportes`, cuando en esa vista solo debe aparecer el tab `Reportes`.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/reports`.
2. Revisar la barra de tabs superior.
RESULTADO_ACTUAL: Se muestran `Empleados`, `Roles`, `Reportes` y `Configuración`.
RESULTADO_ESPERADO: En esa vista solo debe mostrarse el tab `Reportes`.
UBICACION: pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Captura del usuario mostrando los cuatro tabs en la vista de reportes.
HIPOTESIS_CAUSA: El shell administrativo reutiliza un grupo de tabs compartido para las vistas administrativas sin discriminar que `reports` debe renderizar un grupo unitario.
ESTADO: RESUELTO
SOLUCION: `DashboardView.vue` ahora trata `reports` como un grupo de tabs unitario en `admin/system`, de modo que la vista de reportes solo expone el tab `Reportes` y deja de mezclar `Empleados`, `Roles` y `Configuración` en esa pantalla.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
