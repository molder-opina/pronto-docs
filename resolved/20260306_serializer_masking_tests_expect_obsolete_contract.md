ID: TEST-20260306-033
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: unit tests de masking esperan contrato viejo de mask_email y mask_phone
DESCRIPCION:
  Los tests de masking/serializers validaban formatos viejos ya no alineados con la implementación.
ESTADO: RESUELTO
SOLUCION:
  Se actualizaron las expectativas al contrato vigente de `mask_email()` y `mask_phone()`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
