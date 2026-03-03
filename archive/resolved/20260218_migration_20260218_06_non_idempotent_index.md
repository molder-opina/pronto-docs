ID: ERR-20260218-MIGR-20260218-06-NONIDEMPOTENT-INDEX
FECHA: 2026-02-18
PROYECTO: pronto-scripts
SEVERIDAD: alta
TITULO: Migración 20260218_06 falla por CREATE INDEX no idempotente
DESCRIPCION: El contenedor `pronto-client-1` quedó unhealthy porque el precheck detectó migraciones pendientes y, al aplicar `pronto-migrate --apply`, la migración `20260218_06__add_payments_table.sql` falló al intentar crear `ix_pronto_payments_session_id` que ya existía.
PASOS_REPRODUCIR:
1. Ejecutar `DATABASE_URL=... ./pronto-scripts/bin/pronto-migrate --apply`.
2. Observar ejecución de `20260218_06__add_payments_table.sql`.
3. Ver error por índice ya existente.
RESULTADO_ACTUAL: `pronto-migrate` falla en esa migración, dejando el sistema con chequeos fallidos de esquema hasta corregir la idempotencia.
RESULTADO_ESPERADO: La migración debe ser idempotente y permitir re-ejecución sin error cuando el índice ya existe.
UBICACION: pronto-scripts/init/sql/migrations/20260218_06__add_payments_table.sql
EVIDENCIA: Salida de migración con error de índice existente y recuperación posterior con `CREATE INDEX IF NOT EXISTS` + `pending=0 drift=0` y `pronto-init --check` OK.
HIPOTESIS_CAUSA: Definición original de índice sin cláusula `IF NOT EXISTS` en un entorno donde el índice ya fue creado por ejecución previa/parcial.
ESTADO: RESUELTO
SOLUCION: Se cambió la sentencia a `CREATE INDEX IF NOT EXISTS ix_pronto_payments_session_id ON pronto_payments(session_id);` en `20260218_06__add_payments_table.sql`, luego se ejecutó `pronto-migrate --apply` y `pronto-init --check` con resultado exitoso.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-18
