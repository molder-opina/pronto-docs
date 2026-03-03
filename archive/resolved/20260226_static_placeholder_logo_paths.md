ID: ERR-20260226-STATIC-PATHS
FECHA: 2026-02-26
PROYECTO: pronto-client, pronto-static
SEVERIDAD: media
TITULO: Rutas incorrectas de placeholder y logo en templates/componentes
DESCRIPCION: |
  1. index.html usa ruta `branding/placeholder.png` pero el archivo está en `icons/placeholder.png`
  2. BrandingSettings.vue referencia `logo.png` pero el archivo real es `logo.jpg`
PASOS_REPRODUCIR:
  1. Abrir menú de cliente con producto sin imagen → placeholder roto
  2. Abrir configuración de branding en employees → logo no carga
RESULTADO_ACTUAL: Imágenes rotas (404) por rutas/extensiones incorrectas
RESULTADO_ESPERADO: Placeholder e imágenes cargan correctamente
UBICACION: |
  pronto-client/src/pronto_clients/templates/index.html
  pronto-static/src/vue/employees/components/BrandingSettings.vue
HIPOTESIS_CAUSA: Rutas no actualizadas tras reorganización de assets
ESTADO: RESUELTO
SOLUCION: |
  - index.html: `branding/placeholder.png` → `icons/placeholder.png`
  - BrandingSettings.vue: `logo.png` → `logo.jpg`
COMMIT: (incluido en versión 1.0216→1.0217)
FECHA_RESOLUCION: 2026-02-26
