# Análisis de Variables de Entorno - Pronto App

**Fecha**: 2026-01-30  
**Incidente**: Archivos `general.env` y `secrets.env` eliminados por accidente y recuperados

---

## 📊 Estado Actual de los Archivos

### ✅ Archivos Presentes

1. **`config/general.env`** (1,126 bytes, 54 líneas)
2. **`config/secrets.env`** (1,087 bytes, 29 líneas)
3. **`config/secrets.env.example`** (1,502 bytes, 34 líneas)
4. **`config/general.env.bak.2025-11-04-192157`** (backup antiguo)
5. **`config/secrets.env.bak.2025-11-04-192157`** (backup antiguo)

---

## 🔍 Análisis de Recuperación

### ✅ Variables Correctamente Recuperadas

#### `general.env`
- ✅ Configuración de Docker Compose (COMPOSE_PROJECT_NAME, NETWORK_NAME)
- ✅ Configuración de apps (CLIENT_APP_*, EMPLOYEE_APP_*, API_APP_*, STATIC_APP_*)
- ✅ PostgreSQL configuration (POSTGRES_HOST, POSTGRES_PORT, POSTGRES_USER, etc.)
- ✅ URLs y paths (STATIC_BASE_URL, STATIC_ASSETS_PATH, STATIC_PUBLIC_URL)
- ✅ JWT configuration (JWT_ACCESS_TOKEN_EXPIRES_HOURS, JWT_REFRESH_TOKEN_EXPIRES_DAYS)
- ✅ Debug flags (DEBUG_MODE, FLASK_DEBUG)

#### `secrets.env`
- ✅ SECRET_KEY (para Flask y JWT)
- ✅ HANDOFF_PEPPER (para system handoff)
- ✅ PASSWORD_HASH_SALT (para hashing de passwords)
- ✅ CUSTOMER_DATA_KEY (para encriptación de datos de clientes)
- ✅ CORS_ALLOWED_ORIGINS
- ✅ NUM_PROXIES
- ✅ ALLOWED_HOSTS

---

## ⚠️ Variables Faltantes o Problemáticas

### 1. **Puertos Cambiados** (⚠️ Verificar)

**En `general.env` actual**:
```env
CLIENT_APP_HOST_PORT=6080
EMPLOYEE_APP_HOST_PORT=6081
```

**En backup antiguo**:
```env
CLIENT_APP_HOST_PORT=5080
EMPLOYEE_APP_HOST_PORT=5081
```

**Acción**: Los puertos actuales (6080, 6081) parecen ser los correctos según el docker-compose.yml. ✅

### 2. **Variables Eliminadas del Backup Antiguo** (✅ Correcto)

Las siguientes variables estaban en el backup antiguo pero **NO** deben estar en la versión actual:

- ❌ `MYSQL_*` (ya no se usa MySQL, se usa PostgreSQL)
- ❌ `SESSION_TYPE`, `SESSION_FILE_DIR`, etc. (ya no se usan sesiones de Flask, se usa JWT)
- ❌ `DEFAULT_EMPLOYEE_PASSWORD` (no debe estar en producción)

**Acción**: Estas variables fueron correctamente removidas. ✅

### 3. **Variables Nuevas Agregadas** (✅ Correcto)

Las siguientes variables son nuevas y están correctamente agregadas:

- ✅ `JWT_ACCESS_TOKEN_EXPIRES_HOURS=24`
- ✅ `JWT_REFRESH_TOKEN_EXPIRES_DAYS=7`
- ✅ `API_APP_NAME`, `API_APP_PORT`, `API_APP_HOST_PORT` (nuevo servicio API)
- ✅ `POSTGRES_*` (reemplazo de MySQL)

---

## 🐳 Verificación de Uso en Docker Compose

### ✅ Variables Correctamente Inyectadas

El `docker-compose.yml` carga correctamente los archivos:

```yaml
env_file:
  - config/general.env
  - config/secrets.env
```

Y sobrescribe/agrega variables específicas en cada servicio:

#### Client Service
- ✅ JWT_ACCESS_TOKEN_EXPIRES_HOURS
- ✅ JWT_REFRESH_TOKEN_EXPIRES_DAYS
- ✅ POSTGRES_* (todas las variables de PostgreSQL)
- ✅ REDIS_* (todas las variables de Redis)

#### Employee Service
- ✅ JWT_ACCESS_TOKEN_EXPIRES_HOURS
- ✅ JWT_REFRESH_TOKEN_EXPIRES_DAYS
- ✅ POSTGRES_* (todas las variables de PostgreSQL)
- ✅ REDIS_* (todas las variables de Redis)

#### API Service
- ✅ JWT_ACCESS_TOKEN_EXPIRES_HOURS
- ✅ JWT_REFRESH_TOKEN_EXPIRES_DAYS
- ✅ POSTGRES_* (todas las variables de PostgreSQL)
- ✅ REDIS_* (todas las variables de Redis)

---

## 🔐 Verificación de Uso en Código

### ✅ Variables Críticas Usadas Correctamente

#### 1. **SECRET_KEY**
**Usado en**:
- `build/shared/jwt_service.py` (línea 56) - Para firmar JWT
- `build/pronto_employees/app.py` (línea 72) - `app.config["SECRET_KEY"]`
- `build/pronto_clients/app.py` - Similar
- `build/api_app/app.py` - Similar

**Estado**: ✅ Correctamente configurado y usado

#### 2. **PASSWORD_HASH_SALT**
**Usado en**:
- `build/shared/security.py` (línea 24) - Para hash de passwords

**Validación**:
```python
salt = os.getenv("PASSWORD_HASH_SALT")
if not salt:
    raise RuntimeError(
        "PASSWORD_HASH_SALT environment variable not set. "
        "Generate with: python3 -c 'import secrets; print(secrets.token_urlsafe(32))'"
    )
```

**Estado**: ✅ Correctamente configurado y validado

#### 3. **CUSTOMER_DATA_KEY**
**Usado en**:
- `build/shared/security.py` (línea 40) - Para encriptar datos de clientes

**Estado**: ✅ Correctamente configurado

#### 4. **HANDOFF_PEPPER**
**Usado en**:
- `build/pronto_employees/app.py` (línea 51) - Validación en startup

**Validación**:
```python
handoff_pepper = os.getenv("HANDOFF_PEPPER", "")
if not os.getenv("DEBUG_MODE", "false").lower() == "true":
    if not handoff_pepper or handoff_pepper == "your-random-pepper-here-32chars-minimum":
        raise RuntimeError(
            "HANDOFF_PEPPER must be configured in production. "
            'Generate with: python3 -c "import secrets; print(secrets.token_urlsafe(32))"'
        )
```

**Estado**: ✅ Correctamente configurado y validado

#### 5. **JWT Variables**
**Usado en**:
- `build/shared/jwt_service.py` (líneas 18-19)

```python
JWT_ACCESS_TOKEN_EXPIRES_HOURS = int(os.getenv("JWT_ACCESS_TOKEN_EXPIRES_HOURS", "24"))
JWT_REFRESH_TOKEN_EXPIRES_DAYS = int(os.getenv("JWT_REFRESH_TOKEN_EXPIRES_DAYS", "7"))
```

**Estado**: ✅ Correctamente configurado con defaults

---

## ⚠️ Problemas Identificados

### 1. **Variable Faltante en `secrets.env.example`**

El archivo `secrets.env.example` **NO** incluye las siguientes variables que SÍ están en `secrets.env`:

- ❌ `PASSWORD_HASH_SALT`
- ❌ `CUSTOMER_DATA_KEY`

**Impacto**: Si alguien usa el archivo de ejemplo, la aplicación fallará al iniciar.

**Acción Requerida**: Actualizar `secrets.env.example` para incluir estas variables.

### 2. **Documentación de Variables**

No hay un documento centralizado que explique:
- Qué hace cada variable
- Cómo generarlas
- Cuáles son obligatorias vs opcionales
- Valores por defecto

**Acción Requerida**: Crear documento de referencia de variables de entorno.

---

## ✅ Conclusión de Análisis

### Estado General: **RECUPERACIÓN EXITOSA** ✅

Los archivos `general.env` y `secrets.env` fueron recuperados correctamente y contienen todas las variables necesarias para el funcionamiento de la aplicación con JWT.

### Cambios Correctos Respecto al Backup Antiguo:
1. ✅ Eliminación de variables de MySQL (ahora usa PostgreSQL)
2. ✅ Eliminación de variables de sesiones de Flask (ahora usa JWT)
3. ✅ Adición de variables JWT
4. ✅ Actualización de puertos (6080, 6081 en lugar de 5080, 5081)
5. ✅ Adición de servicio API

### Variables Críticas Verificadas:
- ✅ SECRET_KEY - Presente y usado
- ✅ HANDOFF_PEPPER - Presente y validado
- ✅ PASSWORD_HASH_SALT - Presente y usado
- ✅ CUSTOMER_DATA_KEY - Presente y usado
- ✅ JWT_ACCESS_TOKEN_EXPIRES_HOURS - Presente y usado
- ✅ JWT_REFRESH_TOKEN_EXPIRES_DAYS - Presente y usado

---

## 🔧 Acciones Recomendadas

### Alta Prioridad
1. ✅ **Actualizar `secrets.env.example`** - Agregar variables faltantes
2. ✅ **Crear backup automático** - Script para backup periódico de archivos .env

### Media Prioridad
3. ✅ **Documentar variables de entorno** - Crear guía de referencia
4. ✅ **Validación en startup** - Agregar validación de todas las variables críticas

### Baja Prioridad
5. **Migrar a gestor de secretos** - Considerar usar HashiCorp Vault o AWS Secrets Manager en producción

---

**Revisado por**: Antigravity AI  
**Última actualización**: 2026-01-30 17:09:27
