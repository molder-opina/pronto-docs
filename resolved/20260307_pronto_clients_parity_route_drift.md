ID: CLI-20260307-001
FECHA: 2026-03-07
PROYECTO: pronto-static,pronto-client
SEVERIDAD: alta
TITULO: frontend cliente usa prefijos auth/session/waiter-calls legacy y rompe API parity
DESCRIPCION:
  El frontend cliente mezclaba contratos legacy y canónicos al llamar la API.
  Referenciaba `/api/auth/*`, `/api/session/*`, `/api/sessions/{id}/stripe/intent`
  y `/api/notifications/waiter/status/*`, mientras el backend actual expone
  rutas cliente bajo `client-auth`, `customer/payments`, `customer/orders`
  y `customers/waiter-calls`.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-scripts/bin/pronto-api-parity-check clients`.
  2. Observar faltantes en `core/http.ts`, `store/orders.ts`, `client-base.ts`,
     `client-profile.ts`, `OrdersTab.vue` y templates SSR.
RESULTADO_ACTUAL:
  El parity check de clients falla por uso de rutas y métodos legacy.
RESULTADO_ESPERADO:
  Todo consumo cliente debe apuntar al contrato real de `pronto-api`.
UBICACION:
  - `pronto-static/src/vue/clients/core/http.ts`
  - `pronto-static/src/vue/clients/store/user.ts`
  - `pronto-static/src/vue/clients/store/orders.ts`
  - `pronto-static/src/vue/clients/modules/client-base.ts`
  - `pronto-static/src/vue/clients/modules/client-profile.ts`
  - `pronto-static/src/vue/clients/modules/session-timeout.ts`
  - `pronto-static/src/vue/clients/modules/thank-you.ts`
  - `pronto-static/src/vue/clients/components/OrdersTab.vue`
  - `pronto-client/src/pronto_clients/templates/index.html`
  - `pronto-client/src/pronto_clients/templates/debug_panel.html`
EVIDENCIA:
  - `/api/auth/csrf`, `/api/auth/me`, `/api/auth/register`
  - `/api/session/{var}/orders`
  - `/api/session/{var}/request-check`
  - `/api/session/{var}/timeout`
  - `/api/sessions/{var}/stripe/intent`
HIPOTESIS_CAUSA:
  Migración incompleta del frontend cliente al contrato canónico actual del backend.
ESTADO: RESUELTO
SOLUCION:
  Se migraron las referencias a:
  `/api/client-auth/*`, `/api/customer/payments/sessions/{id}/*`,
  `/api/customer/orders/session/{id}/request-check` y
  `/api/customers/waiter-calls/status/{id}`. Además, el refresh CSRF
  dejó de depender de `/api/auth/csrf` y volvió a leer el token desde el HTML SSR.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

