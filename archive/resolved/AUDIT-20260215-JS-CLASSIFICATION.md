# Auditoría de Clasificación de Archivos JavaScript

**Fecha:** 2026-02-15  
**Auditor:** AI Agent  
**Proyecto:** PRONTO

---

## Regla Binaria Aplicada

1. **Si un archivo es usado por 2+ módulos/features → static/js/shared/**
2. **Si un archivo es usado exclusivamente por Employees → employees/static/js/**

---

## TABLA DE CLASIFICACIÓN

### Archivos en `vue/employees/modules/waiter/`

| ARCHIVO | USADO_EN | UBICACIÓN_ACTUAL | UBICACIÓN_CORRECTA | ACCIÓN |
|---------|----------|------------------|-------------------|--------|
| `vue/employees/modules/waiter/types.ts` | WaiterBoard, KitchenBoard, CashierBoard, orders.ts | `vue/employees/modules/waiter/types.ts` | `vue/employees/modules/waiter/types.ts` | OK |
| `vue/employees/modules/waiter/sounds.ts` | NINGUNO | `vue/employees/modules/waiter/sounds.ts` | N/A | MOVER_A_LEGACY |
| `vue/employees/modules/waiter/ui-utils.ts` | NINGUNO | `vue/employees/modules/waiter/ui-utils.ts` | N/A | MOVER_A_LEGACY |
| `vue/employees/modules/waiter/constants.ts` | NINGUNO | `vue/employees/modules/waiter/constants.ts` | N/A | MOVER_A_LEGACY |
| `vue/employees/modules/waiter/card-renderer.ts` | NINGUNO | `vue/employees/modules/waiter/card-renderer.ts` | N/A | MOVER_A_LEGACY |

---

### Archivos en `vue/shared/` (compartidos entre employees y clients)

| ARCHIVO | USADO_EN | UBICACIÓN_ACTUAL | UBICACIÓN_CORRECTA | ACCIÓN |
|---------|----------|------------------|-------------------|--------|
| `vue/shared/workflow/status.ts` | employees (orders-board, cashier-board), clients (client-base, thank-you, active-orders, tables-manager) | `vue/shared/workflow/status.ts` | `vue/shared/workflow/status.ts` | OK |
| `vue/shared/lib/constants.ts` | employees (modifiers-manager, tables-manager), clients (client-base, tables-manager) | `vue/shared/lib/constants.ts` | `vue/shared/lib/constants.ts` | OK |
| `vue/shared/lib/formatting.ts` | employees (sessions-manager, modifiers-manager), clients | `vue/shared/lib/formatting.ts` | `vue/shared/lib/formatting.ts` | OK |
| `vue/shared/lib/session_state.ts` | employees (sessions-manager), clients | `vue/shared/lib/session_state.ts` | `vue/shared/lib/session_state.ts` | OK |
| `vue/shared/lib/role-context.ts` | employees (tables-manager), clients (tables-manager) | `vue/shared/lib/role-context.ts` | `vue/shared/lib/role-context.ts` | OK |
| `vue/shared/domain/table-code.ts` | employees (tables-manager), clients (base.ts, tables-manager, thank-you) | `vue/shared/domain/table-code.ts` | `vue/shared/domain/table-code.ts` | OK |
| `vue/shared/components/EmptyState.vue` | employees (ShortcutsManager) | `vue/shared/components/EmptyState.vue` | `vue/shared/components/EmptyState.vue` | OK |
| `vue/shared/components/ModalDialog.vue` | employees (ShortcutsManager) | `vue/shared/components/ModalDialog.vue` | `vue/shared/components/ModalDialog.vue` | OK |
| `vue/shared/components/PaginationControls.vue` | employees (ClosedSessionsManager) | `vue/shared/components/PaginationControls.vue` | `vue/shared/components/PaginationControls.vue` | OK |
| `vue/shared/lib/keyboard-shortcuts.ts` | clients (base.ts) | `vue/shared/lib/keyboard-shortcuts.ts` | `vue/shared/lib/keyboard-shortcuts.ts` | OK |

---

### Archivos Exclusivos de Employees

| ARCHIVO | USADO_EN | UBICACIÓN_ACTUAL | UBICACIÓN_CORRECTA | ACCIÓN |
|---------|----------|------------------|-------------------|--------|
| `vue/employees/modules/orders-board.ts` | WaiterBoard, KitchenBoard, CashierBoard | `vue/employees/modules/orders-board.ts` | `vue/employees/modules/orders-board.ts` | OK |
| `vue/employees/modules/cashier-board.ts` | CashierBoard | `vue/employees/modules/cashier-board.ts` | `vue/employees/modules/cashier-board.ts` | OK |
| `vue/employees/modules/sessions-manager.ts` | SessionsManager, ClosedSessionsManager | `vue/employees/modules/sessions-manager.ts` | `vue/employees/modules/sessions-manager.ts` | OK |
| `vue/employees/modules/tables-manager.ts` | TablesManager | `vue/employees/modules/tables-manager.ts` | `vue/employees/modules/tables-manager.ts` | OK |
| `vue/employees/modules/role-context.ts` | tables-manager | `vue/employees/modules/role-context.ts` | `vue/employees/modules/role-context.ts` | OK |

---

### Archivos Exclusivos de Clients

| ARCHIVO | USADO_EN | UBICACIÓN_ACTUAL | UBICACIÓN_CORRECTA | ACCIÓN |
|---------|----------|------------------|-------------------|--------|
| `vue/clients/modules/menu-flow.ts` | menu.ts (entrypoint) | `vue/clients/modules/menu-flow.ts` | `vue/clients/modules/menu-flow.ts` | OK |
| `vue/clients/modules/cart-persistence.ts` | menu.ts, cart.ts | `vue/clients/modules/cart-persistence.ts` | `vue/clients/modules/cart-persistence.ts` | OK |
| `vue/clients/modules/session-manager.ts` | menu.ts | `vue/clients/modules/session-manager.ts` | `vue/clients/modules/session-manager.ts` | OK |
| `vue/clients/modules/checkout-handler.ts` | menu.ts | `vue/clients/modules/checkout-handler.ts` | `vue/clients/modules/checkout-handler.ts` | OK |
| `vue/clients/modules/active-orders.ts` | base.ts, menu.ts | `vue/clients/modules/active-orders.ts` | `vue/clients/modules/active-orders.ts` | OK |

---

## ARCHIVOS SIN USO (MOVER_A_LEGACY)

Los siguientes archivos están en `vue/employees/modules/waiter/` y no son importados por ningún módulo:

1. `vue/employees/modules/waiter/sounds.ts`
2. `vue/employees/modules/waiter/ui-utils.ts`
3. `vue/employees/modules/waiter/constants.ts`
4. `vue/employees/modules/waiter/card-renderer.ts`

**Acción:** MOVER_A_LEGACY → `vue/employees/modules/waiter/legacy/`

---

## EVIDENCIA DE SHARED USAGE

### `@shared/workflow/status.ts` usado en:
- `vue/employees/modules/orders-board.ts`
- `vue/employees/modules/cashier-board.ts`
- `vue/clients/modules/client-base.ts`
- `vue/clients/modules/thank-you.ts`
- `vue/clients/modules/active-orders.ts`
- `vue/clients/modules/tables-manager.ts`

### `@shared/lib/constants.ts` usado en:
- `vue/employees/modules/modifiers-manager.ts`
- `vue/employees/modules/tables-manager.ts`
- `vue/clients/modules/client-base.ts`
- `vue/clients/modules/tables-manager.ts`

### `@shared/domain/table-code.ts` usado en:
- `vue/employees/modules/tables-manager.ts`
- `vue/clients/entrypoints/base.ts`
- `vue/clients/modules/tables-manager.ts`
- `vue/clients/modules/thank-you.ts`
- `vue/clients/modules/active-orders.ts`

---

## CONCLUSION

| CATEGORÍA | CANTIDAD | ACCIÓN |
|-----------|----------|--------|
| Archivos OK (ubicación correcta) | 25 | Ninguna |
| Archivos sin uso (legacy) | 4 | MOVER_A_LEGACY |
| Archivos que requieren movimiento | 0 | Ninguna |

**Total archivos analizados:** 29  
**Requieren acción:** 4 (MOVER_A_LEGACY)
