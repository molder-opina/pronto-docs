---
ID: 20260202-C1
FECHA: 2026-02-02
PROYECTO: pronto-client, pronto-static
SEVERIDAD: alta
TITULO: URL de imagen de producto incorrecta resulta en 404
DESCRIPCION: La aplicación intenta cargar imágenes de productos (ej. `pollo_parrilla.png`) desde el host de `pronto-client` (`localhost:6080`) en lugar del host de `pronto-static` (`localhost:9088`). Esto viola la regla #6 de AGENTS.md, que dicta que `pronto-static` es la única fuente de assets estáticos.
PASOS_REPRODUCIR: 1. Cargar el menú de cliente. 2. Abrir la consola del navegador. 3. Observar los errores 404 para las imágenes de los productos.
RESULTADO_ACTUAL: `GET http://localhost:6080/assets/pronto/menu/pollo_parrilla.png` devuelve 404.
RESULTADO_ESPERADO: La URL solicitada debería ser `http://localhost:9088/assets/pronto/menu/pollo_parrilla.png` y devolver una imagen.
UBICACION: Desconocida. Probablemente en el código fuente de Vue en `pronto-static/src/vue` o en una plantilla de `pronto-client`.
EVIDENCIA: `(index):3717 GET http://localhost:6080/assets/pronto/menu/pollo_parrilla.png 404 (NOT FOUND)`
HIPOTESIS_CAUSA: El código que genera la URL de la imagen del producto está usando una ruta relativa o una variable de host incorrecta, apuntando al origen de la aplicación cliente en lugar del servidor de estáticos.
ESTADO: RESUELTO
---
SOLUCION: Se modificó el servicio `pronto-libs/src/pronto_shared/services/menu_service.py`. La función `list_menu` ahora carga la configuración, obtiene el host de estáticos (`pronto_static_public_host`), y lo antepone a las rutas de imagen relativas, asegurando que se devuelvan URLs absolutas y correctas en la respuesta de la API.
COMMIT: N/A_AGENT
FECHA_RESOLUCION: 2026-02-02