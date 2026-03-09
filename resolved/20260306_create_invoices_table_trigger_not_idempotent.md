ID: TEST-20260306-039
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-tests
SEVERIDAD: alta
TITULO: 20260306_06__create_invoices_table.sql falla al reintentar por trigger existente
DESCRIPCION:
  La migración de invoices creaba `trigger_invoices_updated_at` sin guardia de idempotencia.
ESTADO: RESUELTO
SOLUCION:
  Se reemplazó `CREATE TRIGGER` directo por un bloque `DO $$ ... IF NOT EXISTS ... THEN CREATE TRIGGER`
  para permitir reejecución segura; luego `pronto-migrate --apply` completó correctamente.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
