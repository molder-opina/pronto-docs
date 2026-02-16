ID: BUG-20250209-001
FECHA: 2026-02-09
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: Endpoint /api/auth/login should be renamed to /api/client-auth/login

DESCRIPCION:
El endpoint de autenticación para clientes está bajo `/api/auth/login`, lo cual es ambiguo.
Debería estar bajo `/api/client-auth/login` para mantener consistencia con la arquitectura.

ESTADO ACTUAL:
- `/api/auth/login` → Autenticación de clientes (client_auth.py)
- `/api/employee-auth/login` → Autenticación de empleados (employees/auth.py)

ESTADO DESEADO:
- `/api/client-auth/login` → Autenticación de clientes (renombrar)
- `/api/employee-auth/login` → Autenticación de empleados (ya correcto)

PASOS REPRODUCIR:
1. Enviar POST a /api/auth/login con credenciales de cliente
2. Verificar que funciona
3. Observar que el nombre no es consistente con la arquitectura

RESULTADO_ACTUAL:
Endpoint funciona pero nombre es ambiguo (/api/auth vs /api/employee-auth)

RESULTADO_ESPERADO:
Endpoint debería ser `/api/client-auth/login` para claridad de arquitectura

UBICACION:
- File: pronto-api/src/api_app/routes/client_auth.py
- Line: bp = Blueprint("client_auth", __name__, url_prefix="/auth")
- Should be: bp = Blueprint("client_auth", __name__, url_prefix="/client-auth")

IMPACTO:
- Frontend que usa /api/auth/login debe actualizarse
- Tests deben actualizarse
- Documentación debe actualizarse

HIPOTESIS_CAUSA:
El endpoint fue creado antes de que se definiera la arquitectura clara de employee-auth vs client-auth

ESTADO: ABIERTO
