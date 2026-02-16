ID: AUTH-018
FECHA: 2026-02-14
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: Scripts de validación - Test auth flow y Redis failure
DESCRIPCION: 
No hay scripts de validación para flujo de auth y casos de fallo.
PASOS_REPRODUCIR:
1. ./pronto-scripts/bin/pronto-test-client-auth
2. command not found
RESULTADO_ACTUAL:
Sin scripts de validación
RESULTADO_ESPERADO:
- pronto-test-client-auth - Test completo de auth
- pronto-test-e2e-client-flow - Test E2E login→orden→logout
- pronto-test-redis-failure - Test Redis down retorna 503
UBICACION:
- pronto-scripts/bin/pronto-test-client-auth (nuevo)
- pronto-scripts/bin/pronto-test-e2e-client-flow (nuevo)
- pronto-scripts/bin/pronto-test-redis-failure (nuevo)
EVIDENCIA:
Archivos no existen
HIPOTESIS_CAUSA:
Scripts no creados
ESTADO: POSTERGADO
DEPENDENCIAS: AUTH-007, AUTH-015 (requiere endpoints y seeds)
BLOQUEA: Ninguna