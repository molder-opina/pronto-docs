ID: ERR-20260303-ADMIN-DASHBOARD-TABS-WRONG-SET-FOR-ADMIN-VIEWS
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/shared)
SEVERIDAD: media
TITULO: Tabs del dashboard en admin muestran módulos operativos dentro de vistas administrativas
DESCRIPCION: Al entrar a vistas administrativas como `/admin/dashboard/reports` o `/admin/dashboard/config`, la barra de tabs superior sigue mostrando `Tablero`, `Cocina`, `Caja`, `Productos`, `Aditamientos`, `Mesas`, `Áreas` y `Caja y Cierres`, en lugar de las opciones administrativas propias de esas vistas.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/reports` o `http://localhost:6081/admin/dashboard/config`.
2. Revisar la barra de tabs superior.
3. Observar que aparecen tabs operativos/gestión y no tabs administrativos.
RESULTADO_ACTUAL: Las vistas administrativas comparten la barra de tabs equivocada.
RESULTADO_ESPERADO: Las vistas administrativas deben mostrar solo tabs administrativos (`Empleados`, `Roles y Permisos`, `Reportes`, `Configuración`), mientras las vistas operativas/gestión conservan su grupo de tabs propio.
UBICACION: pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Capturas compartidas por el usuario en sesión.
HIPOTESIS_CAUSA: `DashboardView.vue` resuelve tabs por scope y no por familia de vista actual, por lo que `admin/system` siempre caen en el grupo operativo.
ESTADO: RESUELTO
SOLUCION: Se actualizó `DashboardView.vue` para separar los tabs administrativos (`employees`, `roles`, `reports`, `config`) de los tabs operativos/gestión. Ahora, en `admin/system`, el shell elige el grupo de tabs según la vista actual, evitando que `Reportes` y `Configuración` muestren tabs de operación.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
