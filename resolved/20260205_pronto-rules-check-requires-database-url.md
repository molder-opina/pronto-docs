---
ID: ERR-20260205-PRONTO-RULES-CHECK-REQUIRES-DB
FECHA: 2026-02-05
PROYECTO: pronto-scripts
SEVERIDAD: alta
TITULO: pronto-rules-check falla si DATABASE_URL no esta definido
DESCRIPCION: El gate pronto-rules-check ejecuta pronto-migrate --check y pronto-init --check con needs_db=True y falla cuando DATABASE_URL no esta definido. Esto bloquea validaciones locales/CI sin DB.
PASOS_REPRODUCIR: 1) Asegurar DATABASE_URL vacio. 2) Ejecutar ./pronto-scripts/bin/pronto-rules-check.
RESULTADO_ACTUAL: ERROR: DATABASE_URL required for pronto-migrate.
RESULTADO_ESPERADO: El gate debe poder correr sin DB usando --dry-run (deny/safety checks) y usar --check solo cuando DATABASE_URL existe.
UBICACION: pronto-scripts/bin/pronto-rules-check:218-223; pronto-scripts/bin/pronto-migrate; pronto-scripts/bin/pronto-init
EVIDENCIA: check_migrate_check/_run_gate exige DATABASE_URL para pronto-migrate --check.
HIPOTESIS_CAUSA: Gate implementado con modo --check obligatorio en lugar de fallback a --dry-run.
ESTADO: RESUELTO
---

SOLUCION: pronto-rules-check ahora ejecuta pronto-migrate/pronto-init con --dry-run cuando DATABASE_URL no esta definido y usa --check solo cuando existe.
COMMIT: c8b8f6d
FECHA_RESOLUCION: 2026-02-05
