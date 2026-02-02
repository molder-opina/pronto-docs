# Plan de Migración: zone → area_id

## Estado Actual

### Table Model

```python
class Table(Base):
    area_id: Mapped[int] = mapped_column(ForeignKey("pronto_areas.id"), nullable=False)
    zone: Mapped[str | None] = mapped_column(String(50), nullable=True)  # LEGACY
```

### Problema

- `zone` es campo legacy (string, nullable)
- `area_id` es FK obligatorio a `pronto_areas`
- El código aún usa `zone` para ordering, filtering y display
- `zone` no está sincronizado con `area`

## Objetivos

1. **Deprecar campo `zone`**: Mantener pero marcar como deprecated
2. **Usar `area` relationship**: Reemplazar todo uso de `zone` con `area`
3. **Sincronización**: Mantener `zone` actualizado desde `area` (opcional)
4. **API consistente**: Respuestas deben incluir info del área, no `zone`

## Fases de Migración

### Fase 1: Actualizar Modelo y Datos (DBA)

**1.1 Agregar triggers/functions para sincronización**

```sql
-- Crear función para derived zone desde area
CREATE OR REPLACE FUNCTION compute_table_zone(area_prefix text, area_name text)
RETURNS text AS $$
BEGIN
    RETURN COALESCE(area_prefix, 'G') || '-' || COALESCE(area_name, 'General');
END;
$$ LANGUAGE plpgsql;

-- Actualizar zona desde área para registros existentes
UPDATE pronto_tables t
SET zone = (
    SELECT COALESCE(a.prefix, 'G') || '-' || a.name
    FROM pronto_areas a
    WHERE a.id = t.area_id
)
WHERE t.zone IS NULL OR t.zone != (
    SELECT COALESCE(a.prefix, 'G') || '-' || a.name
    FROM pronto_areas a
    WHERE a.id = t.area_id
);
```

**1.2 Agregar FK constraint si no existe**

```sql
-- Verificar que area_id tiene FK
ALTER TABLE pronto_tables DROP CONSTRAINT IF EXISTS fk_table_area;
ALTER TABLE pronto_tables ADD CONSTRAINT fk_table_area
    FOREIGN KEY (area_id) REFERENCES pronto_areas(id);
```

### Fase 2: Actualizar API Endpoints (Backend)

**2.1 Modificar GET /tables**

Antes:

```python
query = select(Table).where(Table.is_active).order_by(Table.zone, Table.table_number)
# ...
"zone": table.zone,
```

Después:

```python
from sqlalchemy import join

# Join con area para obtener prefix y nombre
query = (
    select(Table, Area)
    .join(Area, Table.area_id == Area.id)
    .where(Table.is_active)
    .order_by(Area.prefix, Area.name, Table.table_number)
)
# ...
"area": {
    "id": table.area_id,
    "prefix": area.prefix,
    "name": area.name,
    "color": area.color
}
```

**2.2 Modificar POST /tables**

Antes:

```python
new_table = Table(
    table_number=table_number,
    zone=payload.get("zone", "Interior"),
    # ...
)
```

Después:

```python
area_id = payload.get("area_id")
if not area_id:
    return jsonify(error_response("area_id es requerido")), HTTPStatus.BAD_REQUEST

new_table = Table(
    table_number=table_number,
    area_id=area_id,
    # zone ya no se setea manualmente
    # ...
)
```

**2.3 Actualizar todos los endpoints**

Archivos a modificar:

- `build/pronto_employees/routes/api/tables.py`
- `build/pronto_employees/routes/api/debug.py`
- `build/pronto_employees/routes/api/areas.py`
- `build/pronto_employees/routes/api_legacy.py`
- `build/pronto_clients/routes/api/config.py`
- `build/pronto_clients/routes/api_legacy.py`
- `build/shared/services/waiter_table_assignment_service.py`

### Fase 3: Deprecation Warnings (Backend)

**3.1 Agregar warnings cuando se use `zone`**

```python
import warnings

@tables_bp.get("/tables")
def get_tables():
    zone = request.args.get("zone")
    if zone:
        warnings.warn(
            "El parámetro 'zone' está deprecado. Usa 'area_id' en su lugar.",
            DeprecationWarning,
            stacklevel=2
        )
```

**3.2 Response headers**

```python
response.headers["X-Deprecation-Warning"] = "zone field is deprecated, use area instead"
```

### Fase 4: Actualizar Frontend

**4.1 Buscar y reemplazar uso de `zone`**

```bash
# Buscar uso de zone en frontend
grep -r "zone" build/*/static/js/src --include="*.ts" --include="*.tsx"

# Reemplazar con area
# zone → area.prefix o area.name
# "Interior" → area con prefix "A"
```

**4.2 Actualizar componentes**

- `tables-manager.ts`: Ya usa `area` relationship
- Modificar displays de tablas para mostrar `area.prefix - area.name`
- Actualizar filtros de zona → filtros de área

### Fase 5: Limpieza Final (Opcional)

**5.1 Mantener `zone` como computed column**

```python
# En el modelo
@hybrid_property
def zone(self):
    if self.area:
        return f"{self.area.prefix}-{self.area.name}"
    return "G-General"

@zone.expression
def zone(cls):
    return func.concat(Area.prefix, '-', Area.name)
```

**5.2 Eliminar completamente (después de 3-6 meses)**

```sql
ALTER TABLE pronto_tables DROP COLUMN zone;
```

## Checklist de Cambios

### Backend

- [ ] Migración SQL ejecutada
- [ ] `GET /tables` usa `area` relationship
- [ ] `POST /tables` requiere `area_id`
- [ ] `PUT /tables/{id}` actualiza `area_id`
- [ ] Todos los endpoints de legado actualizados
- [ ] Warnings de deprecación agregados

### Frontend

- [ ] Búsqueda de uso de `zone` completada
- [ ] Componentes de filtrado actualizados
- [ ] Displays de mesas muestran código de área
- [ ] Formularios de mesa usan selector de área

### Testing

- [ ] Tests unitarios pasan
- [ ] Tests de integración pasan
- [ ] E2E tests pasan
- [ ] Validación manual de UI

## Rollback Plan

Si algo falla:

1. Revertir cambios de código (usar git)
2. Los datos en DB no se pierden (solo lectura en algunos paths)
3. Para revertir migración SQL:
   ```sql
   -- Solo si fase 1 no se ha completado
   -- La migración es idempotente
   ```

## Tiempo Estimado

- Fase 1 (DBA): 1-2 horas
- Fase 2 (Backend API): 4-6 horas
- Fase 3 (Warnings): 1-2 horas
- Fase 4 (Frontend): 2-4 horas
- Fase 5 (Cleanup): Opcional, diferir 3-6 meses

**Total: 8-14 horas**

## Notas

- La migración es **backward compatible** si se mantiene `zone` en responses
- `zone` puede servir como cache de `area.prefix + area.name`
- Considerar agregar computed property en modelo SQLAlchemy
