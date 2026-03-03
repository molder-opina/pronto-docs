ID: ERR-20260303-ADMIN-CONFIG-VIEW-SHOULD-ONLY-SHOW-CONFIG-TAB
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Vista de configuración en admin muestra tabs administrativos adicionales
DESCRIPCION: En `/admin/dashboard/config`, la barra superior está mostrando `Empleados`, `Roles` y `Reportes` junto a `Configuración`, cuando en esa vista solo debe aparecer el tab `Configuración`.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/config`.
2. Revisar la barra de tabs superior.
RESULTADO_ACTUAL: Se muestran `Empleados`, `Roles`, `Reportes` y `Configuración`.
RESULTADO_ESPERADO: En esa vista solo debe mostrarse el tab `Configuración`.
UBICACION: pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Captura del usuario mostrando los cuatro tabs en la vista de configuración.
HIPOTESIS_CAUSA: El shell administrativo reutiliza un grupo de tabs compartido para las vistas administrativas sin discriminar que `config` debe renderizar un grupo unitario.
ESTADO: RESUELTO
SOLUCION: `DashboardView.vue` ahora trata `config` como un grupo de tabs unitario en `admin/system`, de modo que la vista de configuración solo expone el tab `Configuración` y deja de mezclar `Empleados`, `Roles` y `Reportes` en esa pantalla.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
