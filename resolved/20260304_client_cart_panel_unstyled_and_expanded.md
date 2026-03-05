ID: 20260304_client_cart_panel_unstyled_and_expanded
FECHA: 2026-03-04
PROYECTO: pronto-client, pronto-static
SEVERIDAD: alta
TITULO: Cart panel cliente se renderiza expandido dentro de la página
DESCRIPCION: En `:6080` el carrito (`#cart-panel`) pierde estilos de drawer y se muestra como bloque gigante dentro del documento, empujando el layout y dejando la vista gris con elementos sueltos.
PASOS_REPRODUCIR: 1) Abrir `http://localhost:6080/?view=profile&tab=login` 2) Observar DOM con `#cart-panel`/`#cart-items` 3) Verificar que aparecen en flujo normal con tamaño completo.
RESULTADO_ACTUAL: `#cart-panel` queda `position: static`, `display: block` y ocupa alto excesivo en el flujo principal.
RESULTADO_ESPERADO: `#cart-panel` debe ser drawer fijo lateral (`position: fixed`) oculto off-canvas hasta abrirse.
UBICACION: pronto-client/src/pronto_clients/templates/base.html, pronto-static/src/static_content/assets/css/clients/menu-components.css
EVIDENCIA: Captura de usuario + validación runtime de estilos computados antes del fix.
HIPOTESIS_CAUSA: Ausencia de estilos globales efectivos para `#cart-panel`/`#cart-backdrop` en el render SSR actual del cliente.
ESTADO: RESUELTO
SOLUCION: Se restauraron estilos globales de carrito en `menu-components.css` y se agregó fallback inline robusto en `base.html` para `#cart-panel`, `#cart-backdrop` y `#cart-items`, forzando comportamiento off-canvas fijo por defecto. Se copió `base.html` actualizado al contenedor `pronto-client-1` y se reinició el servicio. Validación runtime: `#cart-panel` quedó `position: fixed`, `transform: translateX(...)` y z-index correcto.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04
