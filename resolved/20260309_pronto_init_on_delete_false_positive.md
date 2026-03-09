ID: INIT-20260309-001
FECHA: 2026-03-09
PROYECTO: pronto-scripts
SEVERIDAD: alta
TITULO: pronto-init confunde ON DELETE/ON UPDATE de FKs con DML prohibido en init
DESCRIPCION:
  `pronto-scripts/bin/pronto-init` trataba `ON DELETE` y potencialmente `ON UPDATE`
  como si fueran DML prohibido por usar un regex demasiado amplio (`DELETE\b|UPDATE\b`).
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-scripts/bin/pronto-rules-check` desde el root sin `DATABASE_URL`.
  2. Observar el bloqueo previo por `pronto-init failed` sobre `0110__core_tables.sql`.
RESULTADO_ACTUAL:
  El deny check permite cláusulas FK válidas (`ON DELETE`, `ON UPDATE`) y sigue bloqueando DML real en init.
RESULTADO_ESPERADO:
  `pronto-init` debe distinguir acciones referenciales del schema frente a DML prohibido.
UBICACION:
  - pronto-scripts/bin/pronto-init
  - pronto-scripts/init/sql/10_schema/0110__core_tables.sql
EVIDENCIA:
  - `bash -n pronto-scripts/bin/pronto-init` => OK
  - `./pronto-scripts/bin/pronto-init --dry-run` => `OK dry-run (deny checks passed).`
  - `./pronto-scripts/bin/pronto-rules-check` => `OK`
  - `./pronto-scripts/bin/pronto-init --check` => no ejecutable en este entorno por `DATABASE_URL requerido`
HIPOTESIS_CAUSA:
  El regex del deny check quedó demasiado amplio y no diferenciaba `DELETE FROM` / `UPDATE <tabla>` de `ON DELETE` / `ON UPDATE`.
ESTADO: RESUELTO
SOLUCION:
  Se refinó el patrón del deny check para bloquear DML real (`DELETE FROM`, `UPDATE <tabla>`) y permitir cláusulas referenciales válidas. La validación transversal confirmó recurrencia del patrón en `ON DELETE` de init/migrations, y el guardrail volvió a pasar con `--dry-run` y `pronto-rules-check` completo.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09