ID: TEST-20260306-037
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-api,pronto-tests
SEVERIDAD: alta
TITULO: FeedbackQuestion exportado desde business_models está desalineado del schema real
DESCRIPCION:
  `pronto_shared.models` exportaba una clase `FeedbackQuestion` vieja e incompatible con la tabla real.
ESTADO: RESUELTO
SOLUCION:
  Se alineó `business_models.py` con el schema vigente y se agregaron pruebas locales de regresión
  para `/api/feedback/questions` en ambos árboles funcionales.
COMMIT: 1eba18d
FECHA_RESOLUCION: 2026-03-06
