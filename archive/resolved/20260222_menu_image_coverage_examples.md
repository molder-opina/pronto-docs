ID: ERR-20260222-MENU-IMAGE-COVERAGE-EXAMPLES
FECHA: 2026-02-22
PROYECTO: pronto-static, pronto-libs, pronto-scripts/init
SEVERIDAD: media
TITULO: Catálogo de menú con imágenes faltantes en rutas referenciadas por seed
DESCRIPCION: Varias rutas `image_path` definidas en `pronto_shared/services/seed.py` no tenían archivo físico en `assets/pronto/menu`, causando placeholders o inconsistencia visual en nuevos ambientes.
PASOS_REPRODUCIR:
1) Revisar rutas `asset("menu/*.png")` del seed.
2) Comparar con archivos reales en `pronto-static/src/static_content/assets/pronto/menu/`.
3) Detectar faltantes.
RESULTADO_ACTUAL: Existían assets referenciados por seed sin archivo correspondiente.
RESULTADO_ESPERADO: Cobertura total de assets de menú (1:1 entre seed y archivos físicos) y trazabilidad en `init` para recargas futuras.
UBICACION: pronto-libs/src/pronto_shared/services/seed.py, pronto-static/src/static_content/assets/pronto/menu/, pronto-scripts/init/assets/menu-images/
EVIDENCIA: Auditoría local de cobertura `seed assets vs static assets` con faltantes detectados y luego corregidos.
HIPOTESIS_CAUSA: Seed evolucionó con nuevos `image_path` sin completar todos los binarios en estáticos.
SOLUCION: Se generaron/descargaron imágenes de ejemplo gratuitas para completar faltantes y se incorporó catálogo de referencias en `pronto-scripts/init/assets/menu-images/` junto con seed SQL de referencia (`0395__image_assets_reference.sql`).
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
ESTADO: RESUELTO
