---
ID: ERR-20260203-004
FECHA: 2026-02-03
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Código JavaScript visible en página
DESCRIPCION: Código JavaScript en base.html:3381-3402 estaba fuera de tag script y se renderizaba como texto visible.
PASOS_REPRODUCIR:
1) Abrir cualquier página del cliente
2) Ver código fuente o inspector
3) Observar texto de scripts visible en DOM
RESULTADO_ACTUAL: Scripts visibles como texto en la página
RESULTADO_ESPERADO: Scripts ejecutados y no visibles
UBICACION: pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Código después de línea 3380 visible en DOM
HIPOTESIS_CAUSA: Código copiado sin tag <script> de apertura
ESTADO: RESUELTO
---
SOLUCION:
Agregado tag <script> de apertura antes del código JavaScript.
Código re-indentado para mejor legibilidad.

COMMIT: <commit_hash>
FECHA_RESOLUCION: 2026-02-03
---
