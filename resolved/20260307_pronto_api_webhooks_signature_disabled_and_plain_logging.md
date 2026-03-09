ID: API-20260307-008
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: webhooks procesa eventos sin verificar firma y usa print en manejo de errores
DESCRIPCION:
  El webhook de Facturapi tenía la verificación de firma comentada y procesaba payloads directos.
  En error usaba `print(...)` en lugar de logger estructurado, incumpliendo trazabilidad.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/webhooks.py`.
  2. Revisar bloque de verificación de firma comentado.
  3. Revisar manejo de excepción con `print`.
RESULTADO_ACTUAL:
  El webhook valida `X-Facturapi-Signature` cuando existe `FACTURAPI_WEBHOOK_SECRET`, registra rechazo con logger estructurado y oculta el detalle interno del error en la respuesta.
RESULTADO_ESPERADO:
  Verificar firma en producción y registrar con logger estructurado/correlation id.
UBICACION:
  - pronto-api/src/api_app/routes/webhooks.py
  - pronto-api/tests/test_webhooks_security_regressions.py
EVIDENCIA:
  - `logger.warning(... action="facturapi_webhook" ...)`
  - `logger.exception(... action="facturapi_webhook" ...)`
  - `pytest pronto-api/tests/test_webhooks_security_regressions.py -q` => `3 passed`
HIPOTESIS_CAUSA:
  Código temporal de integración dejado en estado de prueba.
ESTADO: RESUELTO
SOLUCION:
  Se reactivó la validación de firma condicionada por secreto, se reemplazó `print` por `get_logger(__name__)`, se endureció el parseo JSON y se agregaron pruebas de regresión del webhook.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07