ID: TEST-20260306-035
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: media
TITULO: serialize_order no cae a session.customer cuando order.customer no está seteado
DESCRIPCION:
  `serialize_order()` perdía el customer cuando éste solo estaba presente vía `order.session.customer`.
ESTADO: RESUELTO
SOLUCION:
  Se añadió fallback a `order.session.customer`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
