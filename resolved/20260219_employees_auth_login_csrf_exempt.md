ID: ERR-20260219-EMPLOYEES-AUTH-LOGIN-CSRF-EXEMPT
FECHA: 2026-02-19
PROYECTO: pronto-api
SEVERIDAD: bloqueante
TITULO: Endpoint de login de employees usa @csrf.exempt fuera de excepción permitida
DESCRIPCION: El endpoint `POST /api/employees/auth/login` en pronto-api declara `@csrf.exempt`, lo cual viola el guardrail P0 que solo permite excepción en `/api/sessions/open`.
PASOS_REPRODUCIR:
1) Ejecutar escaneo `rg -n --hidden "@csrf\\.exempt" pronto-api/src pronto-employees/src pronto-client/src -g "*.py"`.
2) Verificar decoradores en ruta de login employees.
RESULTADO_ACTUAL: Se detecta `@csrf.exempt` en login employees.
RESULTADO_ESPERADO: Login employees debe requerir CSRF con token válido y no usar `@csrf.exempt`.
UBICACION: /Users/molder/projects/github-molder/pronto/pronto-api/src/api_app/routes/employees/auth.py:31
EVIDENCIA: Decorador `@csrf.exempt` presente sobre `@bp.route("/login", methods=["POST"])`.
HIPOTESIS_CAUSA: Bypass histórico para facilitar pruebas de autenticación antes de consolidar el wrapper frontend con token CSRF.
ESTADO: RESUELTO
SOLUCION: Se eliminó `@csrf.exempt` del endpoint `POST /api/employees/auth/login` en `pronto-api`. El frontend employees ya envía `X-CSRFToken` mediante `requestJSON` desde `meta[name="csrf-token"]`, por lo que el login queda protegido sin bypass.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-19
