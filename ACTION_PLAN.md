# Plan de Acción Consolidado - Pronto App

**Fecha**: 2026-01-30  
**Objetivo**: Completar tareas pendientes de JWT y Variables de Entorno

---

## 📋 Resumen de Análisis Previos

### 1. **Análisis de Implementación JWT**
- **Documento**: `docs/JWT_IMPLEMENTATION_REVIEW.md`
- **Estado**: Implementación completa y funcional
- **Áreas de mejora identificadas**: Testing, Documentación, Features opcionales

### 2. **Análisis de Variables de Entorno**
- **Documento**: `docs/ENV_VARIABLES_ANALYSIS.md`
- **Estado**: Recuperación exitosa, variables correctas
- **Áreas de mejora identificadas**: Documentación, Validación, Backup

---

## 🎯 Plan de Acción Consolidado

### FASE 1: Correcciones Críticas (Alta Prioridad)

#### 1.1. Actualizar `secrets.env.example`
**Problema**: Faltan variables críticas en el archivo de ejemplo

**Acción**:
```bash
# Agregar a config/secrets.env.example:
PASSWORD_HASH_SALT=your-password-hash-salt-here-32chars-minimum
CUSTOMER_DATA_KEY=your-customer-data-encryption-key-here-32chars-minimum
```

**Archivo**: `config/secrets.env.example`  
**Tiempo estimado**: 10 minutos  
**Prioridad**: 🔴 ALTA

---

#### 1.2. Crear Script de Backup Automático
**Problema**: No hay backup automático de archivos .env

**Acción**:
- Crear script `bin/backup-env.sh`
- Agregar a cron o pre-commit hook
- Guardar backups con timestamp

**Archivos**:
- `bin/backup-env.sh` (nuevo)
- `.pre-commit-config.yaml` (actualizar)

**Tiempo estimado**: 30 minutos  
**Prioridad**: 🔴 ALTA

---

#### 1.3. Agregar Validación de Variables en Startup
**Problema**: Solo algunas variables críticas se validan al iniciar

**Acción**:
- Crear función `validate_required_env_vars()` en `shared/config.py`
- Validar todas las variables críticas:
  - SECRET_KEY
  - HANDOFF_PEPPER
  - PASSWORD_HASH_SALT
  - CUSTOMER_DATA_KEY
  - POSTGRES_*
  - JWT_*

**Archivo**: `build/shared/config.py`  
**Tiempo estimado**: 45 minutos  
**Prioridad**: 🔴 ALTA

---

### FASE 2: Testing JWT (Alta Prioridad)

#### 2.1. Tests de Refresh Token
**Problema**: No hay tests para el flujo de refresh token

**Acción**:
- Crear `tests/integration/test_jwt_refresh.py`
- Tests:
  - `test_refresh_token_success` - Refresh exitoso
  - `test_refresh_token_expired` - Token expirado
  - `test_refresh_token_invalid` - Token inválido
  - `test_refresh_token_missing` - Token faltante

**Archivo**: `tests/integration/test_jwt_refresh.py` (nuevo)  
**Tiempo estimado**: 1 hora  
**Prioridad**: 🟡 MEDIA-ALTA

---

#### 2.2. Tests de Scope Validation
**Problema**: No hay tests para el scope guard

**Acción**:
- Crear `tests/integration/test_jwt_scope_guard.py`
- Tests:
  - `test_scope_match_allowed` - Scope correcto permitido
  - `test_scope_mismatch_blocked` - Scope incorrecto bloqueado
  - `test_scope_missing_blocked` - Sin scope bloqueado
  - `test_scope_exempt_routes` - Rutas exentas (login, logout)

**Archivo**: `tests/integration/test_jwt_scope_guard.py` (nuevo)  
**Tiempo estimado**: 1 hora  
**Prioridad**: 🟡 MEDIA-ALTA

---

#### 2.3. Tests de Role-Based Access
**Problema**: No hay tests para validación de roles

**Acción**:
- Crear `tests/integration/test_jwt_roles.py`
- Tests:
  - `test_role_required_success` - Rol correcto permitido
  - `test_role_required_denied` - Rol incorrecto bloqueado
  - `test_admin_required_success` - Admin permitido
  - `test_admin_required_denied` - No-admin bloqueado
  - `test_multi_role_access` - Empleado con múltiples roles
  - `test_super_admin_bypass` - Super admin accede a todo

**Archivo**: `tests/integration/test_jwt_roles.py` (nuevo)  
**Tiempo estimado**: 1.5 horas  
**Prioridad**: 🟡 MEDIA-ALTA

---

### FASE 3: Documentación (Media Prioridad)

#### 3.1. Actualizar AGENTS.md con JWT
**Problema**: AGENTS.md no documenta la implementación JWT

**Acción**:
- Agregar sección "## Authentication & Security"
- Subsecciones:
  - JWT Authentication
  - Decoradores disponibles
  - Middleware y Scope Guard
  - Ejemplos de uso
  - Troubleshooting común

**Archivo**: `AGENTS.md`  
**Tiempo estimado**: 1 hora  
**Prioridad**: 🟡 MEDIA

---

#### 3.2. Crear Guía de Variables de Entorno
**Problema**: No hay documentación centralizada de variables

**Acción**:
- Crear `docs/ENVIRONMENT_VARIABLES.md`
- Documentar:
  - Todas las variables disponibles
  - Descripción de cada una
  - Valores por defecto
  - Cómo generarlas (para secretos)
  - Obligatorias vs opcionales
  - Ejemplos de configuración

**Archivo**: `docs/ENVIRONMENT_VARIABLES.md` (nuevo)  
**Tiempo estimado**: 2 horas  
**Prioridad**: 🟡 MEDIA

---

#### 3.3. Actualizar ARCHITECTURE.md
**Problema**: ARCHITECTURE.md no refleja el cambio de sesiones a JWT

**Acción**:
- Actualizar sección de autenticación
- Agregar diagrama de flujo JWT
- Explicar diferencias con sistema anterior
- Documentar scope isolation

**Archivo**: `ARCHITECTURE.md`  
**Tiempo estimado**: 1.5 horas  
**Prioridad**: 🟡 MEDIA

---

#### 3.4. Crear Guía de Migración
**Problema**: No hay guía para entender el cambio de sesiones a JWT

**Acción**:
- Crear `docs/JWT_MIGRATION_GUIDE.md`
- Contenido:
  - Por qué se migró
  - Qué cambió
  - Cómo afecta al desarrollo
  - Troubleshooting de problemas comunes
  - Comparación sesiones vs JWT

**Archivo**: `docs/JWT_MIGRATION_GUIDE.md` (nuevo)  
**Tiempo estimado**: 1 hora  
**Prioridad**: 🟢 BAJA-MEDIA

---

### FASE 4: Features Opcionales (Baja Prioridad)

#### 4.1. Implementar Token Blacklist
**Beneficio**: Permite logout forzado e invalidación de tokens comprometidos

**Acción**:
- Crear `build/shared/jwt_blacklist.py`
- Usar Redis para almacenar tokens invalidados
- Agregar middleware para verificar blacklist
- Agregar endpoint `/api/auth/revoke` para invalidar tokens

**Archivos**:
- `build/shared/jwt_blacklist.py` (nuevo)
- `build/shared/jwt_middleware.py` (actualizar)
- `build/employees_app/routes/api/auth.py` (actualizar)

**Tiempo estimado**: 3 horas  
**Prioridad**: 🟢 BAJA

---

#### 4.2. Implementar Token Rotation
**Beneficio**: Mayor seguridad, previene replay attacks

**Acción**:
- Modificar endpoint `/api/auth/refresh`
- Invalidar refresh token anterior al generar uno nuevo
- Implementar "refresh token family" para detectar reutilización

**Archivo**: `build/employees_app/routes/api/auth.py`  
**Tiempo estimado**: 2 horas  
**Prioridad**: 🟢 BAJA

---

#### 4.3. Dashboard de Tokens Activos
**Beneficio**: Monitoreo y gestión de sesiones activas

**Acción**:
- Crear vista en `/system/tokens`
- Mostrar tokens activos por usuario
- Permitir revocación manual
- Métricas de login/logout

**Archivos**:
- `build/employees_app/routes/system/tokens.py` (nuevo)
- `build/employees_app/templates/system/tokens.html` (nuevo)

**Tiempo estimado**: 4 horas  
**Prioridad**: 🟢 BAJA

---

## 📊 Resumen de Tareas

### Por Prioridad

| Prioridad | Tareas | Tiempo Total |
|-----------|--------|--------------|
| 🔴 ALTA | 3 tareas | ~1.5 horas |
| 🟡 MEDIA-ALTA | 3 tareas | ~3.5 horas |
| 🟡 MEDIA | 3 tareas | ~4.5 horas |
| 🟢 BAJA | 4 tareas | ~10 horas |
| **TOTAL** | **13 tareas** | **~19.5 horas** |

### Por Categoría

| Categoría | Tareas | Tiempo Total |
|-----------|--------|--------------|
| Correcciones Críticas | 3 | ~1.5 horas |
| Testing | 3 | ~3.5 horas |
| Documentación | 4 | ~5.5 horas |
| Features Opcionales | 3 | ~9 horas |
| **TOTAL** | **13** | **~19.5 horas** |

---

## 🚀 Orden de Ejecución Recomendado

### Sprint 1: Correcciones Críticas (1 día)
1. ✅ Actualizar `secrets.env.example` (10 min)
2. ✅ Crear script de backup automático (30 min)
3. ✅ Agregar validación de variables en startup (45 min)

**Total Sprint 1**: ~1.5 horas

---

### Sprint 2: Testing Core (1 día)
4. ✅ Tests de refresh token (1 hora)
5. ✅ Tests de scope validation (1 hora)
6. ✅ Tests de role-based access (1.5 horas)

**Total Sprint 2**: ~3.5 horas

---

### Sprint 3: Documentación Esencial (1-2 días)
7. ✅ Actualizar AGENTS.md con JWT (1 hora)
8. ✅ Crear guía de variables de entorno (2 horas)
9. ✅ Actualizar ARCHITECTURE.md (1.5 horas)

**Total Sprint 3**: ~4.5 horas

---

### Sprint 4: Documentación Complementaria (Opcional)
10. ✅ Crear guía de migración JWT (1 hora)

**Total Sprint 4**: ~1 hora

---

### Sprint 5: Features Opcionales (Opcional)
11. ⚪ Implementar token blacklist (3 horas)
12. ⚪ Implementar token rotation (2 horas)
13. ⚪ Dashboard de tokens activos (4 horas)

**Total Sprint 5**: ~9 horas

---

## ✅ Checklist de Progreso

### Fase 1: Correcciones Críticas ✅ COMPLETADO
- [x] Actualizar `secrets.env.example`
- [x] Crear script de backup automático
- [x] Agregar validación de variables en startup

### Fase 2: Testing JWT ✅ COMPLETADO
- [x] Tests de refresh token
- [x] Tests de scope validation
- [x] Tests de role-based access

### Fase 3: Documentación
- [ ] Actualizar AGENTS.md con JWT
- [ ] Crear guía de variables de entorno
- [ ] Actualizar ARCHITECTURE.md
- [ ] Crear guía de migración JWT

### Fase 4: Features Opcionales
- [ ] Implementar token blacklist
- [ ] Implementar token rotation
- [ ] Dashboard de tokens activos

---

## 📝 Notas Finales

### Recomendaciones
1. **Ejecutar Sprints 1-3 primero** - Son críticos y de alta prioridad
2. **Sprint 4 es opcional** - Útil pero no crítico
3. **Sprint 5 es nice-to-have** - Solo si hay tiempo y recursos

### Dependencias
- Sprint 2 puede ejecutarse en paralelo con Sprint 1
- Sprint 3 depende de Sprint 1 (necesita variables validadas)
- Sprint 4 es independiente
- Sprint 5 depende de Sprint 2 (necesita tests base)

### Métricas de Éxito
- ✅ Todas las variables críticas validadas en startup
- ✅ Cobertura de tests JWT > 80%
- ✅ Documentación completa y actualizada
- ✅ Backup automático de archivos .env funcionando

---

**Creado por**: Antigravity AI  
**Última actualización**: 2026-01-30 17:09:27  
**Próxima revisión**: Después de completar Sprint 1
