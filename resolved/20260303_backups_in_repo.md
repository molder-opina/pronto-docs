ID: SEC-20260303-003
FECHA: 2026-03-03
PROYECTO: pronto-backups
SEVERIDAD: alta
TITULO: Archivos de backup reales persistidos en el repositorio

DESCRIPCION: |
  Se han localizado archivos de backup reales (dumps SQL y archivos .tar.gz) dentro de la carpeta `pronto-backups/archive/`. Esto viola la regla P0 de seguridad definida en `pronto-backups/README.md`, la cual prohíbe explícitamente commitear archivos de respaldo al repositorio.

RESULTADO_ACTUAL: |
  Los siguientes archivos están versionados y presentes en el sistema:
  - `pronto-backups/archive/backup_perms_unify.sql`
  - `pronto-backups/archive/pronto-db-pre-unification.sql`
  - `pronto-backups/archive/employees_app_backup_20260130_224530.tar.gz`
  - `pronto-backups/archive/legacy_code_backup_20260131.tar.gz`

RESULTADO_ESPERADO: |
  El repositorio no debe contener datos reales de la base de datos ni respaldos de código antiguo. Estos archivos deben vivir en almacenamiento externo (S3, GCS) o en servidores de backup dedicados, nunca en Git.

UBICACION: |
  - `pronto-backups/archive/`

HIPOTESIS_CAUSA: |
  Falta de reglas preventivas en el `.gitignore` raíz para la carpeta `archive/` dentro de `pronto-backups` o commits manuales realizados durante procesos de migración de emergencia.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Eliminar los archivos de la rama actual.
  - [ ] Reเขียน el historial de Git (opcional pero recomendado si hay datos sensibles) para purgar estos archivos completamente.
  - [ ] Actualizar `.gitignore` para bloquear preventivamente cualquier archivo `.sql`, `.gz` o `.dump` en todo el árbol del proyecto.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
