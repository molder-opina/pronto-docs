# PRONTO Context and API Audit Report - 2026-02-25

Esta auditoría se centra en la integridad de los contextos de aplicación (`waiter`, `chef`, `cashier`, `admin`, `system`) y la comunicación con `pronto-api` (Port 6082).

## Resumen de Hallazgos

Se han identificado inconsistencias críticas en el manejo de roles de alto nivel y una vulnerabilidad de seguridad en las rutas redundantes de `pronto-employees`.

---

## Hallazgos de Contexto y Roles (P1 - P2)

### [BUG-CTX-01] Contextos Rotos para Usuarios de Alto Nivel (P1)
*   **Descripción**: El sistema utiliza un conjunto canónico de 5 scopes (`waiter`, `chef`, `cashier`, `admin`, `system`). Sin embargo, el script de semillas (`seed.py`) asigna roles como `super_admin` y `content_manager` que no están en esta lista.
*   **Impacto**: 
    1.  Cuando un `super_admin` inicia sesión, el token JWT recibe el `active_scope` "super_admin" si no se especifica un context header.
    2.  Las validaciones `@scope_required` en `pronto-api` fallarán porque "super_admin" no es un scope reconocido.
    3.  El método `Employee.get_scopes()` filtra estos roles no canónicos, resultando en una lista de permisos vacía para usuarios que deberían tener acceso total.
*   **Recomendación**: Mapear el rol `super_admin` al scope canónico `system` y `content_manager` a `admin` tanto en la generación del token como en el modelo `Employee`.

### [BUG-CTX-02] Crash en Página de Error por Falta de Contexto (P2)
*   **Descripción**: La ruta global de Flask `/authorization-error` en `pronto-employees` no inyecta la variable `app_context`.
*   **Impacto**: El frontend intenta resolver el scope actual desde la URL. Al no encontrar un prefijo válido ni la variable `APP_CONTEXT`, la función `resolveCurrentScope()` lanza una excepción, rompiendo la SPA y posiblemente entrando en un bucle de recarga infinito si se intenta llamar a cualquier API desde esa página.
*   **Recomendación**: Asegurar que `/authorization-error` siempre reciba un `app_context` por defecto (ej. `waiter`) o manejar el error de resolución de forma graciosa en el frontend.

---

## Hallazgos de Seguridad en API (P0 - P1)

### [BUG-API-01] Exposición de Rutas Redundantes sin Protección de Scope (P0)
*   **Descripción**: `pronto-employees` mantiene rutas API bajo `/api/*` que duplican la lógica de `pronto-api`. A diferencia de las rutas del proxy (`/<scope>/api/*`), estas rutas directas **no utilizan ScopeGuard** ni validación de scope en el decorador.
*   **Impacto**: Un usuario autenticado con cualquier rol (ej. mesero) puede llamar directamente a `http://localhost:6081/api/orders/<id>/kitchen-start` y saltarse las restricciones de rol, ya que la ruta solo requiere un JWT válido pero no valida el scope.
*   **Recomendación**: Eliminar todas las rutas redundantes en `pronto-employees` y forzar el uso del proxy seguro.

### [BUG-API-02] Discrepancia de Endpoints en el BFF (P2)
*   **Descripción**: El archivo `pronto-employees/src/pronto_employees/routes/api/orders.py` define endpoints como `/orders/<uuid:order_id>/kitchen/start`, mientras que `pronto-api` usa `/api/orders/<order_id>/kitchen-start`.
*   *Nota*: El frontend de empleados parece estar apuntando a la versión con slash (`kitchen/start`) en algunos componentes y a la versión con guion (`kitchen-start`) en otros.
*   **Impacto**: Inconsistencia extrema y fragilidad ante cambios. Si se elimina la redundancia, el frontend se romperá si no se sincronizan los nombres.

---

**Auditor**: Gemini CLI
**Fecha**: 2026-02-25
**Estado**: Reportado para corrección inmediata.
