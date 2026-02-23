ID: ERR-20260222-CLIENT-MENU-PLACEHOLDER-TRANSPARENT-REOPEN-01
FECHA: 2026-02-22
PROYECTO: pronto-client, pronto-static
SEVERIDAD: alta
TITULO: Reapertura - tarjetas del menú muestran bloque gris por placeholder transparente
DESCRIPCION:
Tras correcciones previas de layout, las tarjetas del menú en cliente seguían mostrando un bloque gris en el área de imagen porque el fallback de imagen apuntaba a `assets/pronto/icons/placeholder.png`, archivo transparente. Reapertura relacionada con `ERR-20260222-CLIENT-MENU-VUE-STYLES-MISSING`.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/` con sesión de cliente activa.
2. Ir a la pestaña "Menú".
3. Observar tarjetas sin imagen de producto.
RESULTADO_ACTUAL:
La parte superior de múltiples tarjetas se veía como bloque gris vacío.
RESULTADO_ESPERADO:
Las tarjetas deben mostrar imagen de producto o un placeholder visible de comida.
UBICACION:
- pronto-static/src/vue/clients/components/menu/ProductCard.vue
- pronto-static/src/static_content/assets/js/clients/menu.js
- pronto-static/src/static_content/assets/css/clients/menu-updates.css
- pronto-client/src/pronto_clients/templates/index.html
EVIDENCIA:
Capturas del usuario el 2026-02-22 y verificación local de tamaño de archivo: `placeholder.png` = 68 bytes.
HIPOTESIS_CAUSA:
Fallback de imagen configurado a un asset transparente legacy.
ESTADO: RESUELTO
SOLUCION:
Se cambió el fallback de imagen a `/assets/images/placeholder-food.png` en la fuente Vue (`ProductCard.vue`) y en el bundle estático actualmente servido (`assets/js/clients/menu.js`). También se añadió fallback visual CSS en `.product-card__image-container` y cache-busting adicional en los links CSS de `index.html` para forzar recarga del navegador.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
