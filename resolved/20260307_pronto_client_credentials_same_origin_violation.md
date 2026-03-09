ID: CLIENT-20260307-006
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: fetch a /api usa credentials same-origin en vez de include
DESCRIPCION:
  Existían llamadas `fetch('/api/...', { credentials: 'same-origin' })` en templates de cliente,
  contrariando el canon del proyecto que exige `credentials: 'include'` para llamadas a `/api/*`.
PASOS_REPRODUCIR:
  1. Revisar `pronto-client/src/pronto_clients/templates/index.html` y `index-alt.html`.
  2. Ubicar fetch a `/api/business-info` con `credentials: 'same-origin'`.
RESULTADO_ACTUAL:
  Ambas plantillas usan `credentials: 'include'`.
RESULTADO_ESPERADO:
  Todas las llamadas a `/api/*` deben usar `credentials: 'include'`.
UBICACION:
  - `pronto-client/src/pronto_clients/templates/index.html`
  - `pronto-client/src/pronto_clients/templates/index-alt.html`
ESTADO: RESUELTO
SOLUCION:
  Se reemplazó `credentials: 'same-origin'` por `credentials: 'include'` en ambas plantillas legacy.
  Validación: `rg -n "same-origin" pronto-client/src/pronto_clients/templates -g '*.html'` => sin resultados.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
