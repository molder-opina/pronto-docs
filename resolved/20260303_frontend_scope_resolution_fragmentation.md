ID: CODE-20260303-031
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Lógica de resolución de scope fragmentada y redundante

DESCRIPCION: |
  Componentes como `Sidebar.vue` implementan su propia lógica para resolver el "scope" de la consola (waiter, chef, etc.) buscando en el path de la URL, el dataset del body o variables globales de window. Esta lógica es frágil y difícil de mantener si cambian los patrones de enrutamiento.

RESULTADO_ACTUAL: |
  La función `resolveConsoleScope` está definida localmente en componentes, repitiendo chequeos de strings.

RESULTADO_ESPERADO: |
  Centralizar la resolución de rol y scope en un store de Pinia (`AuthStore` o `UserStore`) o en una utilidad compartida en `shared/utils/role-context.ts`.

UBICACION: |
  - `pronto-static/src/vue/employees/shared/components/Sidebar.vue`
  - `pronto-static/src/vue/employees/shared/core/http.ts` (lógica similar)

ESTADO: RESUELTO
SOLUCION: Se centralizó la resolución de scope en `src/vue/employees/shared/core/console-scope.ts` y se refactorizaron consumidores críticos (`shared/core/http.ts` y `shared/components/Sidebar.vue`) para usar la utilidad única.
COMMIT: 65327b3
FECHA_RESOLUCION: 2026-03-06

ACCIONES_PENDIENTES:
  - [ ] Crear utilidad centralizada de resolución de contexto.
  - [ ] Refactorizar componentes para usar la utilidad única.
