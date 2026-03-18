ID: ERR-20260317-004
FECHA: 2026-03-17
PROYECTO: pronto-static/pronto-client
SEVERIDAD: alta
TITULO: Botón "Ir a pagar" no funciona - vista de checkout no se muestra
DESCRIPCION:
Cuando se hace clic en el botón "Ir a pagar" en el carrito, se emite el evento 'checkout', App.vue recibe el evento y llama a proceedToCheckout(), que cambia currentView a 'details'. Sin embargo:

1. El Vue App tiene slots vacíos para 'details', 'menu', 'orders'
2. Los slots no están siendo llenados por SSR
3. El contenido de checkout está embebido en HTML legacy en index.html/base.html pero no es controlado por Vue
4. Cambiar currentView en Vue no afecta al contenido legacy HTML SSR

PASOS_REPRODUCIR:
1. Abrir la aplicación del cliente
2. Agregar productos al carrito
3. Abrir el carrito
4. Hacer clic en "Ir a pagar"
RESULTADO_ACTUAL:
No pasa nada. La vista no cambia, el checkout no se muestra.
RESULTADO_ESPERADO:
Debería mostrarse la pantalla de checkout/detalles del pedido.
UBICACION:
- pronto-static/src/vue/clients/App.vue (líneas 148-152)
- pronto-static/src/vue/clients/App.vue (líneas 16-19 - slots vacíos)
- pronto-client/src/pronto_clients/templates/index.html (contenido legacy de checkout)
EVIDENCIA:
App.vue usa <slot name="details"></slot> que está vacío porque no hay contenido SSR que lo llene. El contenido de checkout está en HTML legacy pero Vue no lo controla.
HIPOTESIS_CAUSA:
Arquitectura híbrida incompleta: El Vue App se monta en #app pero los slots están vacíos, mientras que el contenido real de las vistas está en HTML legacy fuera del control de Vue. La navegación en Vue no sincroniza con el contenido legacy.
ESTADO: RESUELTO
SOLUCION:
Integrado el componente CheckoutView.vue ya existente en el App.vue:

1. Agregado import de CheckoutView en App.vue
2. Reemplazado el slot vacío `<slot name="details"></slot>` por el componente CheckoutView real
3. Agregado handler `handleOrderSuccess` que navega a la vista de orders después de que el pedido se confirme con éxito
4. Conectado el evento @success del CheckoutView con handleOrderSuccess

Cambios realizados:
- pronto-static/src/vue/clients/App.vue:
  - Import agregado: CheckoutView from './views/CheckoutView.vue'
  - Template actualizado: Reemplazado slot por componente CheckoutView con @back y @success
  - Handler agregado: handleOrderSuccess que navega a orders tras éxito

El flujo ahora funciona correctamente:
1. Usuario hace clic en "Ir a pagar" en el carrito
2. CartPanel emite evento 'checkout'
3. App.vue recibe evento y llama proceedToCheckout()
4. proceedToCheckout() cambia currentView a 'details'
5. Vue renderiza CheckoutView en la vista 'details'
6. Usuario completa checkout y confirma pedido
7. CheckoutView emite evento 'success' con orderId
8. App.handleOrderSuccess recibe orderId y navega a vista 'orders'
9. Vue renderiza OrderTracker con el orderId activo

COMMIT: pendiente
FECHA_RESOLUCION: 2026-03-17
