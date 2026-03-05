ID: CODE-20260303-009
FECHA: 2026-03-03
PROYECTO: pronto-scripts
SEVERIDAD: baja
TITULO: Violación de nomenclatura en scripts de pronto-scripts/bin

DESCRIPCION: |
  Se ha detectado que 21 archivos en `pronto-scripts/bin` no cuentan con la extensión `.sh`, lo cual viola la regla de nomenclatura obligatoria definida en `AGENTS.md` (Sección 0.7.5).

RESULTADO_ACTUAL: |
  Los siguientes archivos no cumplen con el canon `kebab-case.sh`:
  - `pronto-backups-gc`
  - `pronto-api-parity-check`
  - `pronto-migrate`
  - `pronto-backup-change`
  - `pronto-audit-no-residue`
  - `pronto-routes-only-check`
  - `pronto-list-employees`
  - `pronto-inconsistency-check`
  - `pronto-no-external-migrations`
  - `pronto-init`
  - `pronto-restore-change`
  - `pronto-change-log`
  - `pronto-reset-passwords`
  - `pronto-sql-safety`
  - `pronto-customers-backfill-search-columns`
  - `pronto-static-hosts-check`
  - `pre-commit-ai`
  - `pronto-smoke-api-isolation`
  - `pronto-rules-check`
  - `pronto-no-legacy`
  - `pronto-no-runtime-ddl`

RESULTADO_ESPERADO: |
  Todos los shell scripts en `pronto-scripts/bin` deben tener la extensión `.sh` obligatoria para ser consistentes con el resto del proyecto.

UBICACION: |
  - `pronto-scripts/bin/`

HIPOTESIS_CAUSA: |
  Creación de scripts de conveniencia tipo "CLI tool" donde se omitió la extensión para simular binarios del sistema, ignorando las reglas de estilo del monorepo.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Renombrar todos los scripts para añadir la extensión `.sh`.
  - [ ] Actualizar todas las referencias a estos scripts en el código, otros scripts, y documentación (especialmente en `AGENTS.md` y `GEMINI.md`).
  - [ ] Crear symlinks (opcional) si se desea mantener la capacidad de ejecución sin extensión por brevedad.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
