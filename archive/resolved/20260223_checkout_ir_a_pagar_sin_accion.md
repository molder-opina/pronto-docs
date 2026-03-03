ID: ERR-20260223-CHECKOUT-SIN-ACCION
FECHA: 2026-02-23
PROYECTO: pronto-static / pronto-client
SEVERIDAD: alta
TITULO: Boton "Ir a pagar" no realiza accion visible en menu cliente
DESCRIPCION: En la vista de menu con productos en carrito, al presionar el boton "Ir a pagar" no se abre la vista de checkout/detalles y para el usuario parece que no ocurre nada.
PASOS_REPRODUCIR:
1. Abrir cliente en http://localhost:6080.
2. Agregar productos al carrito.
3. Abrir carrito lateral.
4. Presionar "Ir a pagar".
RESULTADO_ACTUAL: No hay cambio visible de vista hacia checkout/detalles.
RESULTADO_ESPERADO: Debe abrir la vista de detalles/checkout para confirmar pedido o continuar flujo de pago.
UBICACION: pronto-static/src/vue/clients/components/CartPanel.vue; pronto-static/src/static_content/assets/js/shared/bindings.js; pronto-static/src/vue/clients/modules/client-base.ts
EVIDENCIA: Reporte de usuario + trazas de red sin accion de checkout posterior al click.
HIPOTESIS_CAUSA: Falta implementacion global de window.proceedToCheckout y falta wiring de cambio de tabs/vistas (menu/detalles/ordenes), por lo que el fallback de navegacion no produce transicion util.
ESTADO: RESUELTO
SOLUCION: Se implemento `window.proceedToCheckout` en `client-base.ts` para cambiar a la vista `details`, se agrego `window.switchView` y binding explicito de tabs (`tab-menu`, `tab-details`, `tab-orders`) con toggle de secciones (`[data-menu-root]`, `#checkout-section`, `#active-orders-section`). Tambien se expuso `window.backToMenu` para mantener consistencia de navegacion.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
