ID: TEST-20260306-032
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: media
TITULO: serialize_order asume created_at no nulo y rompe serialización fallback
DESCRIPCION:
  `serialize_order()` llamaba `.isoformat()` sin tolerar `created_at=None`.
ESTADO: RESUELTO
SOLUCION:
  Se normalizó `created_at` y `session.opened_at` para devolver `None` cuando falta el dato.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
