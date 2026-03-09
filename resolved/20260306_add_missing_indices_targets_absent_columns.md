ID: TEST-20260306-017
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-tests
SEVERIDAD: alta
TITULO: Migración add_missing_indices apunta a columnas y tablas inexistentes
DESCRIPCION:
  `20260218_01__add_missing_indices.sql` intentaba crear índices sobre varios targets ausentes.
PASOS_REPRODUCIR:
  1. Ejecutar `pronto-migrate --apply` sobre una base nueva.
  2. Observar errores en índices como `pronto_business_info.updated_by`.
RESULTADO_ACTUAL:
  La migración canónica fallaba al primer índice inválido.
RESULTADO_ESPERADO:
  Los índices deben crearse solo si la tabla/columna existen realmente.
UBICACION:
  - `pronto-scripts/init/sql/migrations/20260218_01__add_missing_indices.sql`
ESTADO: RESUELTO
SOLUCION:
  Se convirtió la migración a un bloque condicional que verifica existencia real de tabla/columna
  antes de emitir cada `CREATE INDEX IF NOT EXISTS`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
