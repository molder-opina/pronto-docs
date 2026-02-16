ID: BUG-20260214-002
FECHA: 2026-02-14
PROYECTO: pronto-libs
SEVERIDAD: bloqueante
TITULO: Hashing de passwords de clientes usa SHA256 con pepper estático (inseguro)
DESCRIPCION: |
  `customer_service.py` usa `hashlib.sha256(email:password:static_pepper)` para hashear
  passwords de clientes. SHA256 es un hash rápido, vulnerable a ataques de fuerza bruta
  por GPU. El pepper es estático y hardcoded en el código fuente.
  Debe usarse un KDF lento como PBKDF2, bcrypt o argon2 con salt por usuario.
  `werkzeug.security.generate_password_hash` / `check_password_hash` (PBKDF2) ya está
  disponible en el proyecto como dependencia de Flask.
PASOS_REPRODUCIR: |
  1. Revisar pronto-libs/src/pronto_shared/services/customer_service.py líneas 22-32.
  2. Observar que `hash_credentials()` usa SHA256 con pepper estático.
  3. Observar que `verify_credentials()` compara directamente el hash sin salt por usuario.
RESULTADO_ACTUAL: |
  Passwords hasheados con SHA256 + pepper estático. Sin salt por usuario. Sin iteraciones.
RESULTADO_ESPERADO: |
  Passwords hasheados con PBKDF2 (werkzeug) o bcrypt/argon2 con salt por usuario.
  Migración gradual: en login verificar hash viejo, si coincide rehashear con PBKDF2
  y actualizar en DB.
UBICACION: pronto-libs/src/pronto_shared/services/customer_service.py (funciones hash_credentials, verify_credentials, create_customer, authenticate_customer)
EVIDENCIA: Línea 22-26 muestra `hashlib.sha256(f"{identifier}:{password}:{pepper}".encode()).hexdigest()` con pepper hardcoded `"pronto-customer-pepper-v1"`.
HIPOTESIS_CAUSA: Implementación inicial rápida sin considerar estándares de hashing de passwords.
ESTADO: RESUELTO
SOLUCION: Corregido en versión 1.0038
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-14
