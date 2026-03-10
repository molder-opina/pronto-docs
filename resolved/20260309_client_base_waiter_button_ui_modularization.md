ID: BUG-20260309-CLIENT-BASE-WAITER-BUTTON-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI del botón de mesero embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía la lógica DOM/UI del botón de mesero (`getWaiterButton()`, sincronía visual enable/disable y binding de click). Se extrajo a un helper dedicado sin tocar la llamada real al mesero, sesión, auth, requests ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `getWaiterButton()`, `refreshWaiterButtonState()` y la parte DOM de `attachWaiterButton()`.
3. Verificar que la parte extraída solo maneja query DOM, clases, atributos ARIA/título y binding del click.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba UI del botón de mesero con la lógica operativa que dispara la llamada.
RESULTADO_ESPERADO: La UI del botón de mesero debe vivir en un helper aislado y testeable, manteniendo intacta la lógica que dispara `callWaiter()`.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/waiter-button-ui.ts
- pronto-static/src/vue/clients/modules/waiter-button-ui.spec.ts
EVIDENCIA:
- `waiter-button-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage`, `CartPersistence`, `new Audio(...)` ni `waiter_call_sound`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/waiter-button-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
- Recurrencia inventariada: la lógica JS exacta del botón existe solo en `client-base.ts`; hay ocurrencias relacionadas del markup/estilos del botón en `pronto-client/templates/includes/_header.html` y `pronto-client/templates/base.html`, y la retroalimentación sonora relacionada queda aparte en `client-base.ts`/`micro-animations.ts`.
HIPOTESIS_CAUSA: La UI del botón se dejó dentro del entrypoint por cercanía con el flujo de llamada al mesero y no se separó después.
ESTADO: RESUELTO
SOLUCION: Se creó `waiter-button-ui.ts` para encapsular lookup DOM, sincronía visual enable/disable y binding del click del botón de mesero. `client-base.ts` conserva `callWaiter()` y el flujo operativo. Se añadió `waiter-button-ui.spec.ts` para cubrir lookup, sincronía visual y protección contra doble binding.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

