ID: TEST-20260307-060
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: baja
TITULO: generate-product-images --dry-run intenta escribir en /var/www y falla sin permisos
DESCRIPCION:
  `pronto-scripts/bin/generate-product-images.sh --dry-run -l 1` fallaba antes de simular la generación porque intentaba
  crear el directorio `OUTPUT_DIR` bajo `/var/www/pronto-static/...`, lo que requiere permisos elevados en el host.
PASOS_REPRODUCIR:
  1. Ejecutar `bash pronto-scripts/bin/generate-product-images.sh --dry-run -l 1`.
  2. Observar `mkdir: /var/www/pronto-static/...: Permission denied`.
RESULTADO_ACTUAL:
  El modo dry-run no era realmente no-destructivo/agnóstico al host: fallaba por permisos antes de mostrar qué haría.
RESULTADO_ESPERADO:
  El dry-run debe evitar escribir en rutas protegidas o requerir permisos especiales.
UBICACION:
  - `pronto-scripts/bin/generate-product-images.sh`
ESTADO: RESUELTO
SOLUCION:
  El script ahora omite `mkdir -p "${OUTPUT_DIR}"` y `chmod -R 755 "${OUTPUT_DIR}"` cuando `DRY_RUN=true`,
  de modo que el modo simulación ya no intenta escribir en `/var/www`. Validación: `bash -n pronto-scripts/bin/generate-product-images.sh`
  => OK; `bash pronto-scripts/bin/generate-product-images.sh --dry-run -l 1` ya no falla por permisos y avanza hasta el
  siguiente bloqueo real independiente (`No se pudo obtener /api/menu en http://localhost:6081/api`); además se confirmó
  que el directorio por defecto no se crea en dry-run.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
