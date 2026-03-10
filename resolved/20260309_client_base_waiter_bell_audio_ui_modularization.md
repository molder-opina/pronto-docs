ID: BUG-20260309-CLIENT-BASE-WAITER-BELL-AUDIO-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI/audio de campana de mesero embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía `playWaiterBellSound()`, responsable de resolver el archivo configurado, construir la URL del audio y reproducir la campana del mesero. Se extrajo a un helper dedicado sin tocar requests, auth, sesión ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `playWaiterBellSound()`.
3. Verificar que solo depende de `APP_SETTINGS`, `APP_CONFIG`, `Audio` y manejo seguro de errores.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba feedback UI/audio con la lógica operativa de llamar al mesero.
RESULTADO_ESPERADO: La reproducción de la campana debe vivir en un helper UI/audio aislado y testeable, manteniendo intacta la lógica que dispara `callWaiter()`.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/waiter-bell-audio-ui.ts
- pronto-static/src/vue/clients/modules/waiter-bell-audio-ui.spec.ts
EVIDENCIA:
- `waiter-bell-audio-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage` ni `CartPersistence`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/waiter-bell-audio-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
- Recurrencia inventariada: la reproducción exacta de la campana existía solo en `client-base.ts`; hay patrones relacionados de audio en `pronto-static/src/vue/clients/modules/micro-animations.ts` y la configuración `waiter_call_sound` se resuelve en `pronto-client`/`pronto-libs`, pero quedan fuera de este corte puntual.
HIPOTESIS_CAUSA: El feedback sonoro se dejó dentro del entrypoint por cercanía con el flujo de llamada al mesero y no se separó después.
ESTADO: RESUELTO
SOLUCION: Se creó `waiter-bell-audio-ui.ts` para encapsular la resolución del archivo configurado, la construcción de URL, el volumen y la reproducción segura del audio. `client-base.ts` conserva `callWaiter()` y el flujo operativo. Se añadió `waiter-bell-audio-ui.spec.ts` para cubrir configuración, fallback y tolerancia a errores.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

