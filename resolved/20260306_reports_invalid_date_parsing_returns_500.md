ID: TEST-20260306-031
FECHA: 2026-03-06
PROYECTO: pronto-api,pronto-tests
SEVERIDAD: media
TITULO: /api/reports/* devuelve 500 cuando start/end no son ISO válidos
DESCRIPCION:
  `_parse_date_range()` dejaba escapar `ValueError` y convertía query params inválidos en 500.
ESTADO: RESUELTO
SOLUCION:
  Se endureció el parseo con fallback seguro para fechas inválidas.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
