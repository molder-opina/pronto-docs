---
ID: 20260202-D1
FECHA: 2026-02-02
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Inconsistencia en la visualización del logo de branding
DESCRIPCION: La implementación del backend para la funcionalidad de 'branding' guarda el logo en la base de datos y lo sirve a través del endpoint `/api/branding/logo`. Sin embargo, el código del frontend en `branding.html` no utiliza este endpoint, sino que intenta cargar el logo como un archivo estático (`.../branding/logo.png`), lo que resulta en que la imagen no se muestre.
PASOS_REPRODUCIR: 1. Usar la UI de "Gestión de Marca" para subir un logo. 2. La subida será exitosa. 3. Refrescar la página. 4. Observar que la imagen del logo no se muestra y la consola del navegador puede mostrar un error 404 para el archivo `.png`.
RESULTADO_ACTUAL: El frontend y el backend están desincronizados. El logo se guarda pero no se puede ver.
RESULTADO_ESPERADO: El frontend debe solicitar la imagen del logo al endpoint `/api/branding/logo` para mostrarla correctamente.
UBICACION: `pronto-employees/src/pronto_employees/templates/branding.html`
EVIDENCIA: La función `renderAssetCard` en `branding.html` construye una URL a un archivo `.png` estático, mientras que la API en `api_branding.py` sirve los datos de la imagen desde una ruta diferente.
HIPOTESIS_CAUSA: Implementación incompleta donde el frontend no se actualizó para coincidir con la lógica final del backend de servir la imagen desde la base de datos.
ESTADO: RESUELTO
---
SOLUCION: Se modificó la función `renderAssetCard` en `branding.html`. Ahora, si el tipo de asset es `logo` o `icon`, la URL de la imagen apunta a `/api/branding/logo`, que es el endpoint correcto de la API. Esto alinea el frontend con el backend.
COMMIT: N/A_AGENT
FECHA_RESOLUCION: 2026-02-02