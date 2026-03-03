ID: 20260215_DUPLICATE_TABLES
FECHA: 2026-02-15
PROYECTO: PostgreSQL
SEVERIDAD: media
TITULO: Tablas duplicadas en DB - branding_config y pronto_business_config
DESCRIPCION:
Existen dos tablas similares en la base de datos que pueden representar duplicación de datos o confusión:
- branding_config
- pronto_business_config

Además existe duplicación de tablas de migraciones:
- schema_migrations
- pronto_schema_migrations
PASOS_REPRODUCIR:
1. SELECT * FROM branding_config LIMIT 1;
2. SELECT * FROM pronto_business_config LIMIT 1;
3. SELECT * FROM schema_migrations LIMIT 1;
4. SELECT * FROM pronto_schema_migrations LIMIT 1;
RESULTADO_ACTUAL: 4 tablas que pueden ser redundantes
RESULTADO_ESPERADO: Una sola fuente de verdad por tipo de dato
UBICACION: PostgreSQL pronto
EVIDENCIA:
- branding_config vs pronto_business_config: parece que ambas almacenan configuración del negocio
- schema_migrations vs pronto_schema_migrations: ambas parecen gestionar migraciones
HIPOTESIS_CAUSA:
- Tablas creadas en diferentes momentos sin revisión
- Migraciones ejecutadas de diferentes fuentes
ESTADO: RESUELTO
