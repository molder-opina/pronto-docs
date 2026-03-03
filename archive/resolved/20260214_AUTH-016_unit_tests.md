ID: AUTH-016
FECHA: 2026-02-14
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Unit tests - CustomerSessionStore y decorator
DESCRIPCION: 
No hay tests unitarios para CustomerSessionStore y require_customer_session.
PASOS_REPRODUCIR:
1. ls pronto-libs/tests/unit/services/test_customer_session_store.py
2. No such file
RESULTADO_ACTUAL:
Sin tests para nueva funcionalidad
RESULTADO_ESPERADO:
- test_customer_session_store.py con tests de create/get/touch/revoke/redis_down
- test_decorators.py con tests de header missing/invalid/revoked/expired/redis_down
UBICACION:
- pronto-libs/tests/unit/services/test_customer_session_store.py (nuevo)
- pronto-libs/tests/unit/auth/test_decorators.py (nuevo)
EVIDENCIA:
Archivos no existen
HIPOTESIS_CAUSA:
Tests no creados con funcionalidad
ESTADO: POSTERGADO
DEPENDENCIAS: AUTH-003, AUTH-004 (requiere store y decorator)
BLOQUEA: Ninguna