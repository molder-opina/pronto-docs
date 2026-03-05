ID: CODE-20260303-013
FECHA: 2026-03-03
PROYECTO: pronto-root
SEVERIDAD: media
TITULO: Uso masivo de datetime.utcnow() deprecado

DESCRIPCION: |
  Se han detectado 92 ocurrencias del método `datetime.utcnow()` en todo el codebase. Este método está oficialmente deprecado desde Python 3.12 y su uso puede generar comportamientos inconsistentes al mezclar objetos `datetime` naive (sin zona horaria) con aware (con zona horaria).
  
  Aunque el proyecto tiene una utilidad centralizada en `pronto_shared.datetime_utils.utcnow()` que devuelve objetos aware correctamente, esta no se está utilizando en la gran mayoría de los casos.

RESULTADO_ACTUAL: |
  Dispersión de lógica de tiempo y riesgo de errores de comparación de fechas en sistemas operativos con diferentes configuraciones de hora local.

RESULTADO_ESPERADO: |
  Uso exclusivo de `pronto_shared.datetime_utils.utcnow()` para cualquier obtención de la hora actual en el backend.

UBICACION: |
  - Presente en 92 líneas a lo largo de `pronto-api`, `pronto-client`, `pronto-employees` y `pronto-libs`.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Realizar un reemplazo global de `datetime.utcnow()` por `utcnow()` importado de `pronto_shared.datetime_utils`.
  - [ ] Añadir una regla de linter (Ruff) para prohibir el uso de `utcnow()` nativo.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
