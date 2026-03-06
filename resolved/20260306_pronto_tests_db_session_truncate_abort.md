ID: TEST-20260306-002
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: db_session aborta transacción al truncar tablas ausentes y contamina tests
DESCRIPCION:
  El fixture `db_session` intentaba truncar todas las tablas de `Base.metadata.sorted_tables`, incluso
  tablas que no existían en la base usada por los tests. En PostgreSQL, el primer `TRUNCATE` fallido
  abortaba toda la transacción y dejaba estado residual entre casos.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/integration/test_jwt_refresh.py -q`.
  2. Observar en setup: `Error truncating tables: ... InFailedSqlTransaction ...`.
  3. Ver que tests posteriores heredan estado del empleado modificado por casos previos.
RESULTADO_ACTUAL:
  La limpieza de BD por test no era confiable y la suite quedaba order-dependent.
RESULTADO_ESPERADO:
  El fixture debe truncar únicamente tablas existentes para dejar una base limpia por caso de prueba.
UBICACION:
  - `pronto-tests/conftest.py`
EVIDENCIA:
  - Logs repetidos de `current transaction is aborted`
  - Casos de login posteriores fallaban con `401` tras tests que desactivaban o eliminaban al empleado
HIPOTESIS_CAUSA:
  El fixture mezclaba metadata teórica con esquema real y no aislaba los errores de truncado por tabla.
ESTADO: RESUELTO
SOLUCION:
  Se actualizó `db_session` para consultar el catálogo real con `inspect(test_db_engine).get_table_names()`
  y truncar solo tablas presentes, evitando abortar la transacción global.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06