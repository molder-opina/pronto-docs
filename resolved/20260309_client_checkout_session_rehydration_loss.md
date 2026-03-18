ID: BUG-20260309-E2E-CHECKOUT-SESSION-REHYDRATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Pedir cuenta desde el mini-tracker falla cuando el cliente sigue autenticado pero se perdió el session_id local
DESCRIPCION: Durante el flujo E2E real del cliente seed `luartx@gmail.com`, el mini-tracker siguió mostrando la orden y su estado, pero el botón `Pedir Cuenta` falló con `No hay sesión activa` después de re-login/rehidratación parcial. El backend seguía reconociendo al cliente autenticado y las órdenes activas seguían disponibles, por lo que el fallo quedó localizado en la reconstrucción del `session_id` del lado cliente.
PASOS_REPRODUCIR:
1. Entrar a `http://127.0.0.1:6080/` y autenticarse como `luartx@gmail.com`.
2. Crear o reutilizar una sesión activa con orden en curso.
3. Perder el `pronto-session-id` del navegador (relogin, limpieza parcial o restauración de pestaña) sin cerrar la sesión real del cliente.
4. Esperar a que el mini-tracker vuelva a mostrar la orden activa.
5. Pulsar `Pedir Cuenta` desde el mini-tracker.
RESULTADO_ACTUAL:
- El cliente ve su orden y su progreso.
- El botón `Pedir Cuenta` usa solo `getSessionId()` de storage.
- Si `localStorage` perdió `pronto-session-id`, la UI muestra `No hay sesión activa` y no dispara el request de checkout.
- Evidencia runtime: `/api/client-auth/me` siguió devolviendo el cliente autenticado mientras la acción de checkout fallaba sin `session_id` local.
RESULTADO_ESPERADO: Si el cliente sigue autenticado y la orden/sesión activa ya está cargada en la app, el mini-tracker debe rehidratar/persistir `session_id` desde la orden o `sessionSummary` y permitir pedir la cuenta sin requerir una re-selección manual de mesa.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/store/orders.ts
EVIDENCIA:
- `requestCheckoutFromTracker()` dependía de `getSessionId()` mientras el store ya mantenía `sessionSummary`/órdenes activas con `session.id`.
- Validación browser real: tras borrar `localStorage['pronto-session-id']`, el click en `#request-checkout-btn` volvió a disparar `POST /api/customer/orders/session/<uuid>/request-check` con 200.
HIPOTESIS_CAUSA: El mini-tracker quedó acoplado a `localStorage` como única fuente de verdad para `session_id`, ignorando la fuente reactiva ya disponible en el store (`sessionSummary`/órdenes activas), lo que rompe el checkout cuando el estado local del navegador se pierde parcialmente.
ESTADO: RESUELTO
SOLUCION: Se añadió resolución canónica de `session_id` desde `ordersStore.sessionSummary`, órdenes activas y persistencia en `localStorage` antes de pedir checkout. También se cubrió con `vitest` y con rerun browser real borrando `pronto-session-id` antes del checkout.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

