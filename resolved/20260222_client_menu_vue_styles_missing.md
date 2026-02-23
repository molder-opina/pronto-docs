ID: ERR-20260222-CLIENT-MENU-VUE-STYLES-MISSING
FECHA: 2026-02-22
PROYECTO: pronto-client, pronto-static
SEVERIDAD: alta
TITULO: Menú de clientes renderiza sin estilos Vue (layout roto)
DESCRIPCION:
La página principal de clientes (`/` en `pronto-client`) mostraba componentes del menú con layout incorrecto (categorías en columna lateral y área vacía grande) porque el JS de Vue montaba el contenido sin reglas CSS completas para clases runtime (`menu-page__*`, `search-filter`, `category-tabs__scroll`, etc.).
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/` con sesión de cliente activa.
2. Observar sección de menú y categorías.
3. Validar que el contenido se renderiza sin estilos consistentes.
RESULTADO_ACTUAL:
El menú aparecía parcialmente sin estilo: controles comprimidos, categorías mal distribuidas y separación visual excesiva antes de las tarjetas.
RESULTADO_ESPERADO:
El menú debe mostrarse con layout responsivo y estilos correctos para los componentes Vue.
UBICACION:
- pronto-client/src/pronto_clients/templates/index.html
- pronto-static/src/static_content/assets/css/clients/menu-updates.css
- pronto-static/src/static_content/assets/js/clients/menu.js
EVIDENCIA:
Captura proporcionada por usuario con render defectuoso en `http://localhost:6080`.
HIPOTESIS_CAUSA:
Faltaban reglas CSS para clases de componentes Vue renderizados por `menu.js` (especialmente `category-tabs__scroll` y `search-filter`), provocando fallback de layout no intencional.
ESTADO: RESUELTO
SOLUCION:
Se agregaron reglas de compatibilidad Vue en `pronto-static/src/static_content/assets/css/clients/menu-updates.css` para clases runtime (`menu-page__header`, `search-filter`, `search-input*`, `category-tabs__scroll`, `menu-page__content`, `loading-state`, `empty-results`, `grid-item` y variantes `.is-active`).
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
