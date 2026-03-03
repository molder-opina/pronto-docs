ID: ERR-20260223-AUTH-NO-LEGACY-POLICY
FECHA: 2026-02-23
PROYECTO: pronto-libs / pronto-employees / pronto-scripts / pronto-client
SEVERIDAD: alta
TITULO: Autenticación con compatibilidad legacy e inconsistencias de esquema/init
DESCRIPCION: Existían rutas de autenticación con compatibilidad transicional (`verify_and_upgrade_credentials`) y divergencias de esquema/init (longitud de `auth_hash` y defaults inseguros en seed scripts), lo que contradecía el requerimiento de eliminar legacy.
PASOS_REPRODUCIR:
1. Revisar `security/core.py` y rutas de login.
2. Detectar soporte a hashes legacy (bcrypt/sha256).
3. Revisar DDL/init para `auth_hash` y scripts con defaults `default-salt`.
RESULTADO_ACTUAL: Política de auth no era estrictamente moderna y existían inconsistencias de implementación.
RESULTADO_ESPERADO: Política única moderna (sin compatibilidad legacy), verificación estricta y esquema/init alineados.
UBICACION: pronto-libs/src/pronto_shared/security/*; pronto-libs/src/pronto_shared/services/*auth*; pronto-employees/src/pronto_employees/routes/*/auth.py; pronto-scripts/init/sql/*; pronto-scripts/scripts/*
EVIDENCIA: Auditoría de código global solicitada por usuario.
HIPOTESIS_CAUSA: Evolución incremental de auth con deuda de transición y artefactos de migraciones previas.
ESTADO: RESUELTO
SOLUCION: Se eliminó compatibilidad legacy de autenticación en runtime (`verify_and_upgrade_credentials`, fallback bcrypt/sha256), se dejó verificación estricta de hashes modernos (`pbkdf2/scrypt`) y hash nuevo con método seguro configurado. Se alineó `auth_hash` a `VARCHAR(255)` en modelos y DDL (`init` + migraciones + nueva migración `20260223_01__auth_hash_column_length_255.sql`), y se removieron defaults inseguros (`change-me-please`/`default-salt`) en scripts de init/seed. Se actualizó tooling de migración de auth a enfoque moderno.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
