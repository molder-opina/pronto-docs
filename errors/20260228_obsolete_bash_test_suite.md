---
ID: OBSOLETE_BASH_TEST_SUITE
FECHA: 20260228
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: Suite de pruebas bash (test-all.sh) rota por incompatibilidad con seguridad V6
DESCRIPCION: La ejecución del script maestro de pruebas `./pronto-scripts/bin/test-all.sh` falla de manera generalizada (aunque a veces enmascara el error de salida). Los scripts internos (`test-api.sh`, `test-tips-flow.sh`) utilizan llamadas `curl` simples que no capturan ni envían el `X-CSRFToken` ni manejan adecuadamente las cookies con prefijos de namespace (`access_token_system`, `pronto_client_session`) implementadas en el blindaje V6. Como resultado, la API rechaza casi todas las peticiones con errores `400 CSRF Error` o `401 Autenticacion requerida`.
PASOS_REPRODUCIR:
1. Asegurar que los contenedores estén corriendo (`up.sh`).
2. Ejecutar `./pronto-scripts/bin/test-all.sh`.
RESULTADO_ACTUAL: Multitud de errores "The CSRF token is missing", "Recurso no encontrado" (404 por rutas antiguas) y "No autenticado" (401).
RESULTADO_ESPERADO: La suite de pruebas debería estar escrita idealmente en Python (`pytest`) utilizando `requests.Session()` (como `test_v6_full_cycle.py`) para manejar automáticamente el estado de las cookies y permitir la inyección fácil de cabeceras de seguridad.
UBICACION:
- pronto-scripts/bin/test-all.sh
- pronto-scripts/bin/tests/test-api.sh
- pronto-scripts/bin/tests/test-tips-flow.sh
HIPOTESIS_CAUSA: La capa de seguridad de la API evolucionó significativamente (Multi-console JWT, CSRF en JSON, Canonical Paths), dejando atrás a los scripts de prueba en bash que operaban asumiendo una API más permisiva.
ESTADO: PENDIENTE
---