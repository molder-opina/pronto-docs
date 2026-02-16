ID: AUTH-003
FECHA: 2026-02-14
PROYECTO: pronto-libs
SEVERIDAD: bloqueante
TITULO: CustomerSessionStore - Crear store Redis para identidad de clientes
DESCRIPCION: 
No existe servicio para gestionar customer_ref en Redis.
Los clientes necesitan un store que maneje identidad en Redis con TTL 60m.
PASOS_REPRODUCIR:
1. from pronto_shared.services.customer_session_store import CustomerSessionStore
2. ModuleNotFoundError
RESULTADO_ACTUAL:
No existe customer_session_store.py
RESULTADO_ESPERADO:
- CustomerSessionStore con create_customer_ref, get_customer, is_revoked, touch, revoke
- RedisUnavailableError para manejar caída de Redis
UBICACION:
- pronto-libs/src/pronto_shared/services/customer_session_store.py (nuevo)
EVIDENCIA:
Archivo no existe
HIPOTESIS_CAUSA:
Funcionalidad no implementada
ESTADO: ABIERTO
DEPENDENCIAS: AUTH-002 (requiere modelo Customer actualizado)
BLOQUEA: AUTH-004, AUTH-005, AUTH-006