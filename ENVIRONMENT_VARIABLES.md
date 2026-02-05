# Guía de Variables de Entorno - Pronto App

**Última actualización**: 2026-01-30

Esta guía documenta todas las variables de entorno utilizadas en el proyecto Pronto, su propósito, valores por defecto y cómo configurarlas.

---

## 📁 Archivos de Configuración

### Estructura
```
.env                    # Configuración principal (versionado)
.env.example            # Plantilla de configuración
backups/                # Backups automáticos (NO versionado)
```

### Carga de Variables
Las variables se cargan desde `.env` y pueden ser sobrescritas por variables de entorno del sistema.

---

## 🔐 Variables de Seguridad (CRÍTICAS)

### SECRET_KEY
**Propósito**: Clave secreta para Flask y firma de JWT  
**Tipo**: String (32+ caracteres)  
**Obligatoria**: ✅ Sí  
**Archivo**: `.env`  
**Valor por defecto**: ❌ Ninguno (debe configurarse)

**Generar**:
```bash
python3 -c "import secrets; print(secrets.token_urlsafe(32))"
```

**Ejemplo**:
```bash
SECRET_KEY=lhlJHWqUOdYUveqkzz6nClgGpzheVFuxd5bRWJBNVEA
```

**Notas**:
- Usada para firmar JWT tokens
- Usada para sesiones de Flask (legacy)
- NUNCA usar valores por defecto en producción
- Cambiar esta clave invalida todos los tokens JWT existentes

---

### HANDOFF_PEPPER
**Propósito**: Pepper para tokens de handoff de system  
**Tipo**: String (32+ caracteres)  
**Obligatoria**: ✅ Sí (en producción)  
**Archivo**: `.env`  
**Valor por defecto**: ❌ Ninguno

**Generar**:
```bash
python3 -c "import secrets; print(secrets.token_urlsafe(32))"
```

**Ejemplo**:
```bash
HANDOFF_PEPPER=YW5vdGhlci1zZWN1cmUtcGVwcGVyLWZvci1oYW5kb2ZmLXRva2Vu
```

**Notas**:
- La aplicación falla al iniciar si no está configurada en producción
- Usada para generar tokens de handoff seguros
- Debe ser diferente de SECRET_KEY

---

### PASSWORD_HASH_SALT
**Propósito**: Salt para hashing de passwords  
**Tipo**: String (32+ caracteres)  
**Obligatoria**: ✅ Sí  
**Archivo**: `.env`  
**Valor por defecto**: ❌ Ninguno

**Generar**:
```bash
python3 -c "import secrets; print(secrets.token_urlsafe(32))"
```

**Ejemplo**:
```bash
PASSWORD_HASH_SALT=AUILydszwFkPNU0s6NlNFKvDB0DcA0dlp3Kan99q2ZY
```

**Notas**:
- Usada por `shared/security.py` para hash de passwords
- NUNCA cambiar en producción (invalida todos los passwords)
- Debe ser única por instalación

---

### CUSTOMER_DATA_KEY
**Propósito**: Clave para encriptar datos sensibles de clientes  
**Tipo**: String (32+ caracteres)  
**Obligatoria**: ✅ Sí  
**Archivo**: `.env`  
**Valor por defecto**: ❌ Ninguno

**Generar**:
```bash
python3 -c "import secrets; print(secrets.token_urlsafe(32))"
```

**Ejemplo**:
```bash
CUSTOMER_DATA_KEY=c3VwcGxlLW1vcmUtZGF0YS1lbmNyeXB0aW9uLWtleS1mb3ItY3VzdG9tZXI
```

**Notas**:
- Usada para encriptar datos de clientes (teléfonos, emails, etc.)
- NUNCA cambiar en producción (hace datos ilegibles)
- Debe ser única por instalación

---

## 🔑 Variables JWT

### JWT_ACCESS_TOKEN_EXPIRES_HOURS
**Propósito**: Tiempo de expiración de access tokens  
**Tipo**: Integer  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `24` (24 horas)

**Rango recomendado**: 1-168 horas (1 hora a 7 días)

**Ejemplo**:
```bash
JWT_ACCESS_TOKEN_EXPIRES_HOURS=24
```

**Notas**:
- Tokens más cortos = más seguro pero más inconveniente
- Tokens más largos = más conveniente pero menos seguro
- Usar refresh tokens para renovar sin re-login

---

### JWT_REFRESH_TOKEN_EXPIRES_DAYS
**Propósito**: Tiempo de expiración de refresh tokens  
**Tipo**: Integer  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `7` (7 días)

**Rango recomendado**: 1-90 días

**Ejemplo**:
```bash
JWT_REFRESH_TOKEN_EXPIRES_DAYS=7
```

**Notas**:
- Debe ser mayor que JWT_ACCESS_TOKEN_EXPIRES_HOURS
- Permite renovar access tokens sin re-login
- Después de expirar, usuario debe hacer login nuevamente

---

## 🗄️ Variables de Base de Datos

### POSTGRES_HOST
**Propósito**: Hostname del servidor PostgreSQL  
**Tipo**: String  
**Obligatoria**: ✅ Sí  
**Archivo**: `.env`  
**Valor por defecto**: `postgres` (nombre del contenedor Docker)

**Ejemplos**:
```bash
# Docker Compose
POSTGRES_HOST=postgres

# Producción
POSTGRES_HOST=db.example.com

# Local
POSTGRES_HOST=localhost
```

---

### POSTGRES_PORT
**Propósito**: Puerto del servidor PostgreSQL  
**Tipo**: Integer  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `5432`

**Ejemplo**:
```bash
POSTGRES_PORT=5432
```

---

### POSTGRES_USER
**Propósito**: Usuario de PostgreSQL  
**Tipo**: String  
**Obligatoria**: ✅ Sí  
**Archivo**: `.env`  
**Valor por defecto**: `pronto`

**Ejemplo**:
```bash
POSTGRES_USER=pronto
```

---

### POSTGRES_PASSWORD
**Propósito**: Password de PostgreSQL  
**Tipo**: String  
**Obligatoria**: ✅ Sí  
**Archivo**: `.env` (en producción) o `general.env` (desarrollo)  
**Valor por defecto**: `pronto123` (solo desarrollo)

**Ejemplo**:
```bash
POSTGRES_PASSWORD=pronto123
```

**Notas**:
- En producción, usar password fuerte y guardar en `secrets.env`
- Nunca versionar passwords de producción

---

### POSTGRES_DB
**Propósito**: Nombre de la base de datos  
**Tipo**: String  
**Obligatoria**: ✅ Sí  
**Archivo**: `.env`  
**Valor por defecto**: `pronto`

**Ejemplo**:
```bash
POSTGRES_DB=pronto
```

---

### USE_LOCAL_POSTGRES
**Propósito**: Usar PostgreSQL local en lugar de Supabase  
**Tipo**: Boolean  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `true`

**Ejemplo**:
```bash
USE_LOCAL_POSTGRES=true
```

---

## 🌐 Variables de Aplicación

### RESTAURANT_NAME
**Propósito**: Nombre del restaurante  
**Tipo**: String  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `cafeteria-test`

**Ejemplo**:
```bash
RESTAURANT_NAME=cafeteria-test
```

**Notas**:
- Se usa para generar `RESTAURANT_SLUG` automáticamente
- Aparece en templates y emails

---

### TAX_RATE
**Propósito**: Tasa de impuesto (IVA)  
**Tipo**: Float  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `0.16` (16%)

**Ejemplo**:
```bash
TAX_RATE=0.16
```

---

### STATIC_BASE_URL
**Propósito**: URL base para archivos estáticos  
**Tipo**: String (URL)  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `http://static:80`

**Ejemplos**:
```bash
# Docker Compose
STATIC_BASE_URL=http://static:80

# Producción
STATIC_BASE_URL=https://cdn.example.com

# Desarrollo local
STATIC_BASE_URL=http://localhost:9088
```

---

### LOG_LEVEL
**Propósito**: Nivel de logging  
**Tipo**: String (DEBUG, INFO, WARNING, ERROR, CRITICAL)  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `INFO`

**Ejemplo**:
```bash
LOG_LEVEL=INFO
```

**Valores válidos**:
- `DEBUG` - Todos los logs (muy verboso)
- `INFO` - Información general
- `WARNING` - Solo advertencias y errores
- `ERROR` - Solo errores
- `CRITICAL` - Solo errores críticos

---

### DEBUG_MODE
**Propósito**: Habilitar modo debug  
**Tipo**: Boolean  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `false`

**Ejemplo**:
```bash
DEBUG_MODE=false
```

**Notas**:
- En producción SIEMPRE debe ser `false`
- Habilita autocompletado de formularios
- Muestra información de debug en logs

---

### FLASK_DEBUG
**Propósito**: Habilitar debug de Flask  
**Tipo**: Boolean  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `false`

**Ejemplo**:
```bash
FLASK_DEBUG=false
```

**Notas**:
- En producción SIEMPRE debe ser `false`
- Habilita auto-reload y debugger de Flask
- NUNCA habilitar en producción (riesgo de seguridad)

---

## 🔒 Variables de Seguridad (Opcionales)

### CORS_ALLOWED_ORIGINS
**Propósito**: Orígenes permitidos para CORS  
**Tipo**: String (lista separada por comas)  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `` (vacío, usa lista interna en desarrollo)

**Ejemplo**:
```bash
CORS_ALLOWED_ORIGINS=https://app.example.com,https://admin.example.com
```

**Notas**:
- En desarrollo, se usa lista interna (localhost:6080, localhost:6081)
- En producción, especificar orígenes explícitamente
- NO incluir espacios después de comas

---

### NUM_PROXIES
**Propósito**: Número de proxies confiables  
**Tipo**: Integer  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `0`

**Ejemplos**:
```bash
# Sin proxy (desarrollo local)
NUM_PROXIES=0

# Un proxy (nginx directo)
NUM_PROXIES=1

# Dos proxies (nginx + cloudflare)
NUM_PROXIES=2
```

**Notas**:
- Solo activar si el proxy sobrescribe headers X-Forwarded-*
- Afecta cómo Flask detecta IP real del cliente

---

### ALLOWED_HOSTS
**Propósito**: Hosts permitidos para validación Origin/Referer  
**Tipo**: String (lista separada por comas)  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `localhost:6081,127.0.0.1:6081`

**Ejemplo**:
```bash
ALLOWED_HOSTS=localhost:6081,127.0.0.1:6081,app.example.com
```

**Notas**:
- Incluir puerto si no es estándar (80/443)
- NO incluir espacios después de comas

---

## 🐳 Variables de Docker Compose

### COMPOSE_PROJECT_NAME
**Propósito**: Nombre del proyecto Docker Compose  
**Tipo**: String  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `pronto`

**Ejemplo**:
```bash
COMPOSE_PROJECT_NAME=pronto
```

---

### CLIENT_APP_HOST_PORT
**Propósito**: Puerto del host para la app de clientes  
**Tipo**: Integer  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `6080`

**Ejemplo**:
```bash
CLIENT_APP_HOST_PORT=6080
```

**Acceso**: `http://localhost:6080`

---

### EMPLOYEE_APP_HOST_PORT
**Propósito**: Puerto del host para la app de empleados  
**Tipo**: Integer  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `6081`

**Ejemplo**:
```bash
EMPLOYEE_APP_HOST_PORT=6081
```

**Acceso**: `http://localhost:6081`

---

### API_APP_HOST_PORT
**Propósito**: Puerto del host para la API  
**Tipo**: Integer  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `6082`

**Ejemplo**:
```bash
API_APP_HOST_PORT=6082
```

**Acceso**: `http://localhost:6082`

---

### STATIC_APP_HOST_PORT
**Propósito**: Puerto del host para el servidor estático  
**Tipo**: Integer  
**Obligatoria**: ❌ No  
**Archivo**: `.env`  
**Valor por defecto**: `9088`

**Ejemplo**:
```bash
STATIC_APP_HOST_PORT=9088
```

**Acceso**: `http://localhost:9088`

---

## 🔧 Variables de Desarrollo

### LOAD_SEED_DATA
**Propósito**: Cargar datos de prueba al iniciar  
**Tipo**: Boolean  
**Obligatoria**: ❌ No  
**Archivo**: Variable de entorno (no en archivos)  
**Valor por defecto**: `false`

**Uso**:
```bash
LOAD_SEED_DATA=true bin/up.sh
```

**Notas**:
- Solo para desarrollo
- Carga empleados, mesas, menú de prueba
- Usa modo UPSERT (no duplica datos)

---

### DEBUG_AUTO_TABLE
**Propósito**: Asignar mesa automáticamente en desarrollo  
**Tipo**: Boolean  
**Obligatoria**: ❌ No  
**Archivo**: Variable de entorno  
**Valor por defecto**: `false`

**Ejemplo**:
```bash
DEBUG_AUTO_TABLE=true
```

---

## 📋 Checklist de Configuración

### Desarrollo Local
- [ ] `SECRET_KEY` - Generar con comando
- [ ] `HANDOFF_PEPPER` - Generar con comando
- [ ] `PASSWORD_HASH_SALT` - Generar con comando
- [ ] `CUSTOMER_DATA_KEY` - Generar con comando
- [ ] `POSTGRES_*` - Usar valores por defecto
- [ ] `DEBUG_MODE=true` - Habilitar para desarrollo
- [ ] `FLASK_DEBUG=true` - Habilitar para auto-reload

### Producción
- [ ] `SECRET_KEY` - Valor único y seguro
- [ ] `HANDOFF_PEPPER` - Valor único y seguro
- [ ] `PASSWORD_HASH_SALT` - Valor único y seguro
- [ ] `CUSTOMER_DATA_KEY` - Valor único y seguro
- [ ] `POSTGRES_PASSWORD` - Password fuerte
- [ ] `DEBUG_MODE=false` - CRÍTICO
- [ ] `FLASK_DEBUG=false` - CRÍTICO
- [ ] `CORS_ALLOWED_ORIGINS` - Configurar explícitamente
- [ ] `ALLOWED_HOSTS` - Configurar explícitamente
- [ ] `NUM_PROXIES` - Configurar según infraestructura

---

## 🛠️ Herramientas

### Generar Secretos
```bash
# Generar un secreto
python3 -c "import secrets; print(secrets.token_urlsafe(32))"

# Generar múltiples secretos
for i in {1..4}; do python3 -c "import secrets; print(secrets.token_urlsafe(32))"; done
```

### Validar Configuración
```bash
# Validar que todas las variables críticas están configuradas
python3 -c "from build.shared.config import validate_required_env_vars; validate_required_env_vars()"
```

### Backup de Configuración
```bash
# Crear backup manual
./bin/backup-env.sh

# Ver backups
ls -lh config/backups/
```

---

## 🚨 Troubleshooting

### Error: "SECRET_KEY must be configured"
**Causa**: Variable SECRET_KEY no está configurada o tiene valor por defecto  
**Solución**:
```bash
# Generar nueva clave
python3 -c "import secrets; print(secrets.token_urlsafe(32))"

# Agregar a .env
echo "SECRET_KEY=<valor-generado>" >> .env
```

### Error: "HANDOFF_PEPPER must be configured in production"
**Causa**: Variable HANDOFF_PEPPER no está configurada  
**Solución**:
```bash
# Generar pepper
python3 -c "import secrets; print(secrets.token_urlsafe(32))"

# Agregar a .env
echo "HANDOFF_PEPPER=<valor-generado>" >> .env
```

### Error: "POSTGRES_HOST must be configured"
**Causa**: Variables de PostgreSQL no están configuradas  
**Solución**: Verificar que `.env` contiene todas las variables POSTGRES_*

### Warning: "JWT_ACCESS_TOKEN_EXPIRES_HOURS=X is outside recommended range"
**Causa**: Valor fuera del rango recomendado (1-168 horas)  
**Solución**: Ajustar valor a rango recomendado o ignorar si es intencional

---

## 📚 Referencias

- **Documentación JWT**: `docs/JWT_IMPLEMENTATION_REVIEW.md`
- **Análisis de Variables**: `docs/ENV_VARIABLES_ANALYSIS.md`
- **Plan de Acción**: `docs/ACTION_PLAN.md`
- **Código de Validación**: `build/shared/config.py`

---

**Última actualización**: 2026-01-30  
**Versión**: 1.0
