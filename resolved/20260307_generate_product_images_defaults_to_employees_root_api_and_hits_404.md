ID: TEST-20260307-063
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: generate-product-images usa 6081/api/menu por defecto y cae en 404 en vez de usar la API canónica
DESCRIPCION:
  `pronto-scripts/bin/generate-product-images.sh` construía `API_BASE` desde `EMPLOYEE_API_BASE_URL`, cuyo default actual
  es `http://localhost:6081`. Luego concatenaba `/api`, terminando en `http://localhost:6081/api/menu`. En el entorno
  actual esa ruta devuelve 404, mientras que la ruta canónica `http://localhost:6082/api/menu` responde 200.
PASOS_REPRODUCIR:
  1. Ejecutar `bash pronto-scripts/bin/generate-product-images.sh --dry-run -l 1`.
  2. Observar `No se pudo obtener /api/menu en http://localhost:6081/api`.
  3. Verificar con curl: `http://localhost:6081/api/menu` => 404, `http://localhost:6082/api/menu` => 200.
RESULTADO_ACTUAL:
  El script usaba por defecto una base no canónica y fallaba aunque la API real sí estaba disponible.
RESULTADO_ESPERADO:
  El script debe consumir `GET /api/menu` desde `pronto-api` (`:6082`) por defecto.
UBICACION:
  - `pronto-scripts/bin/generate-product-images.sh`
ESTADO: RESUELTO
SOLUCION:
  Se reemplazó el default basado en `EMPLOYEE_API_BASE_URL` por la API canónica `PRONTO_API_URL` y, en ausencia de override,
  por `http://localhost:6082`. Validación: `curl` confirmó `6081/api/menu => 404` y `6082/api/menu => 200`; tras el fix,
  `bash pronto-scripts/bin/generate-product-images.sh --dry-run -l 1` ya no falla intentando leer `6081/api/menu`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
