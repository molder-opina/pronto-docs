# Arquitectura del Sistema Pronto (V3 - SPA-First)

Documentación técnica de la plataforma "Pronto", actualizada a la arquitectura SPA moderna (2026).

## Visión General
Pronto es una plataforma integral para la gestión de restaurantes. A partir de la versión 3.0, el sistema ha migrado de una arquitectura híbrida (Templates + JS) a una arquitectura **SPA (Single Page Application)** moderna, eliminando la deuda técnica de Jinja2 en el portal de empleados.

## Estructura del Proyecto

### 1. `pronto-static/` (Frontend Moderno)
El corazón de la interfaz de usuario.
- **Tecnología**: Vue 3 (Composition API), Vite, Pinia (State Management), TypeScript.
- **Arquitectura SPA**: 
  - Un único punto de entrada (`index.html`) servido por Flask.
  - **Vue Router**: Gestiona la navegación del personal (Waiter, Kitchen, Cashier, Admin) de forma fluida.
  - **Pinia Stores**: Mantiene el estado global (Órdenes, Sesiones, Configuración) sincronizado mediante `RealtimeClient`.
  - **Nginx-SPA**: Configuración optimizada para manejar History Mode y Proxy API.

### 2. `pronto-employees/` (BFF & API Backend)
Actúa como un Backend-for-Frontend (BFF) para el panel de personal.
- **Tecnología**: Flask (Python 3.11+).
- **Responsabilidades**:
  - Servir el cascarón de la SPA.
  - Exponer endpoints JSON estandarizados en `/api/*`.
  - **Autenticación**: 100% Stateless mediante JWT en HTTP-only cookies. Se prohíbe el uso de `flask.session`.
  - **Seguridad**: Implementación estricta de `ScopeGuard` y `CSRF` mediante cabeceras `X-CSRFToken`.

### 3. `pronto-libs` (Shared Logic & Models)
Núcleo común de lógica de negocio.
- **Modelos**: SQLAlchemy ORM (PostgreSQL 16).
- **Servicios Estandarizados**: Todas las funciones en `pronto_shared.services` devuelven objetos `success_response` o `error_response` definidos en `serializers.py`.
- **Canonicidad**: Uso exclusivo de `CanonicalWorkflowStatus` para transiciones de estados de órdenes.

### 4. `pronto-client/` (Frontend Cliente)
Aplicación para comensales (QR Menu & Ordering).
- **Tecnología**: Flask + TypeScript.

## Componentes de Infraestructura

### Base de Datos (PostgreSQL & Redis)
- **PostgreSQL**: Persistencia relacional de menús, empleados y órdenes.
- **Redis**: Caché de alto rendimiento, gestión de PII temporal y bus de mensajes para notificaciones.

### Comunicación en Tiempo Real
- **SSE (Server-Sent Events)**: Utilizado por la SPA para recibir actualizaciones de órdenes y llamadas de clientes de forma instantánea sin polling excesivo.

## Flujos Críticos Modernizados

### 1. Gestión de Órdenes (SPA Flow)
`Vue Component` -> `Pinia Store` -> `authenticatedFetch` -> `Employee API` -> `Shared Service` -> `DB` -> `SSE Broadcast` -> `Vue Reactive Update`.

### 2. Autenticación Stateless
- El usuario hace Login -> El servidor responde con un JWT.
- El navegador almacena el JWT en una cookie segura.
- Todas las peticiones API incluyen el token automáticamente.
- El servidor valida el `active_scope` contra la URL solicitada.

## Estándares de Calidad
- **Zero Technical Debt**: Eliminación total de assets inline (CSS/JS).
- **Type Safety**: Uso de MyPy en Backend y TypeScript en Frontend.
- **Linter**: `ruff` para Python, `eslint` para Vue.
- **Standardized API**: Respuesta uniforme `{success: bool, data: any, error: string|null}`.