ID: BUG-20260309-CLIENT-BASE-WAITER-CALL-FLOW-REFACTOR
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: `client-base.ts` mantiene el flujo operativo de llamada al mesero embebido en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía la orquestación operativa de llamada al mesero: validaciones de auth/sesión, request `call-waiter`, feedback visual, SSE/polling de confirmación y wiring del botón. Se extrajo a un módulo dedicado con inyección de dependencias, sin cambiar rutas, payloads, sesión, auth real ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `refreshWaiterButtonState()`, `attachWaiterButton()`, `callWaiter()` y `checkWaiterCallStatus()`.
3. Verificar que el flujo mezcla estado visual del botón, request real y confirmación SSE/polling.
RESULTADO_ACTUAL: El entrypoint cliente concentraba la orquestación del flujo de llamada al mesero junto con otros dominios.
RESULTADO_ESPERADO: El flujo debe vivir en un módulo dedicado (`waiter-call-flow.ts`) con dependencias inyectadas, manteniendo comportamiento y contratos actuales.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/waiter-call-flow.ts
- pronto-static/src/vue/clients/modules/waiter-call-flow.spec.ts
EVIDENCIA:
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/waiter-call-flow.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
- Contratos preservados: `POST /api/call-waiter` con body `{ session_id, table_number }` y polling `GET /api/customers/waiter-calls/status/{call_id}`.
- Recurrencia inventariada: en frontend cliente solo existía esta orquestación (`client-base.ts`); hay referencias relacionadas en `pronto-client/src/pronto_clients/routes/api/waiter_calls.py`, `pronto-client/src/pronto_clients/templates/debug_panel.html`, `pronto-api/src/api_app/routes/customers/waiter_calls.py` y `pronto-libs` (schemas/config/services), pero no otro flujo frontend equivalente.
HIPOTESIS_CAUSA: El flujo de llamada al mesero creció dentro del entrypoint por cercanía con el botón/UI inicial y nunca se separó a un módulo de dominio cliente.
ESTADO: RESUELTO
SOLUCION: Se creó `waiter-call-flow.ts` con `createWaiterCallFlow(...)` e inyección de dependencias para auth local, sesión, requestJSON, feedback UI, SSE/polling y wiring del botón. `client-base.ts` ahora actúa como composition root y delega en wrappers finos. Se añadió `waiter-call-flow.spec.ts` para cubrir estado disabled, auth missing, sesión missing y confirmación vía notification manager.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

