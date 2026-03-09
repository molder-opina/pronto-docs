ID: TEST-20260307-064
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: generate-product-images parsea un shape legacy de /api/menu y termina con cero productos
DESCRIPCION:
  Después de corregir la base URL hacia la API canónica, `pronto-scripts/bin/generate-product-images.sh` seguía sin
  encontrar productos porque su parser esperaba `categories[].items[]`, mientras que el payload actual de `/api/menu`
  llega envuelto como `{"status", "error", "data"}` y expone los productos en `data.catalog_items`.
PASOS_REPRODUCIR:
  1. Ejecutar `bash pronto-scripts/bin/generate-product-images.sh --dry-run -l 1`.
  2. Observar `No se encontraron productos` aunque `GET http://localhost:6082/api/menu` responde 200 con catálogo.
RESULTADO_ACTUAL:
  El script interpretaba el payload como vacío y abortaba sin listar productos.
RESULTADO_ESPERADO:
  El script debe soportar el shape actual de `/api/menu` y seguir tolerando el shape legacy si reaparece.
UBICACION:
  - `pronto-scripts/bin/generate-product-images.sh`
ESTADO: RESUELTO
SOLUCION:
  Se actualizó el parser embebido en Python para consumir primero `data.catalog_items` del payload actual y conservar
  compatibilidad hacia atrás con `categories[].items[]`. Validación: `bash -n pronto-scripts/bin/generate-product-images.sh`
  => OK; `bash pronto-scripts/bin/generate-product-images.sh --dry-run -l 1` => exit 0 listando `Agua Mineral`; `bash ... --dry-run -l 2 -c 'Bebidas'` => exit 0 listando 2 productos filtrados.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
