# Applied - Mesa Obligatoria en Confirmacion

## Archivos modificados

- `pronto-client/src/pronto_clients/routes/api/table_context.py`
- `pronto-client/src/pronto_clients/routes/api/orders.py`
- `pronto-client/src/pronto_clients/routes/api/sessions.py`
- `pronto-client/src/pronto_clients/templates/base.html`
- `pronto-client/src/pronto_clients/templates/index.html`
- `pronto-api/src/api_app/routes/customers/orders.py`
- `pronto-libs/src/pronto_shared/services/orders/session_manager.py`
- `pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py` (tolerancia de entorno sin SDK Stripe para routes/parity)
- `pronto-static/src/vue/clients/core/http.ts` (parity de endpoint)

## Comportamiento aplicado

1. Confirmar orden sin mesa retorna `TABLE_REQUIRED`.
2. Mesa QR queda bloqueada y override manual retorna `TABLE_LOCKED_BY_QR`.
3. Kiosko resuelve mesa por `kiosk_location`; si no existe retorna `KIOSK_TABLE_NOT_CONFIGURED`.
4. `table_id` se normaliza y viaja siempre al payload de orden.
5. `table_id/table_source` persisten fuera de `flask.session` en payload Redis de sesion cliente.

## Validacion ejecutada

- `./pronto-tests/bin/pronto-tests-check` -> OK
- `./pronto-scripts/bin/pronto-api-parity-check employees` -> OK
- `./pronto-scripts/bin/pronto-api-parity-check clients` -> OK (tras correcciones de paridad)
- `./pronto-scripts/bin/pronto-rules-check changed` -> FAIL por baseline global de `pronto-no-legacy` (fuera del alcance funcional de este fix)
- `npx playwright test vue-rendering.spec.ts` / `vue-integrity.spec.ts` -> no existen en el repo actual (`No tests found`)

## Observaciones

- No se uso `flask.session` para almacenar mesa.
- No se cambiaron docker compose, puertos, redes o DB infra.
- Se mantuvieron rutas y contratos existentes; se extendio el flujo en puntos actuales.
