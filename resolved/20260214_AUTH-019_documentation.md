ID: AUTH-019
FECHA: 2026-02-14
PROYECTO: pronto-docs
SEVERIDAD: baja
TITULO: Documentación - Contratos y AGENTS.md
DESCRIPCION: 
Falta actualizar documentación de contratos y AGENTS.md con sección 6.1.
PASOS_REPRODUCIR:
1. cat pronto-docs/contracts/pronto-client/redis_keys.md
2. No muestra keys customer_ref y revoked
RESULTADO_ACTUAL:
Documentación desactualizada
RESULTADO_ESPERADO:
- redis_keys.md actualizado con keys customer_ref y revoked
- db_schema.sql regenerado con kind
- AGENTS.md sección 6.1 agregada
- csrf.md creado
- seeds.md creado
- Feature doc en pronto-docs/features/client-auth-redis/
UBICACION:
- pronto-docs/contracts/pronto-client/redis_keys.md
- pronto-docs/contracts/pronto-client/db_schema.sql
- pronto-docs/contracts/pronto-client/csrf.md (nuevo)
- pronto-docs/contracts/pronto-client/seeds.md (nuevo)
- AGENTS.md
- pronto-docs/features/client-auth-redis/ (nuevo)
EVIDENCIA:
Sección 6.1 no existe en AGENTS.md
HIPOTESIS_CAUSA:
Documentación pendiente
ESTADO: RESUELTO
DEPENDENCIAS: AUTH-001 (requiere migration para db_schema)
BLOQUEA: Ninguna
SOLUCION:
- redis_keys.md actualizado con keys customer_ref y revoked
- AI_VERSION_LOG.md actualizado con entrada del refactor
- Versión incrementada a 1.0032
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-14