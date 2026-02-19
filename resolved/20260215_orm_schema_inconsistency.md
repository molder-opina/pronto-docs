---
ID: 20260215_orm_schema_inconsistency
DATE: 2026-02-15
PROJECT: pronto-libs
SEVERIDAD: crítica
TITULO: Inconsistencia masiva entre modelos ORM y esquema físico (UUID vs INT)
DESCRIPCION: |
  Existe una discrepancia crítica entre los modelos definidos en `pronto_shared/models.py` y las tablas reales en la base de datos PostgreSQL.
  
  Muchos modelos (ej: `Area`, `Table`) definen sus IDs como `Mapped[int]`, mientras que el esquema físico de la base de datos utiliza `UUID` (ej: `id UUID PRIMARY KEY DEFAULT gen_random_uuid()`).
  
  Esta inconsistencia provoca errores de tipo en tiempo de ejecución al intentar hidratar objetos desde la base de datos o al realizar consultas con llaves foráneas. Además, el frontend (Vue) parece estar tipado para esperar `number` para estos IDs, lo que sugiere que hubo una migración parcial del esquema físico a UUID sin actualizar la lógica de la aplicación ni los modelos.
UBICACION: `pronto-libs/src/pronto_shared/models.py`
REPRODUCCION:
  1. Comparar la salida de `\d pronto_areas` en psql con la definición de la clase `Area` en `models.py`.
  2. Intentar realizar un join entre `Table` y `Area` vía SQLAlchemy.
RESULTADO_ACTUAL: Error de SQLAlchemy o fallo silencioso al mapear UUID a Integer.
RESULTADO_ESPERADO: Los modelos deben reflejar fielmente los tipos de datos de la base de datos física.
---
