ID: BUG-20260310-PRONTO-STATIC-CLIENT-MINI-TRACKER-SESSION-VALIDATION-PLACEHOLDER-AND-MISSING-IMPORT
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: `client-mini-tracker` deja validación de sesión como placeholder y usa `setOrdersTabState` sin import explícito
DESCRIPCION: Durante la curación del lote restante de `pronto-static`, se detectó en `src/vue/clients/modules/client-mini-tracker.ts` que `validateAndCleanSession()` era un placeholder/no-op con comentarios temporales y que `refreshActiveOrders()` invocaba `setOrdersTabState(...)` sin importarlo desde `client-navigation`. Esto podía dejar `ReferenceError` en runtime y evitaba limpiar `pronto-session-id` cuando la sesión ya no era válida.
PASOS_REPRODUCIR:
1. Revisar `src/vue/clients/modules/client-mini-tracker.ts`.
2. Observar `validateAndCleanSession()` placeholder.
3. Observar llamada a `setOrdersTabState(...)` sin import correspondiente.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: El mini tracker valida/limpia la sesión de forma real y usa imports explícitos para helpers de navegación/tabs.
UBICACION:
- pronto-static/src/vue/clients/modules/client-mini-tracker.ts
EVIDENCIA:
- Búsqueda transversal de `setOrdersTabState` mostró la llamada libre en `client-mini-tracker.ts` y su definición real en `client-navigation.ts`.
- Búsqueda de placeholders mostró el comentario/no-op solo en `validateAndCleanSession()`.
HIPOTESIS_CAUSA: Refactor parcial del tracker cliente que extrajo helpers a módulos nuevos pero dejó un acoplamiento sin terminar.
ESTADO: RESUELTO
SOLUCION:
- Se importó `setOrdersTabState` correctamente desde `client-navigation`.
- `validateAndCleanSession()` ahora valida `/api/sessions/me`, rehidrata `session_id` cuando corresponde y limpia estado local obsoleto cuando la sesión es inválida.
- Se agregó `client-mini-tracker.spec.ts` para cubrir limpieza de sesión y actualización del contador de órdenes.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

