ID: 20260304_pronto_client_sessions_shortcuts_business_logic_moved_to_api
FECHA: 2026-03-04
PROYECTO: pronto-client, pronto-api, pronto-libs, pronto-tests
SEVERIDAD: alta
TITULO: pronto-client mantenía lógica de negocio en sessions/table-context y shortcuts
DESCRIPCION:
Como parte del issue paraguas `20260304_business_logic_embedded_in_pronto_client_and_pronto_employees_api`, se detectó que `pronto-client` todavía resolvía contexto de mesa, validaba conflicto de sesión/mesa activa y consultaba atajos/preguntas de feedback directamente desde rutas SSR `/api/*`.
PASOS_REPRODUCIR:
1. Revisar `pronto-client/src/pronto_clients/routes/api/sessions.py`.
2. Revisar `pronto-client/src/pronto_clients/routes/api/shortcuts.py`.
3. Verificar que `table_context.py` vive bajo `pronto-client/src/pronto_clients/routes/api/`.
4. Confirmar que `GET /api/shortcuts`, `POST /api/feedback/questions` y `POST /api/sessions/table-context` ejecutan lógica local en `6080`.
RESULTADO_ACTUAL:
`pronto-client` concentraba reglas de dominio y acceso a datos en endpoints SSR que debían vivir en `pronto-api` y `pronto-libs`.
RESULTADO_ESPERADO:
`pronto-client` debe limitarse a proxy técnico/transporte, mientras `pronto-api` y `pronto-libs` concentran la lógica canónica de negocio y acceso a datos.
UBICACION:
- pronto-client/src/pronto_clients/routes/api/sessions.py
- pronto-client/src/pronto_clients/routes/api/shortcuts.py
- pronto-client/src/pronto_clients/routes/api/table_context.py
- pronto-api/src/api_app/routes/client_sessions.py
- pronto-api/src/api_app/routes/menu.py
- pronto-libs/src/pronto_shared/services/table_context_service.py
EVIDENCIA:
- `GET /api/shortcuts` y `POST /api/feedback/questions` ahora se resuelven en `pronto-api`.
- `POST /api/sessions/table-context` valida `TABLE_LOCATION_MISMATCH` desde `pronto-api` usando `dining_session_id` transportado técnicamente desde el SSR.
- La prueba live `test_client_api_business_logic_moved_to_api.py` pasa (`1 passed`).
HIPOTESIS_CAUSA:
La migración arquitectónica hacia `pronto-api` quedó incompleta y varios endpoints cliente siguieron evolucionando dentro del SSR por conveniencia.
ESTADO: RESUELTO
SOLUCION:
Se movió la lógica de contexto de mesa a `pronto-libs` (`table_context_service.py`), se implementaron rutas canónicas en `pronto-api` para `table-context`, `shortcuts` y `feedback/questions`, y `pronto-client` quedó reducido a proxy técnico que solo transporta `customer_ref` y `dining_session_id` permitidos.
COMMIT:
- pronto-libs: 85a5e58
- pronto-api: f8fa002
- pronto-client: 7021822
- pronto-tests: b003c5a
- pronto-scripts: b3dd475
- pronto-docs: 8c487f9
FECHA_RESOLUCION: 2026-03-04
