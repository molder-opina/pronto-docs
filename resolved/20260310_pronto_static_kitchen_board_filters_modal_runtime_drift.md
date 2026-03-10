ID: BUG-20260310-PRONTO-STATIC-KITCHEN-BOARD-FILTERS-MODAL-RUNTIME-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: `KitchenBoard.vue` usa `FloatingFiltersModal` con props/events incompatibles y deja roto el cierre/aplicación del modal
DESCRIPCION: Tras validar `build:employees`, se revisó el refactor de `KitchenBoard.vue` y se detectó un drift de runtime: el componente usaba `FloatingFiltersModal` con `:is-open`, `@close` y `@apply-filters`, mientras el contrato real del modal compartido es `v-model` (`modelValue` / `update:modelValue`) y `@reset`, con slot para el formulario. Además el refactor había dejado sin aplicar los filtros, la pestaña `tracking` vacía y un `console.log` en `handleTableClick`.
PASOS_REPRODUCIR:
1. Abrir consola chef y abrir filtros en `KitchenBoard`.
2. Usar botón cerrar/cancelar/aplicar del modal.
3. Navegar a pestaña `tracking` y revisar conteos de tabs.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: `KitchenBoard` usa el mismo contrato de `FloatingFiltersModal` que el resto de boards y mantiene filtros/tabs funcionales.
UBICACION:
- pronto-static/src/vue/employees/chef/components/KitchenBoard.vue
- pronto-static/src/vue/employees/chef/components/KitchenTabs.vue
- pronto-static/src/vue/employees/shared/components/FloatingFiltersModal.vue
EVIDENCIA:
- Revisión del template mostró `:is-open`, `@close`, `@apply-filters` incompatibles.
- `FloatingFiltersModal.vue` define `modelValue`, `update:modelValue` y `reset`.
- El refactor también había dejado `tracking` en `[]` y conteos placeholders en `KitchenTabs.vue`.
HIPOTESIS_CAUSA: Extracción parcial del board de cocina a subcomponentes sin replicar el wiring canónico ni la lógica de filtros/tabs.
ESTADO: RESUELTO
SOLUCION:
- `KitchenBoard.vue` ahora usa `v-model`, `@reset` y slot real para el formulario de filtros.
- Se restauró la aplicación efectiva de filtros, el tab `tracking`, el guardado en localStorage y el detalle básico al hacer click en mesas.
- `KitchenTabs.vue` ahora cuenta seguimiento desde órdenes `ready` y mesas por números únicos ocupados.
- Se agregó `KitchenTabs.spec.ts` y se validó con Vitest + `npm run build:employees`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

