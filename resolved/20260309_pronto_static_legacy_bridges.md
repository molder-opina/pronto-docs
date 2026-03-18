ID: BUG-20260309-PRONTO-STATIC-LEGACY-BRIDGES
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: `pronto-static` mantiene bridges legacy duplicados o muertos en cart/tables/waiter
DESCRIPCION: Las auditorías abiertas del monorepo documentan que `pronto-static` mantiene módulos marcados como deprecated/legacy para compatibilidad (`cart-renderer.ts`, `tables-manager.ts`, `waiter/legacy/card-renderer.ts`). La revisión confirmó que dos de ellos ya no estaban referenciados en runtime y que el carrito ya montaba `CartPanel.vue`, por lo que el bridge residual duplicaba render/lógica sobre un DOM ya controlado por Vue.
PASOS_REPRODUCIR:
1. Buscar referencias runtime a `tables-manager.ts`, `waiter/legacy/card-renderer.ts` y `cart-renderer.ts`.
2. Verificar que `entrypoints/base.ts` monta `CartPanel.vue` sobre `#cart-panel`.
3. Confirmar que `clients/store/cart.ts` seguía instanciando `new CartRenderer()`.
RESULTADO_ACTUAL:
- `tables-manager.ts` y `waiter/legacy/card-renderer.ts` no tenían usos runtime.
- `cart-renderer.ts` seguía siendo invocado por el store aunque Vue ya renderizaba el panel.
- El store mezclaba side-effects DOM válidos con un renderer legacy redundante.
RESULTADO_ESPERADO: El runtime de `pronto-static` debe apoyarse en el renderer Vue ya montado, sin bridges muertos ni módulos legacy no referenciados. Los side-effects DOM mínimos que sigan siendo necesarios deben quedar explícitos y sin duplicar render del carrito.
UBICACION:
- pronto-static/src/vue/clients/store/cart.ts
- pronto-static/src/vue/clients/modules/cart-renderer.ts
- pronto-static/src/vue/clients/modules/tables-manager.ts
- pronto-static/src/vue/employees/waiter/modules/waiter/legacy/card-renderer.ts
- pronto-static/src/vue/clients/entrypoints/base.ts
EVIDENCIA:
- `CartPanel.vue` ya es el renderer activo del carrito.
- Se eliminó `CartRenderer` del store y se mantuvieron solo side-effects DOM mínimos (`cart-count`, `checkout-summary`, evento `cart-updated`).
- Se eliminaron los módulos muertos `tables-manager.ts`, `cart-renderer.ts` y `waiter/legacy/card-renderer.ts`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- store/cart.spec.ts` OK; `npm run build` OK.
HIPOTESIS_CAUSA: La migración SSR→Vue avanzó por capas, pero quedaron artefactos de compatibilidad y archivos puente no retirados después de que los componentes Vue asumieran el control real del DOM.
ESTADO: RESUELTO
SOLUCION: Se consolidó el carrito sobre `CartPanel.vue`, se reemplazó el bridge `updateLegacyDom` por side-effects DOM explícitos y exportables para prueba (`syncCartDomSideEffects`, `syncCheckoutSummary`), y se retiraron los módulos legacy ya sin referencias runtime.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

