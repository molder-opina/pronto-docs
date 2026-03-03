ID: ERR-20260303-ADMIN-EMPLOYEES-VIEW-SHOULD-ONLY-SHOW-EMPLOYEES-TAB
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Vista de empleados en admin muestra tabs administrativos adicionales
DESCRIPCION: En `/admin/dashboard/employees`, la barra superior está mostrando `Roles`, `Reportes` y `Configuración` junto a `Empleados`, cuando en esa vista solo debe aparecer el tab `Empleados`.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/employees`.
2. Revisar la barra de tabs superior.
RESULTADO_ACTUAL: Se muestran `Empleados`, `Roles`, `Reportes` y `Configuración`.
RESULTADO_ESPERADO: En esa vista solo debe mostrarse el tab `Empleados`.
UBICACION: pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Captura del usuario mostrando los cuatro tabs en la vista de empleados.
HIPOTESIS_CAUSA: El shell administrativo reutiliza un grupo de tabs compartido para todas las vistas administrativas sin discriminar que `employees` debe renderizar un grupo unitario.
ESTADO: RESUELTO
SOLUCION: `DashboardView.vue` ahora trata `employees` como un grupo de tabs unitario en `admin/system`, de modo que la vista de empleados solo expone el tab `Empleados` y deja de mezclar `Roles`, `Reportes` y `Configuración` en esa pantalla.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
