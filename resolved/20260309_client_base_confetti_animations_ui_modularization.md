ID: BUG-20260309-CLIENT-BASE-CONFETTI-ANIMATIONS-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI de confetti/animations embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía la lógica visual de `createConfetti()` y `ensureAnimations()`, encargada de crear partículas e inyectar estilos CSS para animaciones del cliente. Se extrajo a un helper dedicado sin tocar sesión, auth, requests, transporte ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `createConfetti()` y `ensureAnimations()`.
3. Verificar que solo dependen de DOM, CSS y timeouts visuales.
RESULTADO_ACTUAL: El entrypoint cliente conservaba lógica de animaciones/confetti mezclada con responsabilidades más amplias del módulo.
RESULTADO_ESPERADO: La UI de animaciones/confetti debe vivir en un helper aislado y testeable, manteniendo intacta la funcionalidad actual.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/confetti-animations-ui.ts
- pronto-static/src/vue/clients/modules/confetti-animations-ui.spec.ts
EVIDENCIA:
- `confetti-animations-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage` ni `CartPersistence`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/confetti-animations-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
- Recurrencia inventariada: existe otra implementación relacionada de confetti en `pronto-static/src/vue/clients/modules/micro-animations.ts`; queda pendiente fuera de este corte para evitar unificar comportamientos visuales no equivalentes en el mismo patch.
HIPOTESIS_CAUSA: Las animaciones se agregaron directamente en el entrypoint por cercanía con acciones globales del cliente y no se extrajeron después a un helper visual dedicado.
ESTADO: RESUELTO
SOLUCION: Se creó `confetti-animations-ui.ts` para encapsular `createConfetti()` y `ensureAnimations()`; `client-base.ts` ahora importa ese módulo y conserva el mismo comportamiento, incluida la exposición global de `window.createConfetti`. Se añadió `confetti-animations-ui.spec.ts` para cubrir inyección de estilos y lifecycle visual de las partículas.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

