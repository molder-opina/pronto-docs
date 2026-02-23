ID: ERR-20260222-CLIENT-MENU-NULL-IMAGEPATH-SINGLE-FALLBACK
FECHA: 2026-02-22
PROYECTO: pronto-client, pronto-static
SEVERIDAD: media
TITULO: Menú de cliente usa una sola imagen fallback para todos los productos con image_path null
DESCRIPCION:
El endpoint `/api/menu` devuelve `image_path: null` para los productos de demo. El frontend mostraba la misma imagen fallback para todos los cards, causando apariencia incorrecta y poco usable.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/` con sesión de cliente activa.
2. Entrar a la pestaña Menú.
3. Verificar que múltiples productos distintos muestran la misma imagen.
RESULTADO_ACTUAL:
Todos los productos sin `image_path` mostraban un único placeholder repetido.
RESULTADO_ESPERADO:
Productos sin `image_path` deben mostrar fallbacks visuales variados y coherentes por tipo de producto.
UBICACION:
- pronto-static/src/vue/clients/components/menu/ProductCard.vue
- pronto-static/src/static_content/assets/js/clients/menu.js
EVIDENCIA:
Payload local de `/api/menu` con `image_path: null` en todas las categorías y captura UI con imagen repetida.
HIPOTESIS_CAUSA:
Lógica de fallback frontend con una sola imagen fija, sin heurística por nombre/descripción de producto.
ESTADO: RESUELTO
SOLUCION:
Se implementó fallback inteligente por keywords (name/description) para resolver imágenes distintas por tipo de producto (entradas, platos fuertes, postres, bebidas), usando assets existentes en `/assets/pronto/menu/*`. Se aplicó en fuente Vue y en bundle runtime actualmente servido.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
