ID: DOCS-20260303-002
FECHA: 2026-03-03
PROYECTO: pronto-docs
SEVERIDAD: media
TITULO: Estructura de directorios inconsistente y duplicada en pronto-docs

DESCRIPCION: |
  Se ha detectado un desorden significativo en la jerarquía de carpetas de `pronto-docs`. Existen múltiples carpetas con el mismo propósito pero nombres en diferentes idiomas (English/Spanish), y muchas de las carpetas listadas en el `INDEX.md` están vacías en la realidad.
  
  Carpetas duplicadas/vacías:
  - `contracts/` (con contenido) vs `contratos/` (vacía).
  - `plans/` (con contenido) vs `planes/` (vacía).
  - `security/` (con contenido) vs `seguridad/` (vacía).
  - `infraestructura/`, `funcionalidad/`, `proyecto/`, `estructura/`, `modulos/`, `testing/` (todas vacías o casi vacías).

RESULTADO_ACTUAL: |
  La documentación está dispersa entre la raíz de `pronto-docs` y carpetas en inglés, mientras que el índice oficial (`INDEX.md`) apunta a carpetas en español que están vacías. Esto genera confusión total para cualquier desarrollador que intente encontrar información.

RESULTADO_ESPERADO: |
  Estandarizar una única jerarquía de directorios (se recomienda seguir el plan de `INDEX.md` pero moviendo los archivos reales allí). Eliminar las carpetas vacías y duplicadas.

UBICACION: |
  - `pronto-docs/`

ESTADO: ABIERTO

ACCIONES_PENDIENTES:
  - [ ] Consolidar todos los archivos de `contracts/` hacia `contratos/` (o viceversa).
  - [ ] Consolidar todos los archivos de `plans/` hacia `planes/` (o viceversa).
  - [ ] Mover los archivos del root hacia sus subcarpetas correspondientes según el índice.
  - [ ] Eliminar carpetas redundantes tras la migración.
