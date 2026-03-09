ID: TEST-20260306-034
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: media
TITULO: serialize_customer deja phone sin máscara cuando el email anónimo empieza con anonimo+
DESCRIPCION:
  El serializer ocultaba el email anónimo pero dejaba el teléfono en claro.
ESTADO: RESUELTO
SOLUCION:
  Ahora `serialize_customer()` sigue aplicando `mask_phone()` aunque el email se oculte por anonimato.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
