ID: ERR-20260303-ADMIN-DASHBOARD-LAYOUT-CONSISTENCY-REOPEN-01
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Reapertura: rutas internas de gestión en admin pierden el shell visual del dashboard
DESCRIPCION: Tras reorganizar el sidebar/tabs de `admin`, al navegar a rutas internas como `Productos` el shell seguía resolviendo un contexto inconsistente y reaparecía el bloque lateral de módulos operativos/gestión, rompiendo la continuidad visual del dashboard.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard`.
2. Entrar a la tab `Productos`.
3. Observar que el sidebar vuelve a mostrar módulos operativos/gestión en lugar de mantener el shell compacto de admin.
RESULTADO_ACTUAL: El layout lateral no conserva la misma estructura visual del dashboard admin al entrar a tabs internas.
RESULTADO_ESPERADO: Todas las tabs internas de `admin` deben mantener el mismo shell lateral y la misma navegación superior del dashboard.
UBICACION: pronto-static/src/vue/employees/shared/components/Sidebar.vue; pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Captura compartida por el usuario en sesión mostrando la inconsistencia al entrar a `Productos`.
HIPOTESIS_CAUSA: La resolución de scope para el shell dependía de heurísticas frágiles por ruta y no forzaba el contexto `admin` de forma consistente en tabs internas.
ESTADO: RESUELTO
SOLUCION: Se endureció la resolución de contexto en `Sidebar.vue` y `DashboardView.vue` usando primero el primer segmento real del pathname y luego `data-app-context`/`window.APP_CONTEXT`. Además el sidebar ya no renderiza módulos laterales para `admin/system`, incluso si recibe secciones sobrantes.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
