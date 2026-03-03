ID: ERR-20260219-AREA-ID-UUID-INTEGER-MISMATCH
FECHA: 2026-02-19
PROYECTO: pronto-scripts, pronto-libs
SEVERIDAD: bloqueante
TITULO: Inconsistencia critica entre SQL (UUID) y modelos (Integer) para pronto_areas.id
DESCRIPCION: El script SQL base definia pronto_areas.id como UUID, pero el modelo SQLAlchemy lo define como Integer. Esto causaria errores de ORM en runtime y FK incompatibles con pronto_tables.area_id.
PASOS_REPRODUCIR:
1. Revisar pronto-scripts/init/sql/10_schema/0110__core_tables.sql
2. Ver pronto_areas.id como UUID
3. Revisar pronto-libs/src/pronto_shared/models.py
4. Ver Area.id como Integer
5. Ejecutar seed o operaciones ORM causaria errores
RESULTADO_ACTUAL: Esquema SQL inconsistente con modelos Python
RESULTADO_ESPERADO: SQL y modelos deben usar el mismo tipo
UBICACION: 
- pronto-scripts/init/sql/10_schema/0110__core_tables.sql:102-111
- pronto-libs/src/pronto_shared/models.py:1445
EVIDENCIA:
```sql
-- SQL (antes del fix)
id UUID PRIMARY KEY DEFAULT gen_random_uuid()

-- Modelo Python
id: Mapped[int] = mapped_column(Integer, primary_key=True)
```
HIPOTESIS_CAUSA: El SQL base fue creado antes de definir el canon de tipos en AGENTS.md
ESTADO: RESUELTO
SOLUCION:
1. Actualizado SQL base para usar SERIAL (Integer) para pronto_areas.id
2. Actualizado pronto_tables.area_id a INTEGER NOT NULL
3. Creada migracion 20260219_01__areas_integer_id.sql para DBs existentes
4. Creados archivos placeholder en 20_constraints/ y 30_indexes/
5. Regenerados contratos db_schema.sql
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
