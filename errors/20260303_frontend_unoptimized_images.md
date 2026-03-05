ID: PERF-20260303-002
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Imágenes de menú sin optimizar (>1MB) impactan rendimiento

DESCRIPCION: |
  Se han detectado múltiples imágenes en el catálogo del menú (`assets/pronto/menu/`) que superan el tamaño de 1MB. Estas imágenes se cargan masivamente en la vista de menú del cliente, lo que genera un consumo excesivo de datos móviles y tiempos de carga lentos.

RESULTADO_ACTUAL: |
  Ejemplos de archivos pesados:
  - `pizza_carnivora.png` (>1MB)
  - `pizza_bbq_chicken.png` (>1MB)
  - `hamburguesa_doble.png` (>1MB)
  - Entre otros 8 archivos.

RESULTADO_ESPERADO: |
  Las imágenes de productos deben estar optimizadas para web (WebP o JPEG progresivo) y no deberían exceder los 200KB para visualización en listas. Se recomienda implementar un pipeline de procesamiento de imágenes o redimensionarlas manualmente.

UBICACION: |
  - `pronto-static/src/static_content/assets/pronto/menu/`

ESTADO: ABIERTO

ACCIONES_PENDIENTES:
  - [ ] Convertir imágenes de PNG a WebP con compresión.
  - [ ] Redimensionar imágenes a un máximo de 800px de ancho.
  - [ ] Actualizar las referencias en la base de datos si cambian las extensiones.
