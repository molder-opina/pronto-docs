ID: ERR-20260317-001
FECHA: 2026-03-17
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Tecla ESC no cierra el carrito de compras
DESCRIPCION:
El componente CartPanel.vue no tiene un event listener para la tecla ESC que permita cerrar el carrito cuando está abierto.
Los usuarios esperan que presionar ESC cierre modales y paneles deslizantes, pero esta funcionalidad está ausente.
PASOS_REPRODUCIR:
1. Abrir la aplicación del cliente
2. Agregar productos al carrito
3. Abrir el carrito de compras
4. Presionar la tecla ESC en el teclado
RESULTADO_ACTUAL:
El carrito permanece abierto. No hay respuesta a la tecla ESC.
RESULTADO_ESPERADO:
El carrito debería cerrarse al presionar la tecla ESC.
UBICACION:
pronto-static/src/vue/clients/components/CartPanel.vue
EVIDENCIA:
El componente CartPanel.vue no tiene ningún event listener de teclado en su lógica setup().
HIPOTESIS_CAUSA:
Falta un event listener en onMounted que escuche keydown y verifique si es la tecla ESC para cerrar el carrito.
ESTADO: RESUELTO
SOLUCION:
Inicialmente se agregó un event listener de keydown en CartPanel para detectar la tecla ESC.

NOTA POSTERIOR:
Esta solución fue reemplazada por una solución más robusta usando eventos personalizados (ERR-20260317-003). La solución final usa el sistema keyboard-shortcuts.ts que dispatcha el evento 'pronto:cart-close' cuando se presiona ESC, y el CartPanel escucha este evento para cerrarse. Esto evita conflictos de event listeners y elimina la manipulación DOM directa.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-03-17
NOTA IMPORTANTE:
La solución original fue completamente reemplazada. VER ERR-20260317-003 para la solución final implementada.
