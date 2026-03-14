# BUG-005 - Migración de managers críticos a Vue

- Fecha: 2026-03-14
- Repo: `pronto-static`
- Estado: aplicado parcialmente

## D0 verificación previa
1. Búsqueda ejecutada sobre módulos legacy y componentes críticos.
2. Evidencia:
   - Los flujos críticos se concentran en SFCs (`CashierBoard.vue`, `KitchenOrders.vue`, etc.).
3. Clasificación D0: `EXISTE`.
4. Decisión D0: `modificar`.

## Implementación
- Correcciones de compilación y compatibilidad en flujo Vue:
  - `CashierBoard.vue` (errores de template/script).
  - `KitchenOrders.vue` (bloque duplicado inválido removido).
  - `use-order-cancellation.ts` (HTTP shared compatible).

## Validación
- `npm run build:employees` ✅
- `npx playwright test tests/functionality/ui/playwright-tests/employees/auth.spec.ts` ✅
