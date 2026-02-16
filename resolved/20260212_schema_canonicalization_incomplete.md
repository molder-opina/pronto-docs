ID: 20260212_schema_canonicalization_incomplete
FECHA: 2026-02-12
PROYECTO: pronto-scripts, pronto-libs, pronto-client, pronto-employees
SEVERIDAD: bloqueante
TITULO: Schema canónico incompleto impide validación strict y arranque sin bypass
DESCRIPCION: El init/migrate canónico no converge a estado válido porque faltan tablas base en init y hay seeds que violaban deny-rules de pronto-init.
PASOS_REPRODUCIR: Ejecutar ./pronto-scripts/bin/pronto-init --apply y ./pronto-scripts/bin/pronto-init --check en DB limpia.
RESULTADO_ACTUAL: pronto-init --apply fallaba en fase 40_seeds por deny-check y pronto-init --check reportaba pending/drift en migraciones.
RESULTADO_ESPERADO: init+migrate aplican sin errores, pending=0, drift=0 y schema check OK sin bypass.
UBICACION: pronto-scripts/init/sql/**, pronto-scripts/init/manifest.yml, pronto-libs/src/pronto_shared/db.py
EVIDENCIA: Reportes de check con pending=25 y luego drift=4 en runtime.
HIPOTESIS_CAUSA: Separación Init/Migrations no estaba completa y seeds legacy contenían operaciones bloqueadas.
ESTADO: RESUELTO
SOLUCION: Se agregó bootstrap de extensión, schema base canónico en 10_schema, seeds idempotentes compatibles con deny-check, y migraciones ajustadas para safety/idempotencia; se aplicó init+migrate+check con resultado OK, y se desactivó bypass en entorno.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-12
