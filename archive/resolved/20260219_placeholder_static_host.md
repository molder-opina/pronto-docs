ID: ERR-20260219-PLACEHOLDER-STATIC-HOST
FECHA: 2026-02-19
PROYECTO: pronto-static, pronto-client, pronto-employees
SEVERIDAD: media
TITULO: Imagenes placeholder usan path relativo en lugar de static_host_url
DESCRIPCION: Las componentes ProductCard.vue, ProductDetailModal.vue y AdminProductCard.vue usaban paths relativos (/assets/pronto/icons/placeholder.png) que resuelven al servidor actual (client:6080 o employees:6081) en lugar del servidor de estaticos (static:9088), causando errores 404.
PASOS_REPRODUCIR:
1. Cargar pagina de menu de clientes
2. Ver error 404 para placeholder.png en consola
3. La imagen se busca en localhost:6080 en lugar de localhost:9088
RESULTADO_ACTUAL: Error 404, imagen no cargada
RESULTADO_ESPERADO: Imagen cargada correctamente desde servidor de estaticos
UBICACION:
- pronto-static/src/vue/clients/components/menu/ProductCard.vue:28
- pronto-static/src/vue/clients/components/menu/ProductDetailModal.vue:127
- pronto-static/src/vue/employees/components/menu/AdminProductCard.vue:26
EVIDENCIA:
```
GET http://localhost:6080/assets/pronto/icons/placeholder.png 404 (NOT FOUND)
```
HIPOTESIS_CAUSA: Paths relativos hardcodeados sin usar static_host_url del APP_CONFIG
ESTADO: RESUELTO
SOLUCION: 
1. Actualizado ProductCard.vue y ProductDetailModal.vue para usar window.APP_CONFIG.static_host_url
2. Actualizado AdminProductCard.vue para usar window.STATIC_HOST_URL
3. Agregado STATIC_HOST_URL al template index.html de employees
4. Agregado cache buster ?v=cachebust2 a menu.js en base.html
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
