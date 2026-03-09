ID: TEST-20260306-020
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: test_menu_validation_api usa fixture removida admin_token y contrato viejo
DESCRIPCION:
  Las suites duplicadas de validación de menú dependían de `admin_token` y de expectativas legacy.
ESTADO: RESUELTO
SOLUCION:
  Se reescribieron las suites duplicadas a casos cortos alineados al contrato vigente de
  `/api/menu-items`, usando `authenticated_client` y payloads canónicos con UUIDs.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
