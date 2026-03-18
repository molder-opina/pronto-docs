# CHG-20260318-171300

- FECHA: 2026-03-18
- AGENTE: Codex (GPT-5)
- MODULOS: pronto-static
- VERSION_ANTERIOR: 1.0715
- VERSION_NUEVA: 1.0715
- RESUMEN: Estabilizacion de build/tests de empleados posterior al rollout de command-layer: se corrige import roto de filtros en `SessionsBoard`, error de sintaxis en `CashierBoard`, mapeos de estado faltantes en helpers de mesero, fallback de logos en config store y ajustes de specs (`orders` + `employees-manager`) para el contrato vigente.
- COMMIT_HASHES: [724963b]
- RUTAS_AFECTADAS:
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/cashier/views/sessions/SessionsBoard.vue
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/cashier/components/CashierBoard.vue
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/waiter/modules/waiter/board-helpers.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/store/config.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/store/orders.spec.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/admin/components/employees-manager.spec.ts

## VALIDACION_EJECUTADA
- `npm run test:run` ✅ (56/56)
- `npm run build` ✅ (employees + clients)
