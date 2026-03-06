ID: DOCS-20260303-003
FECHA: 2026-03-03
PROYECTO: pronto-docs
SEVERIDAD: baja
TITULO: Acumulación de reportes de sesiones pasadas en la raíz de pronto-docs

DESCRIPCION: |
  La raíz de `pronto-docs` está saturada con archivos `.md` que no son documentación general del proyecto, sino reportes específicos de tareas o features implementadas en el pasado. Estos archivos deberían estar archivados o movidos a carpetas específicas de historia/features.
  
  Archivos detectados en el root que son reportes de sesión:
  - `DEPLOYMENT_STEPS.md` (específico de Feedback)
  - `ACTION_PLAN.md`
  - `IMPLEMENTATION_SUMMARY.md`
  - `MODULARIZATION_SUMMARY.md`
  - `REAUTH_IMPLEMENTATION_COMPLETE.md`
  - `FIXES_APPLIED.md`
  - `ERROR_3_INVESTIGATION.md`

RESULTADO_ACTUAL: |
  Dificulta la visibilidad de los documentos maestros (README, INDEX, etc.) y ensucia el repositorio de documentación con información transitoria.

RESULTADO_ESPERADO: |
  Archivar estos documentos en una carpeta `archive/sessions/` o similar si se desea conservar la historia, o eliminarlos si ya no son relevantes una vez que la feature está en producción.

UBICACION: |
  - `pronto-docs/`

ESTADO: RESUELTO
SOLUCION: Se archivaron reportes de sesión fuera del root en `archive/sessions/` (`DEPLOYMENT_STEPS.md`, `ACTION_PLAN.md`, `IMPLEMENTATION_SUMMARY.md`, `MODULARIZATION_SUMMARY.md`, `REAUTH_IMPLEMENTATION_COMPLETE.md`, `FIXES_APPLIED.md`, `ERROR_3_INVESTIGATION.md`) y se actualizaron referencias en `INDEX.md`.
COMMIT: a11132c
FECHA_RESOLUCION: 2026-03-06

ACCIONES_PENDIENTES:
  - [ ] Mover reportes de implementación a una carpeta de histórico.
  - [ ] Validar si la información útil de esos reportes debe ser integrada en las guías generales (ej. Devolver la lógica de despliegue a una guía de DEPLOYMENT real).
