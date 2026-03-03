ID: ERR-20260303-ADMIN-DASHBOARD-SIDEBAR-TAB-STRUCTURE
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Admin mezcla tableros operativos y gestión en el sidebar en lugar de concentrarlos como tabs del dashboard
DESCRIPCION: En `/admin/dashboard/*`, la navegación lateral incluye módulos operativos y de gestión, cuando el comportamiento esperado es que `Dashboard` agrupe los tableros operativos (`Tablero`, `Cocina`, `Caja`) y los tabs de gestión dentro del panel superior.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/config`.
2. Revisar el menú lateral y compararlo con la organización deseada del dashboard.
3. Observar que `Meseros` aparece como módulo lateral y que gestión no está consolidada como tabs del dashboard.
RESULTADO_ACTUAL: El sidebar de admin mezcla navegación de dashboard con módulos que deberían vivir como tabs dentro del contenido principal.
RESULTADO_ESPERADO: El sidebar de admin debe quedar con `Dashboard` y módulos administrativos; los tableros operativos y la gestión deben vivir como tabs del dashboard, usando `Tablero` como nombre del tab principal.
UBICACION: pronto-static/src/vue/employees/App.vue; pronto-static/src/vue/employees/shared/components/Sidebar.vue; pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Capturas compartidas por el usuario en sesión.
HIPOTESIS_CAUSA: La configuración actual de `visibleSections` para admin/system expone todos los módulos en el sidebar y `DashboardView.vue` oculta tabs en esos scopes.
ESTADO: RESUELTO
SOLUCION: Se limitó el sidebar de `admin/system` a secciones administrativas, manteniendo `Dashboard` como contenedor principal. `DashboardView.vue` ahora expone tabs para `Tablero`, `Cocina`, `Caja` y módulos de gestión; además el enlace `Dashboard` del sidebar permanece activo mientras se navega dentro de esas tabs.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
