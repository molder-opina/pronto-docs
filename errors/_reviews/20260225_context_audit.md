# PRONTO Context and API Audit Report - 2026-02-25

Esta auditoría se centra en la integridad de los contextos de aplicación (`waiter`, `chef`, `cashier`, `admin`, `system`) y la comunicación con `pronto-api` (Port 6082).

## Resumen de Hallazgos

Se han identificado inconsistencias críticas en el manejo de roles de alto nivel y una vulnerabilidad de seguridad en las rutas redundantes de `pronto-employees`.

---

## Hallazgos de Contexto y Roles (P1 - P2)

### [BUG-CTX-01] Contextos Rotos para Usuarios de Alto Nivel (P1)
*   **Descripción**: El sistema utiliza un conjunto canónico de 5 scopes (`waiter`, `chef`, `cashier`, `admin`, `system`). Sin embargo, el script de semillas (`seed.py`) asigna roles como `super_admin` y `content_manager` que no están en esta lista.
*   **Impacto**: 
    1.  Cuando un `super_admin` inicia sesión, el token JWT puede recibir el `active_scope` "super_admin".
    2.  Las validaciones `@scope_required` en `pronto-api` fallarán porque "super_admin" no es un scope reconocido.
    3.  El proxy de seguridad en `pronto-employees` bloqueará al usuario por "Scope mismatch" al no reconocer el rol como administrativo.
*   **Recomendación**: Mapear el rol `super_admin` al scope canónico `system` y `content_manager` a `admin` durante la generación del token.

### [BUG-CTX-02] Inconsistencia en Mapeo de Scopes en el Modelo (P2)
*   **Descripción**: El método `Employee.get_scopes()` filtra cualquier rol que no sea canónico.
*   **Impacto**: Un empleado con rol `staff` (valor por defecto) o `super_admin` terminará con una lista de scopes vacía si no tiene `allow_scopes` explícitos, impidiéndole usar cualquier consola.
*   **Recomendación**: Asegurar que los roles canónicos coincidan 1:1 con los nombres de las consolas o implementar un mapeo explícito en `get_scopes`.

---

## Hallazgos de Seguridad en API (P0 - P1)

### [BUG-API-01] Exposición de Rutas Redundantes sin Protección de Scope (P0)
*   **Descripción**: `pronto-employees` mantiene rutas API bajo `/api/*` que duplican la lógica de `pronto-api`. A diferencia de las rutas del proxy (`/<scope>/api/*`), estas rutas directas **no utilizan ScopeGuard**.
*   **Impacto**: Un usuario autenticado con cualquier rol (ej. mesero) puede llamar directamente a `http://localhost:6081/api/orders/<id>/kitchen-start` y saltarse las restricciones de rol, ya que la ruta solo requiere un JWT válido pero no valida el scope.
*   **Recomendación**: Eliminar todas las rutas redundantes en `pronto-employees` y forzar el uso del proxy seguro o llamar directamente a `pronto-api` (que sí tiene protección de scope).

### [BUG-API-02] Duplicación de Lógica de Autenticación (P1)
*   **Descripción**: Existe lógica de login duplicada en `pronto-api` y en cada blueprint de rol de `pronto-employees`.
*   **Impacto**: Riesgo de que las implementaciones diverjan (ej. diferentes tiempos de expiración, diferentes claims en el JWT). Actualmente comparten la clave secreta, pero cualquier cambio en una debe replicarse en 6 archivos diferentes.
*   **Recomendación**: Centralizar la autenticación exclusivamente en `pronto-api` y que `pronto-employees` actúe solo como consumidor de tokens.

---

## Hallazgos de Conectividad Port 6082 (P2)

### [BUG-CONN-01] Configuración de Desarrollo Expuesta (P3)
*   **Descripción**: El archivo `clients/config/api.ts` hardcodea `http://localhost:6082` para el entorno de desarrollo.
*   **Impacto**: Si el desarrollador accede mediante una IP o un hostname diferente, las llamadas directas a la API canónica podrían fallar por políticas de CORS o bloqueos de red si no se actualiza esta constante.
*   **Recomendación**: Usar variables de entorno inyectadas en tiempo de build para las URLs de API.

---

**Auditor**: Gemini CLI
**Fecha**: 2026-02-25
**Estado**: Reporte de Contextos Finalizado.
