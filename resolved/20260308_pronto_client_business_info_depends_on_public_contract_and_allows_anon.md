ID: CLIENT-20260308-BUSINESS-INFO-PUBLIC-DRIFT
FECHA: 2026-03-08
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: business_info del cliente depende de /api/public/* y home seguia accesible sin sesion
DESCRIPCION: `pronto-client/src/pronto_clients/routes/api/business_info.py` seguía llamando a `/api/public/business-info` y `/api/public/schedule`, contrato que ya no es válido por guardrail de autenticación. Además `pronto-client/src/pronto_clients/routes/web.py` todavía renderizaba `home()` sin exigir sesión cliente, contradiciendo el cierre previo del bug de rutas públicas.
PASOS_REPRODUCIR:
1. Revisar `pronto-client/src/pronto_clients/routes/api/business_info.py`.
2. Verificar referencias a `/api/public/business-info` y `/api/public/schedule`.
3. Revisar `pronto-client/src/pronto_clients/routes/web.py` y notar que `home()` usaba `_get_current_customer()` sin enforcement.
RESULTADO_ACTUAL: `home()` y `GET /api/business-info` ya exigen sesión cliente válida; el BFF dejó de depender de `/api/public/*`.
RESULTADO_ESPERADO: `home()` y `GET /api/business-info` deben exigir sesión cliente válida; el BFF no debe depender de `/api/public/*`.
UBICACION:
- pronto-client/src/pronto_clients/routes/api/business_info.py
- pronto-client/src/pronto_clients/routes/web.py
- pronto-client/tests/test_web_auth_regressions.py
- pronto-client/tests/test_business_info_api.py
EVIDENCIA: `tests/test_web_auth_regressions.py` y `tests/test_business_info_api.py` pasan con redirect de `/` para anónimos, 401 en `/api/business-info` sin sesión y payload correcto con sesión autenticada.
HIPOTESIS_CAUSA: Reapertura parcial tras una corrección previa que no quedó consolidada por commit en el árbol actual.
ESTADO: RESUELTO
SOLUCION: Se endureció `home()` con `_require_customer_web_auth()`, se reescribió `GET /api/business-info` para validar `session['customer_ref']` y leer `BusinessInfoService`/`BusinessScheduleService` canónicos en lugar de depender de `/api/public/*`, y se ajustó la nota stale de `stripe_webhooks.py` para no asumir un webhook público inexistente en `pronto-api`.
COMMIT: b976433
FECHA_RESOLUCION: 2026-03-08

