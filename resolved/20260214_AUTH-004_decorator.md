ID: AUTH-004
FECHA: 2026-02-14
PROYECTO: pronto-libs
SEVERIDAD: bloqueante
TITULO: Decorator require_customer_session - Validar customer_ref en API
DESCRIPCION: 
No existe decorator para validar customer_ref en endpoints de pronto-api.
Se requiere decorator que lea header X-PRONTO-CUSTOMER-REF y valide contra Redis.
PASOS_REPRODUCIR:
1. from pronto_shared.auth.decorators import require_customer_session
2. ModuleNotFoundError
RESULTADO_ACTUAL:
No existe decorator
RESULTADO_ESPERADO:
- Decorator @require_customer_session
- Retorna 401 si falta header, ref inválido, revoked o expired
- Retorna 503 si Redis down
- Inyecta g.customer
UBICACION:
- pronto-libs/src/pronto_shared/auth/decorators.py (nuevo)
- pronto-libs/src/pronto_shared/auth/__init__.py (nuevo)
EVIDENCIA:
Archivo no existe
HIPOTESIS_CAUSA:
Funcionalidad no implementada
ESTADO: ABIERTO
DEPENDENCIAS: AUTH-003 (requiere CustomerSessionStore)
BLOQUEA: AUTH-006