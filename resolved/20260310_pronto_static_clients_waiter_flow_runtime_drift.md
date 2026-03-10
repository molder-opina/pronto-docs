ID: BUG-20260310-PRONTO-STATIC-CLIENTS-WAITER-FLOW-RUNTIME-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: El refactor del waiter flow cliente dejó imports/API incompatibles y firma incorrecta en inicialización
DESCRIPCION: Durante `build:clients` se detectó que `client-notifications.ts` seguía importando `callWaiter` desde `waiter-call-flow.ts`, aunque ese módulo ahora exporta `createWaiterCallFlow(...)`. Además `client-initialization.ts` llamaba `syncWaiterButtonUi(...)` con una firma incorrecta. Esto dejaba roto el flujo del botón “llamar al mesero” en runtime/compilación.
PASOS_REPRODUCIR:
1. Ejecutar `cd pronto-static && npm run build:clients`.
2. Observar fallo por export faltante `callWaiter`.
3. Revisar `attachWaiterButton()` en `client-initialization.ts`.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: El cliente conecta `window.callWaiter` y el botón waiter con el flow nuevo sin drift de imports ni firmas inválidas.
UBICACION:
- pronto-static/src/vue/clients/modules/client-notifications.ts
- pronto-static/src/vue/clients/modules/client-initialization.ts
- pronto-static/src/vue/clients/modules/waiter-call-flow.ts
EVIDENCIA:
- `build:clients` reportó que `callWaiter` no era export de `waiter-call-flow.ts`.
- Revisión de `client-initialization.ts` mostró llamada inválida a `syncWaiterButtonUi`.
HIPOTESIS_CAUSA: Refactor parcial al patrón factory `createWaiterCallFlow(...)` sin actualizar todos los puntos de integración cliente.
ESTADO: RESUELTO
SOLUCION:
- `client-notifications.ts` ahora crea un singleton lazy sobre `createWaiterCallFlow(...)`, reexpone `callWaiter()` y sincroniza el estado del botón waiter.
- `client-initialization.ts` dejó de usar la firma errónea y delega la sincronización a `refreshWaiterButtonState()`.
- Se validó con `waiter-call-flow.spec.ts` y `npm run build:clients`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

