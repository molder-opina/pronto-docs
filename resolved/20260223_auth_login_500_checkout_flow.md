ID: ERR-20260223-AUTH-LOGIN-500
FECHA: 2026-02-23
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: POST /api/auth/login retorna 500 durante flujo de checkout con auth obligatoria
DESCRIPCION: En el flujo de ir a pagar sin sesión, el modal de autenticación muestra error porque el endpoint /api/auth/login responde 500.
PASOS_REPRODUCIR:
1. Abrir cliente en http://localhost:6080 sin sesión autenticada.
2. Agregar productos y presionar "Ir a pagar".
3. Intentar iniciar sesión desde el modal.
RESULTADO_ACTUAL: XHR POST /api/auth/login retorna 500.
RESULTADO_ESPERADO: Login exitoso o error de credenciales controlado (4xx), nunca 500.
UBICACION: pronto-libs/src/pronto_shared/security/core.py; pronto-libs/src/pronto_shared/security.py
EVIDENCIA: `docker logs pronto-client-1` mostraba traceback con `ValueError: Invalid salt` en `bcrypt.checkpw`.
HIPOTESIS_CAUSA: Verificador de credenciales asume bcrypt siempre; cuando el hash almacenado está en formato Werkzeug (`pbkdf2`) o inválido para bcrypt, se levanta excepción no controlada.
ESTADO: RESUELTO
SOLUCION: Se actualizó `verify_credentials` para detectar hashes `pbkdf2/scrypt` y validarlos con `werkzeug.security.check_password_hash`. Para bcrypt se encapsuló `bcrypt.checkpw` con manejo de `ValueError` devolviendo `False` (sin crash). Así el endpoint devuelve 401 de credenciales inválidas en vez de 500.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
