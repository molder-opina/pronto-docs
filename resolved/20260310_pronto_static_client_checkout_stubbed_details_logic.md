ID: BUG-20260310-PRONTO-STATIC-CLIENT-CHECKOUT-STUBBED-DETAILS-LOGIC
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: `client-checkout.ts` mantenía stubs/no-op para reglas del tab details y refresh posterior a cancelación
DESCRIPCION: El barrido del lote restante de `pronto-static` detectó que `src/vue/clients/modules/client-checkout.ts` conservaba varias funciones stub/no-op (`bindDetailsTabRules`, `setDetailsTabState`, `refreshPendingCartItemsFromDom`, `hydratePendingCartItemsFallback`, `getSelectedMiniTrackerOrderId`, `checkActiveOrdersGlobal`). `bindDetailsTabRules()` sí se invocaba durante la inicialización cliente, por lo que el tab details quedaba desincronizado respecto al carrito y órdenes activas.
PASOS_REPRODUCIR:
1. Revisar `src/vue/clients/modules/client-checkout.ts`.
2. Observar comentarios placeholder/no-op.
3. Ver que `bindDetailsTabRules()` se ejecuta en `client-initialization.ts`.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: El módulo enlaza helpers reales para sincronizar el tab details y refrescar el tracker tras cancelaciones.
UBICACION:
- pronto-static/src/vue/clients/modules/client-checkout.ts
- pronto-static/src/vue/clients/modules/client-initialization.ts
EVIDENCIA:
- Búsqueda de uso mostró llamada real a `bindDetailsTabRules()` desde init.
- `view-tabs-ui.ts` y `client-mini-tracker.ts` ya exponían helpers canónicos reutilizables.
HIPOTESIS_CAUSA: Refactor parcial que extrajo lógica a módulos nuevos pero dejó wrappers sin reconectar.
ESTADO: RESUELTO
SOLUCION:
- Se reconectó `client-checkout.ts` con `readPendingCartItemsFromDom`, `syncDetailsTabState`, el selector real del mini tracker y el refresh real de órdenes.
- `client-navigation.ts` ahora emite `client-orders-tab-state` para mantener alineado el tab details con el tab orders.
- Se agregó `client-checkout.spec.ts` y se verificó con Vitest + `npm run build:clients`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

