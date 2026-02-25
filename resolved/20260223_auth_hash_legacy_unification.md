ID: ERR-20260223-AUTH-HASH-LEGACY-UNIFICATION
FECHA: 2026-02-23
PROYECTO: pronto-libs / pronto-client / pronto-employees
SEVERIDAD: alta
TITULO: Verificación de credenciales dependía de esquemas legacy y podía fallar o degradar seguridad
DESCRIPCION: Se detectó uso mixto/inconsistente de hashing (bcrypt, pbkdf2 y sha256 legacy) en distintos puntos de autenticación. Esto podía provocar errores de login y mantener hashes antiguos sin migración.
PASOS_REPRODUCIR:
1. Intentar login con cuentas históricas con hashes legacy.
2. Revisar rutas de login de clientes y empleados.
3. Verificar que no existe upgrade automático de hash a esquema moderno.
RESULTADO_ACTUAL: Flujo de verificación heterogéneo, con soporte parcial y sin consolidación de migración automática.
RESULTADO_ESPERADO: Esquema único moderno para nuevos hashes (PBKDF2), verificación compatible con legacy solo para transición y upgrade automático al autenticarse correctamente.
UBICACION: pronto-libs/src/pronto_shared/security/core.py; pronto-libs/src/pronto_shared/security.py; pronto-libs/src/pronto_shared/services/customer_service.py; pronto-libs/src/pronto_shared/services/auth_service.py; pronto-libs/src/pronto_shared/auth/service.py; pronto-employees/src/pronto_employees/routes/*/auth.py
EVIDENCIA: Auditoría de código + reporte funcional de login con hashes legacy.
HIPOTESIS_CAUSA: Evolución histórica con múltiples implementaciones de hashing/verificación y ausencia de política unificada de migración.
ESTADO: RESUELTO
SOLUCION: Se unificó la política de hashing a PBKDF2 para nuevos credenciales y se añadió `verify_and_upgrade_credentials` para compatibilidad transicional con bcrypt/sha256 legacy. Al login exitoso con hash legacy se actualiza automáticamente el hash almacenado a formato moderno. Se eliminaron logs que exponían hash/candidato y se propagó el upgrade en auth de clientes y empleados.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
