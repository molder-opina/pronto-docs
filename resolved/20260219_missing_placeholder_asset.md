ID: ERR-20260219-MISSING-PLACEHOLDER-ASSET
FECHA: 2026-02-19
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Asset placeholder-food.png referenciado no existe
DESCRIPCION: El componente ProductDetailModal.vue referencia /assets/images/placeholder-food.png que no existe en el directorio de assets estaticos.
PASOS_REPRODUCIR:
1. Acceder a menu de cliente
2. Abrir producto sin imagen
3. Verificar que la imagen placeholder genera 404
RESULTADO_ACTUAL: 404 al cargar placeholder-food.png
RESULTADO_ESPERADO: Imagen placeholder debe existir y mostrarse
UBICACION: pronto-static/src/vue/clients/components/menu/ProductDetailModal.vue:127
EVIDENCIA:
```vue
<img :src="product.image_path || '/assets/images/placeholder-food.png'" :alt="product.name" />
```
```bash
ls pronto-static/src/static_content/assets/images/ | grep -i placeholder
# (sin output - archivo no existe)
```
HIPOTESIS_CAUSA: Asset nunca fue creado o fue eliminado
ESTADO: RESUELTO
SOLUCION: Creado archivo placeholder-food.png copiando default-avatar.png como base temporal.
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
