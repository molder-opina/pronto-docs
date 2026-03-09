ID: TEST-20260306-023
FECHA: 2026-03-06
PROYECTO: pronto-api,pronto-libs,pronto-tests
SEVERIDAD: alta
TITULO: /api/business-info rompe cuando BusinessInfoService devuelve data nula
DESCRIPCION:
  La ruta asumía que `business_info_response["data"]` siempre era dict.
ESTADO: RESUELTO
SOLUCION:
  Se normalizó `None` a `{}` antes de construir la respuesta pública de `/api/business-info`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
