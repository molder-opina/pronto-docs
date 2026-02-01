# Guía de Agentes de Pre-Commit - Pronto App

**Última actualización**: 2026-01-30

Esta guía documenta qué valida cada agente del "Review Committee" en los pre-commit hooks.

---

## 📋 Resumen de Agentes

El proyecto incluye **14 agentes especializados** que revisan el código antes de cada commit:

| Agente | Emoji | Archivo | Enfoque |
|--------|-------|---------|---------|
| Developer | 👨‍💻 | `bin/agents/developer.sh` | Código Python |
| Designer | 👩‍🎨 | `bin/agents/designer.sh` | UI/UX y assets |
| DB Specialist | 🗄️ | `bin/agents/db_specialist.sh` | Base de datos |
| Sysadmin | 🛡️ | `bin/agents/sysadmin.sh` | Seguridad y config |
| QA/Tester | 🧪 | `bin/agents/qa_tester.sh` | Tests |
| Scribe | ✍️ | `bin/agents/scribe.sh` | Documentación |
| Container Specialist | 🐳 | `bin/agents/container_specialist.sh` | Docker |
| Business Expert | 🍽️ | `bin/agents/business_expert.sh` | Lógica de negocio |
| Waiter | 🤵 | `bin/agents/waiter_agent.sh` | Console waiter |
| Admin | 👨‍💼 | `bin/agents/admin_agent.sh` | Console admin |
| Cashier | 💰 | `bin/agents/cashier_agent.sh` | Console cashier |
| Super Admin | 👑 | `bin/agents/super_admin_agent.sh` | Sistema y seguridad |
| Chef | 👨‍🍳 | `bin/agents/chef_agent.sh` | Console chef |
| **Deployment** | 🚀 | `bin/agents/deployment_agent.sh` | **Scripts de init** |

---

## 👨‍💻 Developer Agent

**Archivo**: `bin/agents/developer.sh`

### Validaciones

#### 1. TODOs y FIXMEs (Warning)
**Qué valida**: Busca marcadores `TODO` y `FIXME` en archivos Python

**Archivos**: `*.py`

**Ejemplo de fallo**:
```python
# TODO: Implementar validación
def process_order():
    pass
```

**Acción**: Warning (no bloquea commit)

---

#### 2. Print Statements (Error)
**Qué valida**: Detecta `print()` statements en código Python de producción

**Archivos**: `build/**/*.py` (excepto `__pycache__`, tests, scripts)

**Ejemplo de fallo**:
```python
def create_order(data):
    print("Creating order...")  # ❌ No permitido
    return order
```

**Acción**: Bloquea commit

**Solución**: Usar logging en lugar de print
```python
import logging
logger = logging.getLogger(__name__)

def create_order(data):
    logger.info("Creating order...")  # ✅ Correcto
    return order
```

---

## 👩‍🎨 Designer Agent

**Archivo**: `bin/agents/designer.sh`

### Validaciones

#### 1. Imágenes No Optimizadas (Warning)
**Qué valida**: Detecta imágenes mayores a 1MB

**Archivos**: `*.jpg`, `*.jpeg`, `*.png`, `*.gif`, `*.webp`

**Acción**: Warning (no bloquea)

**Solución**: Optimizar imágenes antes de commit

---

#### 2. Uso Excesivo de !important (Warning)
**Qué valida**: Detecta más de 3 usos de `!important` en un archivo CSS

**Archivos**: `*.css`

**Ejemplo de fallo**:
```css
.button { color: red !important; }
.link { color: blue !important; }
.text { color: green !important; }
.title { color: black !important; }  /* ❌ 4to uso */
```

**Acción**: Warning

---

#### 3. Accesibilidad - Alt Tags (Warning)
**Qué valida**: Detecta `<img>` sin atributo `alt`

**Archivos**: `*.html`

**Ejemplo de fallo**:
```html
<img src="logo.png">  <!-- ❌ Sin alt -->
```

**Solución**:
```html
<img src="logo.png" alt="Logo de Pronto">  <!-- ✅ Con alt -->
```

---

## 🗄️ DB Specialist Agent

**Archivo**: `bin/agents/db_specialist.sh`

### Validaciones

#### 1. Migraciones sin Timestamp (Error)
**Qué valida**: Verifica que archivos de migración tengan timestamp en el nombre

**Archivos**: `migrations/*.sql`, `migrations/*.py`

**Ejemplo de fallo**:
```
migrations/add_column.sql  # ❌ Sin timestamp
```

**Solución**:
```
migrations/20260130_add_column.sql  # ✅ Con timestamp
```

---

#### 2. Operaciones Destructivas (Warning)
**Qué valida**: Detecta `DROP TABLE`, `DROP DATABASE`, `TRUNCATE`

**Archivos**: `*.sql`

**Ejemplo de fallo**:
```sql
DROP TABLE orders;  -- ⚠️ Warning
```

**Acción**: Warning (requiere revisión manual)

---

#### 3. Existencia de models.py (Error)
**Qué valida**: Verifica que exista `build/shared/models.py`

**Acción**: Bloquea si no existe

---

## 🛡️ Sysadmin Agent

**Archivo**: `bin/agents/sysadmin.sh`

### Validaciones

#### 1. Archivos .env Versionados (Error)
**Qué valida**: Previene commit de archivos `.env` (excepto `.env.example`)

**Archivos**: `*.env` (excepto `*.env.example`)

**Ejemplo de fallo**:
```
git add config/secrets.env  # ❌ Bloqueado
```

**Solución**: Nunca versionar archivos `.env` con secretos

---

#### 2. Dockerfiles sin USER (Warning)
**Qué valida**: Detecta Dockerfiles que no definen usuario no-root

**Archivos**: `Dockerfile`, `*.dockerfile`

**Ejemplo de fallo**:
```dockerfile
FROM python:3.11
COPY . /app
CMD ["python", "app.py"]
# ⚠️ Sin USER (corre como root)
```

**Solución**:
```dockerfile
FROM python:3.11
RUN useradd -m appuser
USER appuser  # ✅ Usuario no-root
COPY . /app
CMD ["python", "app.py"]
```

---

#### 3. Scripts sin Shebang (Warning)
**Qué valida**: Verifica que scripts shell tengan shebang

**Archivos**: `*.sh`

**Ejemplo de fallo**:
```bash
# deploy.sh
echo "Deploying..."  # ❌ Sin shebang
```

**Solución**:
```bash
#!/usr/bin/env bash  # ✅ Con shebang
echo "Deploying..."
```

---

## 🧪 QA/Tester Agent

**Archivo**: `bin/agents/qa_tester.sh`

### Validaciones

#### 1. Tests Enfocados (Error)
**Qué valida**: Detecta `.only`, `fit`, `fdescribe` que skip el resto de tests

**Archivos**: `*.test.ts`, `*.test.js`, `*.spec.ts`, `*.spec.js`

**Ejemplo de fallo**:
```typescript
describe.only('Orders', () => {  // ❌ Bloqueado
  it('should create order', () => {
    // ...
  });
});
```

**Solución**:
```typescript
describe('Orders', () => {  // ✅ Sin .only
  it('should create order', () => {
    // ...
  });
});
```

---

## ✍️ Scribe Agent

**Archivo**: `bin/agents/scribe.sh`

### Validaciones

#### 1. TODOs en Documentación (Warning)
**Qué valida**: Detecta `TODO` en archivos de documentación

**Archivos**: `*.md`, `docs/**/*`

**Acción**: Warning

---

#### 2. Existencia de AGENTS.md (Error)
**Qué valida**: Verifica que exista `AGENTS.md`

**Acción**: Bloquea si no existe

---

## 🐳 Container Specialist Agent

**Archivo**: `bin/agents/container_specialist.sh`

### Validaciones

#### 1. Tags 'latest' en docker-compose (Warning)
**Qué valida**: Detecta uso de `:latest` en imágenes

**Archivos**: `docker-compose.yml`, `docker-compose.*.yml`

**Ejemplo de fallo**:
```yaml
services:
  redis:
    image: redis:latest  # ⚠️ Warning
```

**Solución**:
```yaml
services:
  redis:
    image: redis:7-alpine  # ✅ Versión específica
```

---

#### 2. Limpieza de apt-get (Warning)
**Qué valida**: Verifica que Dockerfiles limpien cache de apt

**Archivos**: `Dockerfile`, `*.dockerfile`

**Ejemplo de fallo**:
```dockerfile
RUN apt-get update && apt-get install -y python3
# ⚠️ Sin limpieza
```

**Solución**:
```dockerfile
RUN apt-get update && apt-get install -y python3 \
    && rm -rf /var/lib/apt/lists/*  # ✅ Con limpieza
```

---

#### 3. Múltiples CMD/ENTRYPOINT (Warning)
**Qué valida**: Detecta múltiples `CMD` o `ENTRYPOINT` (solo el último es válido)

**Archivos**: `Dockerfile`, `*.dockerfile`

---

#### 4. HEALTHCHECK en compose (Warning)
**Qué valida**: Verifica que servicios tengan healthcheck

**Archivos**: `docker-compose.yml`

---

## 🍽️ Business Expert Agent

**Archivo**: `bin/agents/business_expert.sh`

### Validaciones

#### 1. Términos de Dominio (Warning)
**Qué valida**: Verifica uso de términos clave del negocio

**Términos**: `propina`, `mesa`, `comanda`, `orden`, `cuenta`

**Archivos**: `build/**/*.py`

**Acción**: Warning si no se usan

---

#### 2. Funciones de Formato de Moneda (Warning)
**Qué valida**: Verifica que existan funciones de formato de moneda

**Archivos**: `build/shared/**/*.py`

---

#### 3. Configuración de Negocio (Error)
**Qué valida**: Verifica existencia de `business_config_service.py`

**Archivo**: `build/shared/services/business_config_service.py`

**Acción**: Bloquea si no existe

---

## 🤵 Waiter Agent

**Archivo**: `bin/agents/waiter_agent.sh`

### Validaciones

#### 1. Templates de Waiter (Warning)
**Qué valida**: Verifica existencia de templates del mesero

**Archivos**:
- `build/employees_app/templates/dashboard_waiter.html`
- `build/employees_app/templates/includes/_waiter_section.html`

---

#### 2. Módulo waiter-board.ts (Warning)
**Qué valida**: Verifica existencia del módulo TypeScript

**Archivo**: `build/shared/static/js/src/modules/waiter-board.ts`

---

#### 3. Lógica de Asignación de Mesas (Warning)
**Qué valida**: Busca funciones de asignación de mesas

**Términos**: `assign_table`, `table_assignment`

---

## 👨‍💼 Admin Agent

**Archivo**: `bin/agents/admin_agent.sh`

### Validaciones

#### 1. Templates de Admin (Warning)
**Qué valida**: Verifica existencia de templates de admin

**Archivos**:
- `build/employees_app/templates/dashboard_admin.html`
- `build/employees_app/templates/includes/_admin_sections.html`

---

#### 2. Sistema de Permisos (Error)
**Qué valida**: Verifica existencia del sistema de permisos

**Archivo**: `build/shared/permissions.py`

**Acción**: Bloquea si no existe

---

#### 3. Configuración de Negocio (Error)
**Qué valida**: Verifica existencia de business config

**Archivo**: `build/shared/services/business_config_service.py`

---

## 💰 Cashier Agent

**Archivo**: `bin/agents/cashier_agent.sh`

### Validaciones

#### 1. Templates de Cashier (Warning)
**Qué valida**: Verifica existencia de templates de cajero

**Archivos**:
- `build/employees_app/templates/dashboard_cashier.html`
- `build/employees_app/templates/includes/_cashier_section.html`

---

#### 2. Módulo cashier-board.ts (Warning)
**Qué valida**: Verifica existencia del módulo TypeScript

**Archivo**: `build/shared/static/js/src/modules/cashier-board.ts`

---

#### 3. Integración de Pagos (Warning)
**Qué valida**: Busca integración con proveedores de pago

**Términos**: `stripe`, `payment_provider`, `process_payment`

---

## 👑 Super Admin Agent

**Archivo**: `bin/agents/super_admin_agent.sh`

### Validaciones

#### 1. Blueprint de Sistema (Error)
**Qué valida**: Verifica que exista el blueprint `system_bp`

**Archivo**: `build/employees_app/app.py`

**Búsqueda**: `system_bp`

**Acción**: Bloquea si no existe

---

#### 2. JWT Scope Guard (Error)
**Qué valida**: Verifica que el Scope Guard esté aplicado

**Archivo**: `build/employees_app/app.py`

**Búsqueda**: `apply_jwt_scope_guard`

**Acción**: Bloquea si no existe

**Ejemplo correcto**:
```python
from shared.jwt_middleware import apply_jwt_scope_guard

def create_app():
    app = Flask(__name__)
    # ...
    apply_jwt_scope_guard(app)  # ✅ Requerido
    # ...
    return app
```

---

#### 3. Security Middleware (Error)
**Qué valida**: Verifica existencia de middleware de seguridad

**Archivo**: `build/shared/security_middleware.py`

**Acción**: Bloquea si no existe

---

## 👨‍🍳 Chef Agent

**Archivo**: `bin/agents/chef_agent.sh`

### Validaciones

#### 1. Templates de Chef (Warning)
**Qué valida**: Verifica existencia de templates de cocina

**Archivos**:
- `build/employees_app/templates/dashboard_chef.html`
- `build/employees_app/templates/includes/_chef_section.html`

---

#### 2. Módulo kitchen-board.ts (Warning)
**Qué valida**: Verifica existencia del módulo TypeScript

**Archivo**: `build/shared/static/js/src/modules/kitchen-board.ts`

---

#### 3. Transiciones de Estado de Órdenes (Warning)
**Qué valida**: Busca lógica de transiciones de estado

**Términos**: `order_status`, `OrderStatus`, `transition`

---

## 🚀 Deployment Agent

**Archivo**: `bin/agents/deployment_agent.sh`

### Validaciones

#### 1. Nuevas Migraciones de Base de Datos (Warning)
**Qué valida**: Detecta nuevas migraciones y verifica que estén referenciadas en `bin/init/`

**Archivos**: `migrations/*.sql`, `migrations/*.py`

**Acción**: Warning si no están documentadas en scripts de init

**Solución**:
```bash
# Actualizar bin/init/03_seed_params.sh o 04_deploy.sh
# para incluir la migración
```

---

#### 2. Nuevas Variables de Entorno (Warning)
**Qué valida**: Detecta cambios en `config/secrets.env.example`

**Acción**: Warning si no se validan en `bin/init/`

**Solución**:
```bash
# Asegurar que bin/init/02_apply_envs.sh valide las nuevas variables
# o que validate_required_env_vars() las incluya
```

---

#### 3. Nuevos Servicios Docker (Warning)
**Qué valida**: Detecta nuevos servicios en `docker-compose.yml`

**Acción**: Warning si no están documentados en `bin/init/`

**Solución**:
```bash
# Actualizar bin/init/04_deploy.sh para incluir el nuevo servicio
# Documentar en docs/DEPLOYMENT.md
```

---

#### 4. Nuevos Modelos de Base de Datos (Warning)
**Qué valida**: Detecta nuevas clases en `build/shared/models.py`

**Acción**: Warning si no hay seed data correspondiente

**Solución**:
```bash
# Actualizar bin/init/03_seed_params.sh con seed data
# o load_seed_data() si es necesario
```

---

#### 5. Cambios en Servicios Críticos (Warning)
**Qué valida**: Detecta cambios en servicios críticos:
- `business_config_service.py`
- `secret_service.py`
- `settings_service.py`

**Acción**: Warning si no se sincronizan en `bin/init/`

**Solución**:
```bash
# Asegurar que bin/init/ llame a sync_env_config_to_db()
# o sync_env_secrets_to_db() si es necesario
```

---

#### 6. Nuevas Dependencias Python (Warning)
**Qué valida**: Detecta cambios en `requirements.txt`

**Acción**: Warning si no se instalan en `bin/init/`

**Solución**:
```bash
# Asegurar que Dockerfiles se reconstruyan
# o que bin/init/ incluya pip install
```

---

#### 7. Nuevas Dependencias Frontend (Warning)
**Qué valida**: Detecta cambios en `package.json`

**Acción**: Warning si no se instalan en `bin/init/`

**Solución**:
```bash
# Asegurar que bin/init/ incluya npm install o npm ci
```

---

#### 8. Existencia de Scripts de Init (Error)
**Qué valida**: Verifica que existan todos los scripts de inicialización

**Scripts requeridos**:
- `bin/init/init.sh`
- `bin/init/01_backup_envs.sh`
- `bin/init/02_apply_envs.sh`
- `bin/init/03_seed_params.sh`
- `bin/init/04_deploy.sh`

**Acción**: Bloquea si faltan scripts

---

### Ejemplo de Output

```bash
🚀 [AGENTE DEPLOYMENT] Validando scripts de inicialización...
   📦 Detectadas nuevas migraciones de base de datos
   🔐 Detectados cambios en secrets.env.example

   ⚠️ ADVERTENCIA: Cambios detectados que pueden requerir actualización de scripts de inicialización:
   - Migraciones de BD no referenciadas en bin/init/
   - Nuevas variables de entorno no validadas en bin/init/

   📝 Acción requerida:
      1. Revisar si los cambios requieren pasos de inicialización
      2. Actualizar bin/init/ si es necesario
      3. Documentar en docs/DEPLOYMENT.md

   ℹ️ Si los cambios NO requieren actualización de init, puedes ignorar este warning.

🚀 [AGENTE DEPLOYMENT] Visto Bueno (VoBo) ✅
```

---

## 🔧 Soluciones Comunes

### Arreglar Warnings de Pre-commit
```bash
# Migrar configuración deprecated
pre-commit migrate-config
```

### Ejecutar Agentes Manualmente
```bash
# Un agente específico
./bin/agents/developer.sh

# Todos los agentes
pre-commit run --all-files
```

### Bypass de Hooks (NO RECOMENDADO)
```bash
# Solo en casos excepcionales
git commit --no-verify
```

---

## 📊 Resumen de Severidad

| Severidad | Agentes | Acción |
|-----------|---------|--------|
| **Error (Bloquea)** | Developer, DB Specialist, Sysadmin, QA/Tester, Scribe, Business Expert, Admin, Super Admin | Commit bloqueado |
| **Warning (Advierte)** | Designer, DB Specialist, Sysadmin, Container Specialist, Business Expert, Waiter, Admin, Cashier, Chef | Commit permitido con warning |

---

## 🎯 Mejores Prácticas

1. **Ejecutar pre-commit antes de commit**:
   ```bash
   pre-commit run --all-files
   ```

2. **Revisar warnings**: Aunque no bloquean, indican problemas potenciales

3. **Mantener agentes actualizados**: Revisar periódicamente las validaciones

4. **Documentar excepciones**: Si se necesita bypass, documentar por qué

---

**Última actualización**: 2026-01-30  
**Versión**: 1.0
