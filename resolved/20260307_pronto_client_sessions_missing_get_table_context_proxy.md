ID: CLI-20260307-009
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: BFF cliente no expone GET /api/sessions/table-context
DESCRIPCION:
  El backend canónico soporta GET y POST para `table-context`, pero el BFF cliente solo exponía POST.
PASOS_REPRODUCIR:
  1. Revisar `pronto-client/src/pronto_clients/routes/api/sessions.py`.
  2. Intentar `GET /api/sessions/table-context` vía `:6080`.
RESULTADO_ACTUAL:
  El BFF no ofrecía el GET equivalente.
RESULTADO_ESPERADO:
  Debía proxyear también el GET al backend.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/sessions.py`
EVIDENCIA:
  - backend actual expone `/api/sessions/table-context` para GET y POST
HIPOTESIS_CAUSA:
  Implementación incompleta del wrapper cliente.
ESTADO: RESUELTO
SOLUCION:
  Se agregó `GET /api/sessions/table-context` al proxy de sesiones y se validó con el e2e live.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

