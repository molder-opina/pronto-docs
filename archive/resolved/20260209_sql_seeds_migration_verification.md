# SQL Seeds Migration - Verification Pending

**Fecha**: 2026-02-09  
**Estado**: ⏳ PENDIENTE VERIFICACIÓN  
**Prioridad**: ALTA  
**Tipo**: Refactorización / Migración  
**Componente**: Database Initialization  

---

## Resumen

Se completó la migración de `pronto_shared/services/seed.py` (4,893 líneas de Python) a archivos SQL en `pronto-scripts/init/sql/40_seeds/`. La migración está completa pero **requiere verificación** mediante rebuild de contenedores.

---

## Contexto

### Problema Original
- `seed.py` mezclaba lógica de servicio con datos de inicialización
- 4,893 líneas de código Python con datos hardcodeados
- Difícil de mantener y actualizar
- No seguía el principio de separación de responsabilidades

### Solución Implementada
Migración completa a SQL init scripts:

**Archivos SQL creados (8 archivos, ~51KB):**
1. `0310__categories.sql` - 12 categorías de menú
2. `0320__areas.sql` - 3 áreas del restaurante
3. `0330__menu_items.sql` - 94 items del menú
4. `0350__tables.sql` - 8 mesas
5. `0360__employees.sql` - 10 empleados (con pgcrypto para encriptación)
6. `0370__business_config.sql` - Configuración + horarios
7. `0380__permissions.sql` - Permisos y roles del sistema
8. `0340__modifiers.sql` - Modificadores (renombrado de 9999)

**Scripts actualizados:**
- `seed_test_data.py` - Ahora verifica SQL seeds en lugar de ejecutar Python
- `seed_interactive.py` - Usa `employee_seed_helpers.py` local

**Archivos nuevos:**
- `employee_seed_helpers.py` - Funciones de creación de empleados (para uso interactivo)
- `verify_sql_seeds.py` - Script de verificación de seeds

**Archivos eliminados/archivados:**
- `seed.py` → `archived/seed.py.bak`
- `0300__seed_data.sql` → `0300__seed_data.sql.old`

---

## Verificación Pendiente (Fase 5)

### Checklist de Verificación

- [ ] **Rebuild de contenedores**
  ```bash
  cd /Users/molder/projects/github-molder/pronto
  docker-compose down -v  # Eliminar volúmenes
  docker-compose up -d --build
  ```

- [ ] **Verificar logs de init**
  ```bash
  docker logs pronto-postgres | grep -i "seed"
  docker logs pronto-api | grep -i "error"
  ```

- [ ] **Ejecutar script de verificación**
  ```bash
  cd pronto-scripts
  python3 scripts/verify_sql_seeds.py
  ```
  
  **Esperado:**
  - ✅ Categories: 12
  - ✅ Menu Items: 94
  - ✅ Areas: 3
  - ✅ Tables: 8
  - ✅ Employees: 10 (verificar manualmente con psql)

- [ ] **Verificar empleados con encriptación**
  ```bash
  docker exec -it pronto-postgres psql -U pronto -d pronto -c \
    "SELECT id, role, is_active FROM pronto_employees;"
  ```
  
  **Esperado:** 10 empleados con roles: system, admin, waiter (3), chef (2), cashier (2)

- [ ] **Verificar permisos**
  ```bash
  docker exec -it pronto-postgres psql -U pronto -d pronto -c \
    "SELECT COUNT(*) FROM pronto_system_permissions;"
  ```
  
  **Esperado:** ~18 permisos

- [ ] **Probar login de empleados**
  - Usuario: `admin@cafeteria.test`
  - Password: `ChangeMe!123` (o valor de `SEED_EMPLOYEE_PASSWORD`)
  - Verificar en: `http://localhost:6081/admin/login`

- [ ] **Verificar aplicación arranca correctamente**
  ```bash
  curl http://localhost:6082/api/health
  curl http://localhost:6081/admin/login
  curl http://localhost:6080/
  ```

- [ ] **Ejecutar tests básicos**
  ```bash
  cd pronto-tests
  pytest tests/functionality/api/ -k "test_menu" -v
  pytest tests/functionality/api/ -k "test_auth" -v
  ```

---

## Posibles Problemas

### 1. Encriptación de Empleados
**Síntoma**: Empleados no pueden hacer login  
**Causa**: Funciones de encriptación en `0360__employees.sql` no coinciden con Python  
**Solución**: 
- Verificar que `pgcrypto` extension está habilitada
- Verificar que `SECRET_KEY` y `PASSWORD_HASH_SALT` son correctos
- Si falla, usar `employee_seed_helpers.py` para crear empleados manualmente

### 2. Orden de Ejecución de SQL
**Síntoma**: Errores de foreign key  
**Causa**: Archivos SQL se ejecutan en orden incorrecto  
**Solución**: 
- Verificar nombres de archivos (deben ejecutarse en orden numérico)
- Revisar logs de PostgreSQL init

### 3. Conflictos con Datos Existentes
**Síntoma**: Errores de `ON CONFLICT`  
**Causa**: Datos previos en la base de datos  
**Solución**: 
- Usar `docker-compose down -v` para limpiar volúmenes
- O ejecutar manualmente: `DROP DATABASE pronto; CREATE DATABASE pronto;`

---

## Rollback Plan

Si la verificación falla y necesitas volver a `seed.py`:

```bash
# 1. Restaurar seed.py
mv pronto-scripts/bin/archived/seed.py.bak \
   pronto-libs/src/pronto_shared/services/seed.py

# 2. Revertir cambios en scripts
git checkout pronto-scripts/scripts/seed_test_data.py
git checkout pronto-scripts/scripts/seed_interactive.py

# 3. Eliminar SQL seeds nuevos (opcional)
rm pronto-scripts/init/sql/40_seeds/031*.sql
rm pronto-scripts/init/sql/40_seeds/032*.sql
rm pronto-scripts/init/sql/40_seeds/033*.sql
rm pronto-scripts/init/sql/40_seeds/035*.sql
rm pronto-scripts/init/sql/40_seeds/036*.sql
rm pronto-scripts/init/sql/40_seeds/037*.sql
rm pronto-scripts/init/sql/40_seeds/038*.sql

# 4. Rebuild
docker-compose down -v
docker-compose up -d --build
```

---

## Notas Técnicas

### Diferencias Clave: Python vs SQL

| Aspecto | Python (seed.py) | SQL (init scripts) |
|---------|------------------|-------------------|
| **Ejecución** | Runtime (cada vez que arranca) | Init (una sola vez) |
| **Encriptación** | Python `cryptography` | PostgreSQL `pgcrypto` |
| **UPSERT** | SQLAlchemy ORM | SQL `ON CONFLICT` |
| **Mantenimiento** | Código mezclado | Datos separados |
| **Performance** | Lento (ORM overhead) | Rápido (SQL nativo) |

### Funciones de Encriptación

El archivo `0360__employees.sql` usa funciones temporales que replican la lógica de Python:

```sql
pronto_hash_credentials(email, password) → SHA256(email + password + salt)
pronto_encrypt_string(text) → AES encryption con SECRET_KEY
pronto_hash_identifier(email) → SHA256(lowercase(email))
```

Estas funciones se **eliminan** al final del script para no contaminar el esquema.

---

## Próximos Pasos

1. ✅ **Completar verificación** (este documento)
2. ⏳ **Ejecutar rebuild y tests**
3. ⏳ **Documentar resultados**
4. ⏳ **Actualizar AGENTS.md** con nueva estructura de seeds
5. ⏳ **Cerrar este issue** cuando todo funcione

---

## Referencias

- **Checklist completo**: `brain/seed_migration_task.md`
- **SQL seeds**: `pronto-scripts/init/sql/40_seeds/`
- **Helper scripts**: `pronto-scripts/scripts/employee_seed_helpers.py`
- **Verificación**: `pronto-scripts/scripts/verify_sql_seeds.py`
- **Backup**: `pronto-scripts/bin/archived/seed.py.bak`

---

**Creado por**: Gemini AI  
**Fecha**: 2026-02-09  
**Última actualización**: 2026-02-09
