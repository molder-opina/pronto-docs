ID: BUG-20260310-PRONTO-STATIC-CLIENT-NAVIGATION-EXPORT-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: `client-navigation.ts` importaba símbolos que no existían en módulos UI subyacentes
DESCRIPCION: Tras corregir el primer error sintáctico de `client-navigation.ts`, `build:clients` mostró drift adicional del refactor: el wrapper importaba `switchView` y `setOrdersTabState` desde módulos que no exportaban esos símbolos y tampoco pasaba callbacks requeridos a `backToMenuUi` / `applyInitialViewFromUrlUi`.
PASOS_REPRODUCIR:
1. Ejecutar `cd pronto-static && npm run build:clients`.
2. Observar errores de Rollup indicando exports faltantes desde `view-navigation-ui.ts` y `view-tabs-ui.ts`.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: El wrapper `client-navigation.ts` usa únicamente exports reales del módulo UI subyacente.
UBICACION:
- pronto-static/src/vue/clients/modules/client-navigation.ts
- pronto-static/src/vue/clients/modules/view-navigation-ui.ts
- pronto-static/src/vue/clients/modules/view-tabs-ui.ts
EVIDENCIA:
- `build:clients` falló con exports faltantes y callbacks ausentes.
HIPOTESIS_CAUSA: Refactor parcial del wrapper de navegación cliente con nombres desincronizados respecto a los módulos UI reales.
ESTADO: RESUELTO
SOLUCION:
- `client-navigation.ts` ahora usa `applyClientViewDom`, `bindViewTabs`, `syncOrdersTabDomState`, `backToMenuUi` y `applyInitialViewFromUrlUi` con callbacks correctos.
- Se agregó emisión del evento interno `client-orders-tab-state` para mantener alineado el estado del tab details.
- Se verificó con Vitest y `npm run build:clients`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

