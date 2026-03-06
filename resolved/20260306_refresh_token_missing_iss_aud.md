ID: AUTH-20260306-002
FECHA: 2026-03-06
PROYECTO: pronto-libs, pronto-api, pronto-tests
SEVERIDAD: alta
TITULO: Refresh tokens se emiten sin iss/aud y decode_token los rechaza
DESCRIPCION:
  `create_refresh_token()` generaba payloads sin `iss` ni `aud`, pero `decode_token()` exige ambos
  claims para cualquier JWT. Como consecuencia, el flujo de refresh fallaba al intentar decodificar
  refresh tokens válidos y respondía token inválido.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/integration/test_jwt_refresh.py -q`.
  2. Observar errores de refresh y, en unit tests, `Missing required claim: Token is missing the "iss" claim`.
RESULTADO_ACTUAL:
  Los refresh tokens emitidos por `create_refresh_token()` no pasaban validación de `decode_token()`.
RESULTADO_ESPERADO:
  Los refresh tokens deben incluir los claims requeridos por el validador compartido (`iss`, `aud`).
UBICACION:
  - `pronto-libs/src/pronto_shared/jwt_service.py`
EVIDENCIA:
  - `pronto-libs/tests/unit/test_jwt_service.py`
  - `pronto-tests/tests/functionality/integration/test_jwt_refresh.py`
HIPOTESIS_CAUSA:
  El helper de refresh conservó una versión previa del payload mientras el decodificador se endureció
  para exigir issuer y audience en todos los tokens.
ESTADO: RESUELTO
SOLUCION:
  Se añadieron `iss` y `aud` a `create_refresh_token()`, y se alineó `test_jwt_refresh.py` con el
  contrato actual del endpoint (`X-App-Context`, cookie namespaced y rate-limit bypass en testing).
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06