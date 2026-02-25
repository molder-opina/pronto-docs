ID: ERR-20260223-CART-MODAL-ADD-SIMULATED
FECHA: 2026-02-23
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Productos agregados desde modal no llegan al carrito
DESCRIPCION: Al agregar productos desde el modal de detalle, se muestra un mensaje de éxito simulado pero el carrito permanece vacío. La función `addToCartFromModal` no persistía items en `CartPersistence`.
PASOS_REPRODUCIR:
1. Abrir menú de clientes.
2. Abrir un producto.
3. Presionar "Agregar al carrito" en el modal.
4. Abrir carrito.
RESULTADO_ACTUAL: El carrito sigue vacío.
RESULTADO_ESPERADO: El producto agregado desde modal debe aparecer en el carrito con su cantidad.
UBICACION: pronto-client/src/pronto_clients/templates/index.html
EVIDENCIA: `addToCartFromModal` contenía lógica simulada con notificación y cierre de modal, sin llamada a `window.addToCart`.
HIPOTESIS_CAUSA: Refactor incompleto dejó puente temporal en template sin integración real con store/persistencia.
ESTADO: RESUELTO
SOLUCION: Se implementó `addToCartFromModal` real en `index.html` usando `window.addToCart` (CartPersistence), con soporte de cantidad (`adjustModalQuantity`) y actualización de totales del modal.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
