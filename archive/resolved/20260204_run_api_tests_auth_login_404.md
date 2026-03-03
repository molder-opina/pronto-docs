---
ID: ERR-20260204-RUN-API-TESTS-AUTH-LOGIN-404
FECHA: 2026-02-04
PROYECTO: pronto-scripts/pronto-api
SEVERIDAD: media
TITULO: run_api_tests.py --auth-mode falla login (404 Recurso no encontrado)
DESCRIPCION: Al ejecutar el runner unificado de API tests en modo autenticado, el paso de login a empleados falla con respuesta de error "Recurso no encontrado". Esto impide validar endpoints autenticados y oculta regresiones de auth/roles.
PASOS_REPRODUCIR:
1) Levantar servicios (api) en http://localhost:6082
2) Ejecutar: pronto-scripts/pronto-api/run_tests.sh --auth-mode
RESULTADO_ACTUAL:
Login fallido con payload: {'data': None, 'error': 'Recurso no encontrado', 'status': 'error'}
RESULTADO_ESPERADO:
Login 200 + access_token valido, y ejecutar el set de pruebas autenticadas.
UBICACION:
pronto-scripts/pronto-api/scripts/run_api_tests.py
EVIDENCIA:
Comando:
cd pronto-scripts/pronto-api && bash run_tests.sh --auth-mode
Salida:
✗ Login fallido: {'data': None, 'error': 'Recurso no encontrado', 'status': 'error'}
HIPOTESIS_CAUSA:
Endpoint hardcodeado no coincide con el contrato real del API de empleados (ruta distinta o blueprint diferente).
ESTADO: RESUELTO
---

SOLUCION: Se corrigio el modo autenticado del runner unificado para que preserve cookies JWT y use el login correcto, evitando el 404 "Recurso no encontrado" durante la autenticacion.
COMMIT: multi:f14cbbf,2a4d39a
FECHA_RESOLUCION: 2026-02-05

SOLUCION:
- El runner autenticado dejo de usar `/api/employee/auth/login` (inexistente) y ahora autentica via `/system/login` (empleados) para obtener cookie JWT.
- Se agrego soporte de `API_BASE_URL`, `CLIENT_BASE_URL`, `EMPLOYEES_BASE_URL` y parsing correcto de `Set-Cookie` multiples.
- El runner falla con exit 1 si login falla o si hay tests fallidos.

COMMIT:
multi: f14cbbf,2a4d39a

FECHA_RESOLUCION:
2026-02-05
