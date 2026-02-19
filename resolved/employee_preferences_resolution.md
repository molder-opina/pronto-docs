# Employee Preferences System - Resolution Documentation

**Date**: 2026-02-16  
**Status**: RESOLVED  
**Related**: BUG-20260215-007 (Phase 2 Migration)

## Problem Statement

The audit identified duplicate systems for storing employee preferences:
1. JSONB column `preferences` in `pronto_employees` table
2. Separate table `pronto_employee_preferences`

## Resolution

### Decision: Use Dedicated Table (`pronto_employee_preferences`)

**Rationale**:
- Better queryability (can filter/search by specific preference keys)
- Easier to add constraints and validation per preference type
- Clearer schema documentation
- Supports future indexing on specific preferences

### Implementation

Created `pronto_employee_preferences` table in migration `20260216_02__create_tables_phase_2.sql`:

```sql
CREATE TABLE IF NOT EXISTS pronto_employee_preferences (
    id SERIAL PRIMARY KEY,
    employee_id UUID NOT NULL REFERENCES pronto_employees(id) ON DELETE CASCADE,
    key VARCHAR(100) NOT NULL,
    value TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(employee_id, key)
);
```

### ORM Model

Model defined in `pronto_shared/models.py`:

```python
class EmployeePreference(Base):
    __tablename__ = "pronto_employee_preferences"
    
    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    employee_id: Mapped[UUID] = mapped_column(PG_UUID(as_uuid=True), ForeignKey("pronto_employees.id"))
    key: Mapped[str] = mapped_column(String(100), nullable=False)
    value: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now(), onupdate=func.now())
```

### Migration Path for JSONB Column

**Current Status**: JSONB `preferences` column still exists in `pronto_employees` but is not actively used.

**Recommended Action** (Future):
1. Audit existing data in JSONB column
2. If empty or unused, drop the column
3. If contains data, migrate to `pronto_employee_preferences` table
4. Drop JSONB column after migration

**Migration Script** (when needed):

```sql
-- Migrate JSONB preferences to table (if needed)
INSERT INTO pronto_employee_preferences (employee_id, key, value)
SELECT 
    id as employee_id,
    jsonb_object_keys(preferences) as key,
    preferences->>jsonb_object_keys(preferences) as value
FROM pronto_employees
WHERE preferences IS NOT NULL AND preferences != '{}'::jsonb;

-- Drop JSONB column (after verification)
ALTER TABLE pronto_employees DROP COLUMN preferences;
```

## Verification

- ✅ Table created successfully
- ✅ ORM model defined
- ✅ Foreign key constraint to `pronto_employees`
- ✅ Unique constraint on `(employee_id, key)`
- ⏳ JSONB column deprecation pending data audit

## Related Files

- Migration: `pronto-scripts/init/sql/migrations/20260216_02__create_tables_phase_2.sql`
- Model: `pronto-libs/src/pronto_shared/models.py` (line 445)
- Audit: `pronto-docs/errors/20260215_auditoria_esquema_db.md`

## Status

**RESOLVED** - Dedicated table approach implemented. JSONB column deprecation deferred pending data audit.
