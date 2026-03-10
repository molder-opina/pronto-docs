ID: BUG-20260309-CLIENT-BASE-NOTIFICATION-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI de notificaciones embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía la lógica DOM/UI de `showNotification(...)` y `hideNotification(...)` para crear, animar y remover notificaciones visuales del cliente. Se extrajo a un helper dedicado sin tocar sesión, auth, requests, transporte ni proxies/BFF temporales, manteniendo la cola y el estado local dentro del entrypoint.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `showNotification(...)` y `hideNotification(...)`.
3. Verificar que la parte extraída solo maneja DOM, estilos y animaciones de entrada/salida.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba la UI de notificaciones con la cola/estado local del módulo.
RESULTADO_ESPERADO: La UI de notificaciones debe vivir en un helper aislado y testeable, manteniendo `activeNotification` y `notificationQueue` dentro de `client-base.ts`.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/notification-ui.ts
- pronto-static/src/vue/clients/modules/notification-ui.spec.ts
EVIDENCIA:
- `notification-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage` ni `CartPersistence`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/notification-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
- Recurrencia inventariada: existen implementaciones relacionadas de toasts/notificaciones en `pronto-static/src/vue/clients/modules/ux-interactions.js` y `pronto-static/src/vue/clients/modules/thank-you.ts`; quedan pendientes fuera de este corte para evitar unificar semánticas/UX distintas en el mismo patch.
HIPOTESIS_CAUSA: La UI de notificaciones se integró directamente en el entrypoint por conveniencia operativa y no se separó después del manejo de cola local.
ESTADO: RESUELTO
SOLUCION: Se creó `notification-ui.ts` para encapsular creación, estilos y animación de las notificaciones. `client-base.ts` conserva `activeNotification`, `notificationQueue`, el timeout de auto-hide y el orden de cola. Se añadió `notification-ui.spec.ts` para cubrir render, colores y remoción con callback.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

