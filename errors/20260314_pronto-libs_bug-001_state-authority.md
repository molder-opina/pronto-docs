# BUG-001 - Autoridad única de transiciones de estado (Order + Payment)

- Fecha: 2026-03-14
- Repo: `pronto-libs`
- Estado: aplicado

## D0 verificación previa
1. Búsqueda ejecutada:
   - `rg -n --pcre2 "\\b(workflow_status|payment_status)\\b\\s*=\\s*(?![=])" pronto-libs/src/pronto_shared/services pronto-api/src -g"*.py"`
2. Evidencia:
   - 7 ocurrencias totales; 5 están en `order_state_machine_core.py` (canónico).
   - 1 ocurre en `split_bill_service_core.py` sobre entidad de split, no `Order`.
   - 1 es argumento `payment_status=` en creación de split.
3. Clasificación D0: `EXISTE`.
4. Decisión D0: `modificar` (se mantuvo solo mutación canónica para orden/pago en servicio oficial).

## Implementación
- Refactor previo aplicado en commit `fb2d876` (`pronto-libs`): centralización en state machine y retiro de mutaciones directas en flujos de cancelación.

## Validación
- `./pronto-scripts/bin/pronto-rules-check full` ✅
- `./pronto-scripts/bin/pronto-no-legacy` ✅
