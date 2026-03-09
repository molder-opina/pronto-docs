# Plan de Migración a Arquitectura SPA (Vue + Proxy)

Este documento detalla los pasos para migrar `pronto-employees` de una arquitectura híbrida (SSR Jinja2 + Vue) a una SPA completa servida por Nginx, donde Flask actúa únicamente como API.

## Fase 1: Infraestructura (Proxy Unificado)

1.  **Configuración Nginx**: Crear `nginx-spa.conf` para servir `index.html` y proxy `/api` a los contenedores backend. (HECHO)
2.  **Docker Compose**:
    *   Modificar el servicio `static` para usar la nueva configuración de Nginx.
    *   Asegurar que `employees` y `api` sean accesibles desde la red interna para el proxy.

## Fase 2: Frontend (Vue Router & Entrypoint)

1.  **Vue Router**:
    *   Definir rutas para `/login`, `/dashboard`, `/waiter`, `/chef`, etc. en `pronto-static/src/vue/employees/router`.
    *   Implementar "Route Guards" para validar autenticación (JWT en cookies/localStorage).
2.  **App Shell**:
    *   Crear un `App.vue` principal que contenga el layout base (sidebar, header) que actualmente está en `base.html`.
    *   Migrar la lógica de navegación y estado global (User, Config) a Pinia o Composable.

## Fase 3: Backend (Flask API Mode)

1.  **Auth API**:
    *   Asegurar que los endpoints de login (`/api/auth/login`) devuelvan JSON y seteen cookies correctamente (o token en body).
    *   Eliminar las redirecciones `render_template` en los endpoints de autenticación.
2.  **API Only**:
    *   Verificar que todas las vistas de Flask que renderizaban HTML tengan un equivalente API JSON si transportaban datos.

## Fase 4: Transición y Limpieza

1.  **Switch**: Cambiar el puerto expuesto al usuario para apuntar al contenedor Nginx (SPA).
2.  **Deprecación**: Eliminar la carpeta `templates/` en `pronto-employees`.
3.  **Limpieza**: Eliminar rutas de vista en Flask (`routes/web.py` o similares).

## Rollback Plan

Si la SPA falla, revertir `docker-compose.yml` para exponer `employees` (6081) directamente de nuevo y restaurar los templates.
