# Arquitectura del Sistema Pronto (V3.1 - Core API & Multi-Console)

Documentación técnica de la plataforma "Pronto", actualizada a la arquitectura orientada a servicios (2026).

## Visión General
Pronto es una plataforma integral para la gestión de restaurantes basada en microservicios Flask y una SPA moderna. El sistema se divide en tres capas principales: Core API, Aplicaciones Operativas (BFF) y Frontend Estático.

## Estructura del Proyecto

### 1. `pronto-api/` (Core API - Port 6082)
El corazón del sistema y la única fuente de verdad para la lógica de negocio.
- **Tecnología**: Flask (Python 3.11+).
- **Responsabilidades**:
  - Gestión centralizada de Órdenes, Menús, Mesas y Sesiones.
  - Autenticación unificada de Empleados y Clientes.
  - Validación de reglas de negocio complejas (OrderStateMachine).
  - Integración con proveedores de pago (Stripe, Clip).

### 2. `pronto-static/` (Frontend Moderno - Port 9088)
Servidor Nginx que entrega los assets compilados de Vue 3.
- **Tecnología**: Vue 3 (Composition API), Vite, Pinia, TypeScript.
- **Single Source of Truth**: Todos los CSS compartidos, componentes base y lógica de red (`RealtimeClient`) residen aquí.

### 3. `pronto-employees/` (BFF & SPA Shell - Port 6081)
Actúa como cascarón para el panel de personal y Backend-for-Frontend especializado.
- **Responsabilidades**:
  - Servir el `index.html` que inicializa la SPA de empleados.
  - **Proxy Seguro**: Redirige peticiones de la SPA hacia `pronto-api` inyectando contextos de seguridad.
  - **Aislamiento de Scope**: Utiliza cookies con nombres específicos (ej. `access_token_waiter`) para permitir múltiples sesiones abiertas en diferentes pestañas (Multi-Console).

### 4. `pronto-client/` (Frontend Cliente - Port 6080)
Aplicación para comensales (QR Menu & Ordering).
- **Tecnología**: Flask + TypeScript.
- **Estado**: Híbrido. Utiliza templates Jinja2 para el renderizado inicial y TypeScript para el carrito y comunicación en tiempo real.

### 5. `pronto-libs/` (Shared Logic)
Librería común (`pronto_shared`) instalada en todos los servicios. Contiene modelos SQLAlchemy, utilidades de seguridad y middleware de JWT.

## Seguridad y Autenticación Multi-Consola

### Lógica de Redirección
El sistema implementa una protección estricta contra la confusión de scopes:
1. Al acceder a `/<scope>/login`, el servidor verifica si existe una cookie de sesión específica para ese scope.
2. Si el usuario ya está autenticado en ese contexto, es redirigido automáticamente a su `/dashboard`.
3. Si el usuario intenta acceder a un login de un scope diferente (ej. de Waiter a Chef), el sistema detecta el cambio de contexto y permite la nueva autenticación sin cerrar la sesión anterior, manteniendo el aislamiento mediante cookies prefijadas.

### Validación de Perímetro (ScopeGuard)
Todas las rutas de empleados están protegidas por `ScopeGuard` en `pronto_shared`. Este middleware valida:
- Existencia de JWT.
- Que el `active_scope` del token coincida con el segmento de URL solicitado.
- Prevención de escalación horizontal entre departamentos.

## Comunicación en Tiempo Real
- **Supabase Realtime**: Reemplaza la dependencia local de Redis Streams para notificaciones globales de nuevas órdenes y llamadas de clientes.
- **SSE (Server-Sent Events)**: Utilizado para actualizaciones reactivas en las tablas de control.

## Estándares de Calidad
- **Type Safety**: TypeScript obligatorio en nuevos componentes.
- **Parity Check**: Validación automática de que los endpoints consumidos por el frontend existen en la Core API.
- **Zero Inline (Target)**: Se busca la eliminación total de scripts/estilos inline en favor de assets externos servidos por `pronto-static`.