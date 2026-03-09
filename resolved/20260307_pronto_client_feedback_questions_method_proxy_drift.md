ID: CLI-20260307-006
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: proxy cliente de /api/feedback/questions usa método upstream incorrecto
DESCRIPCION:
  El BFF exponía `feedback/questions` con método local incorrecto respecto al contrato actual del backend.
PASOS_REPRODUCIR:
  1. Invocar la ruta cliente de feedback.
  2. Observar 405/flujo roto hacia upstream.
RESULTADO_ACTUAL:
  El proxy fallaba por mismatch de método.
RESULTADO_ESPERADO:
  El BFF debía alinearse con el método canónico protegido por CSRF.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/feedback_email.py`
EVIDENCIA:
  - backend actual expone `POST /api/feedback/questions`
HIPOTESIS_CAUSA:
  Drift del wrapper cliente frente al backend.
ESTADO: RESUELTO
SOLUCION:
  Se alineó el proxy cliente y el e2e al flujo `POST` con CSRF hacia `feedback/questions`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

