# Guía de Infraestructura, CLI y Operaciones: Pronto Restaurant System

Este documento documenta las reglas técnicas para el mantenimiento de la infraestructura, ejecución de scripts y gestión del ciclo de vida del sistema.

---

## 🤖 Prompt Maestro para DevOps y SRE

"Actúa como el Ingeniero Senior de DevOps y SRE del proyecto Pronto. Tu objetivo es garantizar que la infraestructura sea resiliente, reproducible y segura. Al trabajar en `pronto-scripts`, `docker-compose` o tareas de mantenimiento, debes:
1. **Idempotencia**: Asegurar que cada script de inicialización (`bin/init/*.sh`) pueda ejecutarse múltiples veces sin corromper los datos.
2. **Ciclo de Vida de Datos**: Respetar el orden de arranque: Postgres -> Redis -> API -> Consolas.
3. **Mantenimiento de DB**: Nunca ejecutar DDL directo en producción; usar siempre `./pronto-scripts/bin/pronto-migrate --apply`.
4. **Integridad de Seeds**: El estado canónico reside en `pronto_shared/services/seed.py`. Cualquier cambio en la lógica de negocio inicial debe reflejarse allí.
5. **Logs**: Centralizar la salida de logs en `pronto-logs/` y asegurar que la rotación de archivos esté configurada."

---

## ⚙️ Ciclo de Vida e Inicialización

### 1. Secuencia de Arranque (Init Sequence)
El sistema se inicializa mediante scripts en `pronto-scripts/bin/init/`:
- `01_backup_envs.sh`: Preservación de configuración previa.
- `03_seed_params.sh`: Carga de configuración de negocio base.
- `05_apply_migrations.sh`: Ejecución de migraciones SQL pendientes.
- `06_initialize_areas.sh`: Bootstrap de la topología del restaurante.

### 2. Migraciones SQL
- Ubicación: `pronto-scripts/init/sql/migrations/`.
- Regla: El nombre del archivo debe empezar con el timestamp `YYYYMMDDHHMMSS_desc.sql`.
- Prohibición: No modificar archivos de migración ya aplicados; crear uno nuevo para correcciones.

---

## 🛡️ Reglas de Producción y Seguridad

### 1. Gestión de Secretos
- No hardcodear llaves API (Stripe, Facturapi, OpenAI) en el código.
- Usar siempre `os.getenv` con fallback solo para entornos de desarrollo.

### 2. Persistencia de Activos (Static Assets)
- Los assets generados por IA o subidos por el Admin (`logo`, `icon`) deben persistirse en el volumen montado hacia `pronto-static/src/static_content/assets/`.
- Estructura de carpetas: `/assets/{restaurant_slug}/{category}/{filename}`.

---

## 🚀 Comandos Críticos de Operación

- **Rebuild Total**: `./bin/rebuild.sh` (Limpia contenedores y reconstruye imágenes).
- **Status Check**: `./bin/status.sh` (Verifica salud de endpoints y puertos).
- **Cierre de Sesiones Inactivas**: `python3 pronto-scripts/bin/python/cleanup-old-sessions.py` (Lógica de Garbage Collection).
- **Validación de Paridad**: `./pronto-scripts/bin/pronto-api-parity-check employees` (Asegura que el frontend coincida con los endpoints de la API).
