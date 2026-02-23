ID: ERR-20260222-CLIENTE-CART-NO-OPEN-CLICK
FECHA: 2026-02-22
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Botón de carrito no abre panel de compras en página de cliente
DESCRIPCION: Al hacer clic en el botón de carrito en el header, el panel de carrito no se abre en la vista de cliente.
PASOS_REPRODUCIR:
1. Abrir la página de cliente.
2. Hacer clic en el botón de carrito (icono carrito).
RESULTADO_ACTUAL: El panel de carrito no abre.
RESULTADO_ESPERADO: El panel de carrito abre y permite ver/editar items.
UBICACION: pronto-static/src/vue/clients/entrypoints/base.ts
EVIDENCIA: Reporte directo del usuario en validación manual.
HIPOTESIS_CAUSA: Falta de bindings explícitos de eventos click y funciones globales (`showCart`/`toggleCart`) hacia `cartStore` en bootstrap Vue.
ESTADO: RESUELTO
SOLUCION: Se agregó `initCartBindings()` en el entrypoint base para enlazar botones `data-toggle-cart` y `#sticky-cart-btn` al `cartStore`, junto con exposición global de `window.showCart`, `window.toggleCart` y `window.closeCart`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
