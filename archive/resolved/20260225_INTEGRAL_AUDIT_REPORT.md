# PRONTO INTEGRAL PROJECT AUDIT REPORT - 2026-02-25

Este reporte consolida todos los hallazgos de la auditoría técnica profunda realizada al ecosistema Pronto, abarcando seguridad, arquitectura, calidad de código, contextos de aplicación, UX y gestión de assets.

## Resumen Ejecutivo
El proyecto presenta una estructura sólida y sigue mayoritariamente los principios de `AGENTS.md`. Sin embargo, existen vulnerabilidades de seguridad por redundancia de rutas, inconsistencias críticas en el manejo de PII de empleados, contextos de rol rotos o no canónicos, y una fragmentación tecnológica que compromete la mantenibilidad.

---

## Hallazgos de Contexto y Seguridad (P0 - P1)

### [BUG-SEC-01] Inconsistencia en Encriptación de PII de Empleados (P0)
*   **Descripción**: El modelo `Customer` encripta `email` y `phone`, pero el modelo `Employee` persiste estos mismos campos en texto plano.
*   **Impacto**: Exposición masiva de datos sensibles de empleados ante un compromiso de la DB.
*   **Recomendación**: Migrar `Employee` al patrón de `hybrid_property` con encriptación.

### [BUG-SEC-02] Exposición de Rutas sin ScopeGuard (P0)
*   **Descripción**: `pronto-employees` mantiene rutas bajo `/api/*` que duplican la lógica de `pronto-api` pero **no validan el scope**.
*   **Impacto**: Un mesero autenticado puede ejecutar acciones de cocina o caja llamando directamente a estas rutas redundantes.
*   **Recomendación**: Eliminar rutas API redundantes en `pronto-employees` y centralizar en el proxy seguro.

### [BUG-CTX-01] Roles No Canónicos en Semillas (P1)
*   **Descripción**: `seed.py` asigna roles `super_admin` y `content_manager`, pero los scopes válidos son `waiter`, `chef`, `cashier`, `admin`, `system`.
*   **Impacto**: Usuarios con estos roles son bloqueados por el proxy y por decoradores `@scope_required` al no tener un scope reconocido en su JWT.
*   **Recomendación**: Mapear `super_admin` a `system` y `content_manager` a `admin` durante el login.

### [BUG-CTX-02] Contexto Inválido en Endpoint de Sesiones (P1)
*   **Descripción**: El endpoint `/api/sessions/anonymous` en `pronto-api` usa `@scope_required("employees")`.
*   **Impacto**: Ningún usuario podrá acceder jamás a este recurso, ya que "employees" no es un scope válido que el sistema genere en los tokens.
*   **Recomendación**: Cambiar a `@scope_required(["admin", "system"])`.

---

## Hallazgos de Arquitectura y Estabilidad (P1 - P2)

### [BUG-ARC-01] Crash en Página de Error por Falta de Contexto (P2)
*   **Descripción**: La ruta `/authorization-error` en `pronto-employees` no inyecta la variable `app_context` al template.
*   **Impacto**: La SPA de Vue falla al intentar resolver el scope actual, pudiendo entrar en bucles de recarga infinitos.
*   **Recomendación**: Pasar `app_context="waiter"` (o el contexto previo detectado) a `render_template`.

### [BUG-ARC-02] Discrepancia de Endpoints Frontend-Backend (P2)
*   **Descripción**: El frontend llama a `/request-payment` mientras el backend espera `/request-check`.
*   **Recomendación**: Sincronizar nombres mediante el sistema de *parity-check*.

---

## Hallazgos de Código y Deuda Técnica (P1 - P3)

### [BUG-CODE-01] Fragmentación Vanilla/Vue en Cliente (P1)
*   **Descripción**: Lógica compleja de modales y gestión de mesas implementada en JS vanilla dentro de templates HTML de Flask.
*   **Recomendación**: Migrar a componentes Vue 3 nativos.

### [BUG-CODE-02] Archivos de Código Masivos (P2)
*   **Evidencia**: `WaiterBoard.vue` (1,776 líneas), `seed.py` (5,159 líneas).
*   **Recomendación**: Fragmentar y modularizar por dominios de negocio.

---

## Hallazgos de UX y Assets (P1 - P3)

### [BUG-UX-01] Uso Masivo de `alert()` Bloqueante (P1)
*   **Descripción**: Más de 40 llamadas a `alert()` rompen la experiencia operativa.
*   **Recomendación**: Migrar al sistema de notificaciones tipo "Toast".

### [BUG-STATIC-01] Rutas de Assets Incorrectas (P2)
*   **Descripción**: Referencias a placeholders y extensiones de logos rotas en la configuración de branding.
*   **Recomendación**: Normalizar assets a `.png` y corregir rutas en `index.html`.

---

**Auditor**: Gemini CLI
**Fecha**: 2026-02-25
**Estado**: Reporte INTEGRAL FINALIZADO.
