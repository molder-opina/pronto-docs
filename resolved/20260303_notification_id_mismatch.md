ID: DATA-20260303-003
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: critica
TITULO: Inconsistencia de tipo en Notification.recipient_id (Integer vs UUID)

DESCRIPCION: |
  El modelo `Notification` en `models.py` define la columna `recipient_id` como tipo `Integer`. Sin embargo, los modelos de destinatarios referenciados por `recipient_type` (`Employee` y `Customer`) utilizan `UUID` como su clave primaria (`id`). 
  
  Esto provocará fallos catastróficos (DataError) al intentar persistir notificaciones dirigidas a usuarios específicos, ya que un UUID no puede ser almacenado en una columna de tipo Integer.

RESULTADO_ACTUAL: |
  L1192 de `models.py`: `recipient_id: Mapped[int | None] = mapped_column(Integer, nullable=True)`
  Esto es incompatible con los IDs de `Employee` y `Customer`.

RESULTADO_ESPERADO: |
  La columna `recipient_id` debe ser de tipo `UUID` (o una cadena de longitud suficiente) para soportar las claves primarias del sistema. Dado que el sistema usa UUIDs de forma generalizada para usuarios, esta columna debe reflejar ese estándar.

UBICACION: |
  - `pronto-libs/src/pronto_shared/models.py`

HIPOTESIS_CAUSA: |
  El modelo `Notification` fue probablemente diseñado en una fase temprana del proyecto cuando los IDs eran secuenciales (Integer), y no se actualizó cuando el sistema migró a UUIDs para empleados y clientes.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Cambiar el tipo de `recipient_id` a `UUID(as_uuid=True)` en `models.py`.
  - [ ] Generar una migración SQL para alterar la columna en la base de datos PostgreSQL.
  - [ ] Auditar el código que inserta notificaciones para asegurar que pasan objetos UUID correctamente.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
