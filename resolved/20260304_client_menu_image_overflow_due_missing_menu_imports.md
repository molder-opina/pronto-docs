ID: 20260304_client_menu_image_overflow_due_missing_menu_imports
FECHA: 2026-03-04
PROYECTO: pronto-client, pronto-static
SEVERIDAD: media
TITULO: Imagen gigante en menú cliente por colapso de estilos importados
DESCRIPCION: En `http://localhost:6080` una imagen del menú se renderiza con tamaño desbordado porque `menu.css` importa archivos no presentes (`menu-core.css`, `menu-filters.css`, `menu-checkout.css`, `menu-components.css`, `menu-orders.css`), lo que deja el layout parcial y sin límites robustos de imagen.
PASOS_REPRODUCIR: 1) Abrir cliente en `:6080` 2) Entrar a vista de menú/perfil 3) Observar cards o imágenes de menú con escala anómala.
RESULTADO_ACTUAL: Se muestra al menos una imagen con tamaño excesivo y el layout visual del menú queda inconsistente.
RESULTADO_ESPERADO: Todas las imágenes de productos deben mantenerse contenidas dentro de cards, sin desbordes.
UBICACION: pronto-static/src/static_content/assets/css/clients/menu.css y pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Captura de usuario con ilustración de comida ocupando gran parte del viewport.
HIPOTESIS_CAUSA: Import chain rota en CSS + ausencia de fallback global para clases de imagen usadas por distintas variantes del renderer de menú.
ESTADO: RESUELTO
SOLUCION: Se crearon los archivos CSS faltantes importados por `menu.css` para eliminar 404 y se añadió `menu-core.css` con reglas de contención para imágenes de cards (`menu-item-image`, `menu-item-card__image`, `product-card__image`). Además se agregó fallback defensivo equivalente en `base.html` y se evitó dependencia de `SearchFilter` compartido (scope employees) en `MenuPage.vue` de clientes.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04
