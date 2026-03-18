ID: BUG-20260310-EMPLOYEE-LOGIN-RATE-LIMIT-SHARED-BUCKET
FECHA: 2026-03-10
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: El rate limiting de login employees comparte un bucket único por IP/path y bloquea logins válidos entre roles
DESCRIPCION: El endpoint canónico de login employees agrupaba todos los intentos por `client_ip + request.path`, sin distinguir cuenta objetivo. Eso provocaba `429` cruzados entre roles/usuarios distintos desde la misma IP en suites Playwright/E2E y flujos multi-console.
PASOS_REPRODUCIR:
1. Ejecutar varios logins válidos consecutivos desde la misma IP a distintos scopes employees.
2. Observar `429 Demasiadas solicitudes` aunque sean usuarios/roles distintos.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: El rate limit sigue activo pero ahora distingue por cuenta objetivo.
UBICACION:
- pronto-libs/src/pronto_shared/security_middleware.py
- pronto-api/src/api_app/routes/employees/auth.py
EVIDENCIA:
- `auth.spec.ts` pasó 3/3.
- `test-login-flows.spec.ts` pasó 10/10.
- Secuencia multi-rol real dejó de bloquear admin/system tras logins previos.
HIPOTESIS_CAUSA: El decorador de rate limiting no permitía segmentar la key por cuenta/email.
ESTADO: RESUELTO
SOLUCION:
- `rate_limit()` ahora acepta `key_builder`.
- El login employees construye el bucket con hash del email (`IP + path + email_hash`) sin exponer el correo en logs.
- Se añadieron validaciones locales del helper y del bucket custom, y se verificó el comportamiento real con Playwright y probes HTTP.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

