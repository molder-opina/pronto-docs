ID: ERR-20260222-CLIENTE-MENU-DESIGN-UNPOLISHED
FECHA: 2026-02-22
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Menú cliente con apariencia desalineada y poco pulida
DESCRIPCION: El diseño del menú se percibe visualmente feo/desalineado (tabs, espaciados y cards) en la vista de cliente.
PASOS_REPRODUCIR:
1. Abrir la página de cliente en menú.
2. Observar bloques de búsqueda, tabs y grilla de productos.
RESULTADO_ACTUAL: Jerarquía visual débil, tabs con estado activo poco claro, cards con apariencia irregular.
RESULTADO_ESPERADO: Menú limpio, compacto y uniforme con mejor lectura visual.
UBICACION: pronto-static/src/static_content/assets/css/clients/menu-updates.css
EVIDENCIA: Captura compartida por usuario durante validación.
HIPOTESIS_CAUSA: Acumulación de overrides con `!important` y estilos mixtos entre runtime Vue y CSS legacy.
ESTADO: RESUELTO
SOLUCION: Se añadió bloque de overrides final en `menu-updates.css` para componer visualmente header/search/tabs/grilla/cards en runtime actual, con estados activos consistentes y espaciado uniforme responsive.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
