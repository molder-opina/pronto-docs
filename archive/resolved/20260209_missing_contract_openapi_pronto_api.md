---
ID: BUG-MISSING-CONTRACT-OPENAPI-003
FECHA: 2026-02-09
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: OpenAPI de pronto-api solo tiene endpoint /health
DESCRIPCION: El contrato OpenAPI en pronto-docs/contracts/pronto-api/openapi.yaml contiene únicamente el endpoint de health check. El archivo tiene solo 18 líneas y no documenta ninguno de los ~50+ endpoints que implementa la API (orders, menu, tables, employees, customers, payments, etc.). Esto viola el estándar de contratos públicos del proyecto que requiere documentar todos los endpoints expuestos.
PASOS_REPRODUCIR: 1. Ir a pronto-docs/contracts/pronto-api/openapi.yaml 2. Verificar que solo tiene /health
RESULTADO_ACTUAL: OpenAPI solo con health check
RESULTADO_ESPERADO: OpenAPI con todos los endpoints documentados (orders, menu, tables, sessions, customers, payments, etc.)
UBICACION: pronto-docs/contracts/pronto-api/openapi.yaml
EVIDENCIA: Archivo revisado en auditoría técnica - solo 18 líneas con health check
HIPOTESIS_CAUSA: El equipo priorizó implementar funcionalidad sobre documentación de API, o generó el archivo automáticamente al inicio del proyecto y nunca lo actualizó
ESTADO: RESUELTO
