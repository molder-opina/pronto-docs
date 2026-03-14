# BUG-010 pronto-static — client orders canonical endpoints

## D0 verificación previa (EXISTE => modificar)
- Evidencia de existencia:
  - `pronto-static/src/vue/clients/store/orders.ts`
- Decisión: **modificar** store existente.
- Justificación: el store ya manejaba fetch/request-check con rutas legacy no canónicas y catches silenciosos.

## Cambios aplicados
1. Endpoints canónicos:
- `session-summary/{id}` -> `session/{id}`
- `request-check/{id}` -> `session/{id}/request-check`

2. Hardening de errores:
- Se eliminaron catches silenciosos.
- Se agregó logging explícito para fallos de resumen y request-check.

## Validación
- `./pronto-scripts/bin/pronto-api-parity-check clients` OK
- `./pronto-scripts/bin/pronto-rules-check full` OK
