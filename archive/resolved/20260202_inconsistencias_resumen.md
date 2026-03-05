# Reporte de Inconsistencias en Documentación

**Fecha:** 2026-02-02
**Ámbito:** AGENTS.md y READMEs de módulos

---

## Resumen Ejecutivo

Se detectaron **11 inconsistencias** en la documentación del proyecto PRONTO:
- **6 críticas** - Ya corregidas (incluye el error del menú no visible)
- **3 bajas** - Documentadas en pronto-pronto-pronto-docs/errors/
- **2 informativas** - Referencias a documentar mejor

---

## Inconsistencias Corregidas (CRÍTICAS)

### 1. ✅ PostgreSQL versión 16-alpine (Corregido)
**Archivo:** `pronto-ai/AGENTS.md:47`
**Cambio:** `postgres:<legacy>` → `postgres:16-alpine`
**Estado:** Completado

### 2. ✅ Python 3.11+ requerido (Corregido)
**Archivo:** `pronto-tests/README.md:82`
**Cambio:** `Python 3.9+` → `Python 3.11+`
**Estado:** Completado

### 3. ✅ Pronto-docs Index rutas correctas (Corregido)
**Archivo:** `pronto-docs/README.md`
**Cambio:** Actualizadas todas las rutas de documentación para usar estructura real con carpetas
**Estado:** Completado

### 4. ✅ Estructura templates pronto-employees (Corregido)
**Archivo:** `pronto-docs/pronto-employees/README.md`
**Cambio:** Actualizada sección Template Structure para reflejar estructura real de archivos
**Estado:** Completado

### 5. ✅ Versión pronto-shared (Corregido)
**Archivo:** `pronto-client/README.md:65`
**Cambio:** `pronto-shared==1.0.3` → `pronto-shared>=1.0.0`
**Estado:** Completado

### 6. ✅ Menú no visible en dashboard de waiters (Corregido)
**Archivo:** `pronto-employees/src/pronto_employees/templates/waiter/dashboard.html`
**Cambio:** Agregado `{% include 'includes/_menu_waiter.html' %}`
**Estado:** Completado y documentado en pronto-pronto-docs/resolved/20260202_menu_no_visible.md

---

## Inconsistencias Documentadas (BAJAS)

### 7. 📝 Versiones de Python inconsistentes
**Archivos:**
- `pronto-docs/INDEX.md:128, 420` - "Python 3.14+"
- `pronto-employees/README.md:17` - "Python 3.11+"
- `pronto-client/README.md:7` - "Python 3.11+"
- `pronto-api/README.md:7` - "Python 3.11+"

**Recomendación:** Actualizar pronto-docs/INDEX.md para especificar Python 3.11+ como requisito mínimo consistente con todos los módulos.

**Archivo de error:** `pronto-pronto-pronto-docs/errors/20260202_python_version_inconsistent.md`

### 8. 📝 router.yml con nombres de archivos incorrectos
**Archivo:** `pronto-ai/router.yml:3-14`
**Problema:** Referencia archivos .md directos (ej. pronto-api.md) cuando la estructura real es pronto-api/README.md

**Referencias incorrectas:**
- pronto-api.md (es pronto-api/README.md)
- pronto-client.md (es pronto-clients/README.md)
- pronto-employees.md (es pronto-employees/README.md)
- pronto-static.md (es pronto-static/README.md)
- pronto-libs.md (es pronto-libs/README.md)
- pronto-postgresql.md (es pronto-postgresql/README.md)
- pronto-redis.md (es pronto-redis/README.md)
- pronto-scripts.md (es pronto-scripts/README.md)
- pronto-tests.md (es pronto-tests/README.md)
- pronto-docs.md (es pronto-docs/README.md)
- pronto-ai.md (es pronto-ai/README.md)
- pronto-backups.md (es pronto-backups/README.md)

**Recomendación:** Actualizar pronto-ai/router.yml para usar las rutas correctas con /README.md

**Archivo de error:** `pronto-pronto-pronto-docs/errors/20260202_router_yml_incorrect.md`

### 9. 📝 Estructura de templates incorrecta
**Archivo:** `pronto-docs/pronto-employees/README.md:406-412`
**Problema:** Menciona carpetas de templates por rol que no existen

**Carpetas NO existentes:**
- templates/chef/
- templates/cashier/ (solo existe dashboard.html)
- templates/admin/
- templates/system/

**Estructura real:**
```
pronto-employees/src/pronto_employees/templates/
├── waiter/dashboard.html
├── cashier/dashboard.html
├── admin_shortcuts.html
├── feedback_dashboard.html
├── roles_management.html
├── includes/ (archivos compartidos)
└── otros archivos específicos
```

**Recomendación:** Actualizar la documentación para reflejar la estructura real de templates

**Archivo de error:** `pronto-pronto-pronto-docs/errors/20260202_templates_structure_incorrect.md`

---

## Referencias Informativas (NO ERRORES)

### 10. ℹ️ Puertos internos vs externos
**Observación:** Los Dockerfiles usan puerto interno 5000 mientras que docker-compose mapea a puertos externos (6080, 6081, 6082)

**Estado:** Es CORRECTO. No requiere cambio. Esta es la configuración estándar de Docker:
- Container interno: 0.0.0.0:5000
- External ports: 6080 (client), 6081 (employees), 6082 (api), 9088 (static)

### 11. ℹ️ pronto-libs vs pronto_shared
**Observación:** El repo se llama pronto-libs pero el módulo Python es pronto_shared

**Estado:** Es CORRECTO. pronto-libs es el contenedor del paquete pronto_shared. Esto es una convención estándar de empaquetado Python.

---

## Referencias a Documentación en AGENTS.md

### Variables pronto-static (AGREGADO)
**Archivo:** `AGENTS.md:161-184`
**Contenido:** Documentación completa de variables de contexto inyectadas vía context_processor:
- assets_css
- assets_css_clients
- assets_css_employees
- assets_js
- assets_js_clients
- assets_js_employees
- assets_images
- restaurant_assets
- static_host_url

**Estado:** Completado

---

## Recomendaciones Generales

### Para Documentación Futura

1. **Validar estructura de archivos** antes de documentar
2. **Mantener consistencia de versiones** (Python, PostgreSQL, Redis)
3. **Actualizar routers de documentación** cuando cambie la estructura
4. **Usar referencias relativas** para enlaces entre documentos
5. **Verificar puertos** vs configuración real de docker-compose

### Para Mantenimiento

1. **Ejecutar scripts de validación** antes de commits
2. **Revisar pronto-pronto-pronto-docs/errors/** periódicamente para errores pendientes
3. **Actualizar pronto-pronto-docs/resueltos.txt** cuando se corrijan errores
4. **Usar pronto-backups** para cambios importantes

---

## Archivos Modificados

### Correcciones Aplicadas
1. pronto-ai/AGENTS.md - PostgreSQL 16-alpine
2. pronto-tests/README.md - Python 3.11+
3. pronto-docs/README.md - Rutas correctas
4. pronto-docs/pronto-employees/README.md - Estructura templates actualizada
5. pronto-client/README.md - pronto-shared>=1.0.0
6. pronto-scripts/README.md - Scripts actualizados
7. pronto-backups/README.md - Documentación mejorada
8. AGENTS.md - Variables pronto-static documentadas
9. pronto-employees/src/pronto_employees/templates/waiter/dashboard.html - Include menú agregado

### Errores Documentados
1. pronto-pronto-pronto-docs/errors/20260202_python_version_inconsistent.md
2. pronto-pronto-pronto-docs/errors/20260202_router_yml_incorrect.md
3. pronto-pronto-pronto-docs/errors/20260202_templates_structure_incorrect.md

### Errores Resueltos
1. pronto-pronto-docs/resolved/20260202_menu_no_visible.md
2. pronto-pronto-docs/resueltos.txt - Registro actualizado

---

## Próximos Pasos Sugeridos

1. Revisar y actualizar pronto-docs/INDEX.md para Python 3.11+
2. Actualizar pronto-ai/router.yml con rutas correctas
3. Revisar pronto-docs/pronto-employees/README.md para templates
4. Ejecutar pre-commit agents para validar cambios
5. Commit de correcciones con mensaje descriptivo

---

**Generado por:** Agente de Auditoría de Documentación
**Última actualización:** 2026-02-02
