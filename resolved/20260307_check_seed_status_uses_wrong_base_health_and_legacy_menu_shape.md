ID: TEST-20260307-065
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: check-seed-status usa base/health incorrectos y parsea shape legacy del menú
DESCRIPCION:
  `pronto-scripts/bin/check-seed-status.sh` construía `API_BASE` desde `EMPLOYEE_API_BASE_URL` (`6081`) y validaba salud
  contra `${API_BASE}/health`, que terminaba en `6081/api/health`. En el entorno actual esa ruta devuelve 404; la ruta
  válida es `/health` y la API canónica para `/api/menu` es `6082`. Además, el parser del menú esperaba `categories[].items[]`
  aunque el payload actual llega como `data.catalog_items`.
PASOS_REPRODUCIR:
  1. Ejecutar `bash pronto-scripts/bin/check-seed-status.sh`.
  2. Observar `La API no está respondiendo en http://localhost:6081/api`.
  3. Verificar con curl: `6081/api/health => 404`, `6082/api/health => 404`, `6081/health => 200`, `6082/health => 200`.
RESULTADO_ACTUAL:
  El script abortaba en el health check aunque los servicios estaban arriba y, aun pasando esa fase, el parser de menú quedaba desalineado.
RESULTADO_ESPERADO:
  Debe usar la API canónica para `/api/menu`, validar salud en `/health` y soportar el payload actual del menú.
UBICACION:
  - `pronto-scripts/bin/check-seed-status.sh`
ESTADO: RESUELTO
SOLUCION:
  Se actualizó el script para usar por defecto la API canónica (`PRONTO_API_URL` o `http://localhost:6082`), calcular la salud
  contra `${HEALTH_BASE}/health` y parsear primero `data.catalog_items`, manteniendo compatibilidad hacia atrás con `categories[].items[]`.
  Validación: `bash -n pronto-scripts/bin/check-seed-status.sh` => OK; `bash pronto-scripts/bin/check-seed-status.sh` => exit 0, reportando
  `20` productos y `9` categorías en el entorno actual.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
