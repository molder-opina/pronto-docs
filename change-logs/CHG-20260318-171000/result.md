# CHG-20260318-171000

- FECHA: 2026-03-18
- AGENTE: Codex (GPT-5)
- MODULOS: pronto-static
- VERSION_ANTERIOR: 1.0715
- VERSION_NUEVA: 1.0715
- RESUMEN: Inclusion del bloque pendiente de refactor en empleados: store `orders` migra a modelo `entities/ids` con estado de accion por entidad y se agregan composables de comandos (`use-order-commands`, `use-payment-commands`, `use-session-commands`) para encapsular operaciones operativas/financieras con timeout y trazabilidad de `actionId`.
- COMMIT_HASHES: [69f8b27]
- RUTAS_AFECTADAS:
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/store/orders.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/composables/use-order-commands.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/composables/use-payment-commands.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/composables/use-session-commands.ts

## VALIDACION_EJECUTADA
- `npm run build` (fallo en baseline employees por import faltante `./board/HistoryFilters.vue` en `cashier/views/sessions/SessionsBoard.vue`)
- `npm run test:run` (fallos preexistentes en suites employees + fallo en `shared/store/orders.spec.ts` por expectativas legacy ante nuevo contrato de store)
