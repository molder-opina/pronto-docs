ID: TEST-20260303-002
FECHA: 2026-03-03
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: Scripts de prueba y monitoreo con rutas incorrectas

DESCRIPCION: |
  Scripts en `pronto-scripts/bin` usaban rutas rígidas/legacy no alineadas con estructura SPA actual, causando fallos o chequeos inválidos.

RESULTADO_ACTUAL: |
  `pronto-guard.sh` y `pronto-smoke-api-isolation` no resolvían correctamente rutas del repo o validaban templates legacy inexistentes.

RESULTADO_ESPERADO: |
  Uso de rutas dinámicas basadas en root real del repo y validaciones compatibles con arquitectura SPA.

UBICACION: |
  - `pronto-scripts/bin/maintenance/pronto-guard.sh`
  - `pronto-scripts/bin/pronto-smoke-api-isolation`

ESTADO: RESUELTO

SOLUCION: |
  Se normalizaron rutas dinámicas (`REPO_ROOT`/`SCRIPTS_ROOT`) en `pronto-guard.sh` y se actualizó `pronto-smoke-api-isolation` para SPA: uso de `index.html`, wrapper HTTP canónico real (`pronto-static/src/vue/employees/shared/core/http.ts`), eliminación de paths absolutos locales, corrección de incrementos bajo `set -e` y de capturas HTTP para no abortar por 401 esperados.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
