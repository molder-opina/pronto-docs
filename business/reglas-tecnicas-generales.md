# Reglas Técnicas y Prompt Maestro: Arquitectura y Estándares de Pronto

## Contexto
Este documento consolida las reglas técnicas transversales a todos los proyectos de Pronto (`api`, `client`, `employees`, `libs`, `static`). Sirve como guía de referencia para cualquier desarrollo técnico.

---

## 🤖 Prompt Maestro para Arquitectura y Desarrollo

"Actúa como el Arquitecto Principal de Software de la plataforma Pronto. Tu objetivo es mantener la consistencia técnica, el rendimiento y la seguridad en todo el monorepo. Al proponer o implementar cambios técnicos, debes:
1. Respetar el principio de 'Reutilizar antes de Crear': Siempre verifica `pronto_shared` antes de añadir una nueva lógica.
2. Asegurar que `pronto-api` sea la única fuente de verdad (Single Source of Truth) para la lógica de negocio.
3. Mantener el aislamiento de scopes mediante `ScopeGuard` y cookies prefijadas por rol.
4. Cumplir con la arquitectura de activos estáticos: Todo el CSS, JS compilado e imágenes debe residir exclusivamente en `pronto-static`.
5. No usar `print()` en producción ni lógica inline en templates; preferir logging y activos externos.
6. Aplicar validaciones de tipos estrictas (TypeScript en el frontend, Type Hints en Python) en todo código nuevo."

---

## 🏗️ Arquitectura del Sistema

### 1. Core API (`pronto-api`)
- **Lógica de Negocio**: Implementada mediante `OrderStateMachine`, `PaymentService`, `MenuService`, etc.
- **Base de Datos**: PostgreSQL para persistencia; Redis para caché y mensajes.
- **REST**: Endpoints bajo `/api/*`. Respuestas JSON estándar.

### 2. Frontend Estático (`pronto-static`)
- **Nginx**: Servidor dedicado para assets.
- **Branding**: Los assets de marca viven en `assets/pronto/branding/`.
- **Modularidad**: Estructura de CSS compartida (`assets/css/shared/`) y TypeScript compartido (`src/vue/shared/`).

### 3. Shared Library (`pronto_shared`)
- **Modelos**: Única definición de modelos SQLAlchemy compartida por todos los servicios Python.
- **Middleware**: Implementación de `jwt_middleware`, `scope_guard` y `security_middleware`.
- **Servidores**: Todos los servicios Python deben tener la versión correcta de `pronto_shared` instalada.

---

## 🛡️ Estándares de Seguridad y Calidad

### 1. Autenticación (JWT)
- **Employee Auth**: Stateless mediante JWT. No usar `flask.session`.
- **Scopes**: Un token tiene un `active_scope` inmutable. Los roles son jerárquicos o granulares según `permissions.py`.
- **CSRF**: Protección obligatoria en mutaciones mediante el encabezado `X-CSRFToken`.

### 2. Calidad de Código
- **Python**: PEP8 (uso de Ruff/Black). Prohibido `print()`. Máximo 100 caracteres por línea.
- **Frontend**: Vue 3 con Composition API y TypeScript. Prohibido JavaScript/CSS inline en templates HTML.
- **Git**: Commits semánticos (`tipo(ámbito): descripción`). Ramas por feature.

### 3. Base de Datos
- **Migraciones**: Deben incluir timestamp en el nombre. No ejecutar DDL en tiempo de ejecución de las apps.
- **Protección de Datos**: Prohibido eliminar registros de tablas núcleo (`pronto_menu_items`, `pronto_employees`) directamente.

---

## 🚀 Despliegue y Operaciones

### 1. Inicialización (`bin/init/`)
- El sistema se inicializa mediante scripts numerados en `pronto-scripts/bin/init/`.
- **Seed Data**: El estado canónico del sistema (menú inicial, empleados base) se define en `pronto_shared/services/seed.py`.

### 2. Monitoreo y Salud
- **Endpoints de Salud**: Todos los servicios deben implementar `/health`.
- **Logging**: Seguir el estándar definido en `pronto-docs/LOGGING_STANDARD.md`.
