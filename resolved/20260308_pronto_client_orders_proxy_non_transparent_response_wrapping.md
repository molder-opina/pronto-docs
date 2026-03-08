ID: CLI-20260308-014
FECHA: 2026-03-08
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: BFF cliente de órdenes envuelve respuestas upstream con success_response y altera el contrato real
DESCRIPCION:
  El helper `_forward_to_api()` de `pronto-client/routes/api/orders.py` reempaquetaba cualquier respuesta del
  `pronto-api` con `success_response(response.json())`, incluso errores 4xx. Esto alteraba el shape canónico
  del API y ocultaba/transformaba errores de negocio consumibles por el cliente.
PASOS_REPRODUCIR:
  1. Invocar un endpoint de órdenes vía `:6080` que responda error desde `:6082`.
  2. Comparar el JSON de `:6080` contra el de `:6082`.
RESULTADO_ACTUAL:
  El BFF de órdenes no actuaba como proxy técnico transparente.
RESULTADO_ESPERADO:
  Debe retornar status/body/headers del upstream sin reenvolver semántica.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/orders.py`
EVIDENCIA:
  - `_forward_to_api()` hacía `return success_response(response.json()), response.status_code`.
HIPOTESIS_CAUSA:
  Wrapper legado previo a la consolidación del patrón de proxy técnico transparente usado en otros BFF.
ESTADO: RESUELTO
SOLUCION:
  Se convirtió `_forward_to_api()` en passthrough transparente de body/status/headers y se conservaron
  cookies/CSRF/correlation-id en los requests al upstream.
COMMIT: 3cc0011
FECHA_RESOLUCION: 2026-03-08

