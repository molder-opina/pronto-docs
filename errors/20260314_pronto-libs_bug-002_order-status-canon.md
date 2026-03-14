# BUG-002 - Canon de estados de orden

- Fecha: 2026-03-14
- Repo: `pronto-libs`
- Estado: aplicado (con legacy de sesión aún visible)

## D0 verificación previa
1. Búsqueda ejecutada:
   - `rg -n "\\b(served|completed|awaiting_payment)\\b" pronto-libs/src pronto-api/src pronto-static/src/vue -g"*.py" -g"*.ts" -g"*.vue"`
2. Evidencia:
   - Ocurrencias legacy de `served/completed` permanecen en mapeos de compatibilidad y textos.
   - Flujo canónico de orden quedó en `new -> queued -> preparing -> ready -> delivered -> paid|cancelled`.
3. Clasificación D0: `EXISTE`.
4. Decisión D0: `modificar` (normalización a `delivered/paid` con alias legacy controlados).

## Implementación
- Refactor previo aplicado en commit `fb2d876` (`pronto-libs`): constantes y state machine alineados al canon actual.

## Validación
- `legacy_order_status_tokens=27` (incluye textos/compatibilidad; no todo es transición activa).
