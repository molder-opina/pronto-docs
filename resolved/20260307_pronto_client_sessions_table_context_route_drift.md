ID: CLI-20260307-008
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: proxy cliente de table-context apunta a una ruta inexistente en el backend
DESCRIPCION:
  El BFF de sesiones reenviaba `table-context` a un path upstream inexistente.
PASOS_REPRODUCIR:
  1. Registrar cliente vía `:6080`.
  2. Ejecutar `POST /api/sessions/table-context`.
  3. Observar 404.
RESULTADO_ACTUAL:
  El wrapper cliente mapeaba `table-context` a la ruta equivocada.
RESULTADO_ESPERADO:
  Debía usar el endpoint canónico actual del API.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/sessions.py`
EVIDENCIA:
  - 404 live durante el e2e del cliente
HIPOTESIS_CAUSA:
  Drift de rutas en sesiones/contexto de mesa.
ESTADO: RESUELTO
SOLUCION:
  Se corrigió el mapping upstream a `/api/sessions/table-context` y se validó en live.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

