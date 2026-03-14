# BUG-006 - Retiro de módulos DOM legacy

- Fecha: 2026-03-14
- Repo: `pronto-static`
- Estado: aplicado (pendiente hardening adicional)

## D0 verificación previa
1. Búsqueda ejecutada de módulos legacy en `src/vue/employees/**`.
2. Evidencia:
   - Se detectaron módulos TS legacy no requeridos por router/runtime actual.
3. Clasificación D0: `EXISTE`.
4. Decisión D0: `modificar` (eliminar lo obsoleto).

## Implementación
- Eliminados:
  - `src/vue/employees/cashier/modules/cashier-board.ts`
  - `src/vue/employees/shared/modules/reports-manager.ts`

## Validación
- `dom_legacy_patterns=140` (todavía hay usos permitidos/no permitidos a depurar en cierre transversal).
- `npm run build:employees` ✅
