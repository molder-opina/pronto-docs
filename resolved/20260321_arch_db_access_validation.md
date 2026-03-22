ID: 20260321-ARCH-001
FECHA: 2026-03-21
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: Architecture Gate: pronto-client direct DB access validation
DESCRIPCION: Validar que pronto-client NO tiene acceso directo a base de datos. Cliente debe ser API consumer puro siguiendo el patrón BFF proxy a pronto-api.
PASOS_REPRODUCIR:
  1. Ejecutar: ./pronto-scripts/bin/pronto-client-no-db-check
  2. Ejecutar: ./pronto-scripts/bin/pronto-client-runtime-db-test
  3. Ejecutar: pytest pronto-tests/architecture/test_no_db_access.py
RESULTADO_ACTUAL: Arquitectura validada - pronto-client NO tiene acceso directo a DB
RESULTADO_ESPERADO: 0 violaciones de acceso directo a DB en pronto-client
UBICACION:
  - pronto-client/src/pronto_clients/app.py
  - pronto-client/src/pronto_clients/routes/web.py
  - pronto-client/src/pronto_clients/routes/api/sessions.py
  - pronto-scripts/bin/pronto-client-no-db-check
  - pronto-scripts/bin/pronto-client-runtime-db-test
  - pronto-tests/architecture/test_no_db_access.py
EVIDENCIA:
  - Scripts ejecutados exitosamente con STATUS: APPROVED
  - Tests unitarios pasando (2/2)
  - No imports de pronto_shared.db en pronto-client
  - No uso de get_session() en pronto-client
HIPOTESIS_CAUSA: Arquitectura correcta - pronto-client sigue patrón BFF proxy
ESTADO: RESUELTO
SOLUCION: Validación completada exitosamente. pronto-client NO tiene acceso directo a DB.
COMMIT: pending
FECHA_RESOLUCION: 2026-03-21
