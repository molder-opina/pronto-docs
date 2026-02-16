# Resumen de Correcciones Aplicadas (2026-02-11)

Se han resuelto múltiples bugs críticos relacionados con la seguridad, estandarización de API y calidad de código en el frontend.

## 1. Estandarización de API y Eliminación de Hardcoded URLs
- **Bug:** `FE_API_WRAPPER_REMAINING_VIOLATIONS` y deuda técnica en `pronto-client`.
- **Acción:** 
  - Eliminado el uso de `API_BASE` y URLs hardcodeadas a `localhost` en `pronto-client`.
  - Refactorizado `requestJSON` y `resolveFullUrl` en clientes para usar rutas relativas por defecto.
  - Refactorizadas todas las llamadas `fetch()` directas en los templates de `pronto-employees` (`_dashboard_scripts.html`, `debug_panel.html`, `system_order_status_labels.html`, `login_waiter.html`) para usar `window.requestJSON`.
- **Resultado:** Consistencia total en el uso del wrapper de API, mejorando el manejo de errores y seguridad.

## 2. Protección CSRF en pronto-client
- **Bug:** `CSRF_EXEMPTIONS_CLIENT_API`.
- **Acción:**
  - Eliminadas las exenciones de CSRF en `app.py` del cliente.
  - Implementado el envío automático del token `X-CSRFToken` en el wrapper `http.ts` del cliente para todas las peticiones mutantes.
- **Resultado:** El portal del cliente ahora cuenta con protección CSRF completa en todos sus endpoints de API.

## 3. Limpieza de Templates y Estilos Inline
- **Bug:** `BUG-20260210-001-TEMPLATE-CLEANUP`.
- **Acción:**
  - Extraídos estilos de la barra lateral del catálogo a `catalog-sidebar.css`.
  - Extraídos estilos adicionales del dashboard a `dashboard-extras.css`.
  - Eliminados todos los bloques `<style>` de `dashboard.html` (de 24 a 0).
  - Corregida la estructura HTML rota en `login_cashier.html`.
  - Migrados estilos inline de `login_system.html` a `login-shell.css`.
- **Resultado:** Reducción drástica de deuda técnica en templates HTML, facilitando el mantenimiento y cumplimiento de reglas del proyecto.

## 4. Corrección de Páginas de Login
- **Bug:** Ausencia de lógica JS en páginas de login de empleados.
- **Acción:**
  - Agregado el enlace a `login.js` en las páginas de login de admin, cajero, chef y sistema (faltaba en todas excepto mesero).
  - Asegurada la disponibilidad global de `window.requestJSON` en el entrypoint de login.
- **Resultado:** Funcionalidad completa de estados de carga, estadísticas públicas y asistentes de depuración en todas las páginas de acceso.

**Estado Final:** 4 bugs críticos resueltos al 100%. Build de clientes y empleados verificado exitosamente.
