ID: TEST-20260306-014
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-tests
SEVERIDAD: alta
TITULO: Seed de employee_preferences corre antes de que exista la tabla
DESCRIPCION:
  `40_seeds/0365__employee_preferences.sql` intentaba insertar en una tabla creada recién por
  migración (`pronto_employee_preferences`).
PASOS_REPRODUCIR:
  1. Crear una base vacía.
  2. Ejecutar `pronto-init --apply`.
  3. Observar `relation "pronto_employee_preferences" does not exist`.
RESULTADO_ACTUAL:
  El init canónico fallaba en una base nueva.
RESULTADO_ESPERADO:
  Init no debe depender de tablas creadas en migraciones.
UBICACION:
  - `pronto-scripts/init/sql/40_seeds/0365__employee_preferences.sql`
  - `pronto-scripts/init/sql/migrations/20260216_02__create_tables_phase_2.sql`
ESTADO: RESUELTO
SOLUCION:
  Se volvió no-op seguro el seed cuando la tabla no existe y se añadió
  `20260306_08__backfill_employee_preferences.sql` para poblar las filas base después de crear la tabla.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
