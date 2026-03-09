ID: TEST-20260307-061
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: baja
TITULO: generate-product-images usa ${category,,} y rompe en macOS con Bash 3.2
DESCRIPCION:
  `pronto-scripts/bin/generate-product-images.sh` usaba la expansión `${category,,}` para normalizar a minúsculas
  antes del `case` de estilos. En Bash 3.2 de macOS esa expansión no existe y rompe con `bad substitution`.
PASOS_REPRODUCIR:
  1. Ejecutar en macOS: `bash -c 'category="Entrada"; case "${category,,}" in *entrada*) echo ok;; esac'`.
  2. Observar `bash: ${category,,}: bad substitution`.
RESULTADO_ACTUAL:
  El script contenía un bashism incompatible con Bash 3.2.
RESULTADO_ESPERADO:
  La normalización de categoría debe hacerse con una técnica portable compatible con Bash 3.2.
UBICACION:
  - `pronto-scripts/bin/generate-product-images.sh`
ESTADO: RESUELTO
SOLUCION:
  Se reemplazó `${category,,}` por una normalización portable basada en `printf` + `tr`, almacenando el resultado en
  `category_normalized` antes del `case`. Validación: `bash -n pronto-scripts/bin/generate-product-images.sh` => OK;
  `rg` confirma que ya no existe `${category,,}` en el archivo; smoke test equivalente en Bash 3.2 => `ok`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
