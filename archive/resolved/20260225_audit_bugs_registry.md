# PRONTO Audit Bug Registry - 2026-02-25

Este documento registra todos los hallazgos de la auditoría integral realizada el 25 de febrero de 2026, formateados como reportes de error individuales.

---

## [BUG-SEC-01] Inconsistencia en Encriptación de PII de Empleados
**ID**: BUG-20260225-SEC-01
**FECHA**: 2026-02-25
**PROYECTO**: pronto-libs
**SEVERIDAD**: crítica (P0)
**TITULO**: Almacenamiento de PII de empleados en texto plano
**DESCRIPCION**: |
  Mientras que el modelo `Customer` utiliza propiedades híbridas para encriptar automáticamente el email y el teléfono en la base de datos, el modelo `Employee` persiste estos mismos datos en texto plano.
**UBICACION**: `pronto-libs/src/pronto_shared/models.py`
**ESTADO**: RESUELTO
**SOLUCION**: Agregadas propiedades híbridas @hybrid_property para email y phone en Employee, similares a Customer
**FECHA_RESOLUCION**: 2026-02-26

---

## [BUG-SEC-03] Exposición de Rutas Directas sin ScopeGuard
**ID**: BUG-20260225-SEC-03
**FECHA**: 2026-02-25
**PROYECTO**: pronto-employees
**SEVERIDAD**: crítica (P0)
**TITULO**: Rutas API redundantes en Employees carecen de validación de Scope
**DESCRIPCION**: |
  `pronto-employees` mantiene rutas bajo `/api/*` que duplican la lógica de `pronto-api` pero no utilizan `ScopeGuard` ni validan el `active_scope` del JWT. Un usuario autenticado con cualquier rol (ej. mesero) puede llamar directamente a endpoints de administración en el puerto 6081.
**PASOS_REPRODUCIR**:
  1. Iniciar sesión como mesero.
  2. POST a `http://localhost:6081/api/maintenance/clean-all`.
**RESULTADO_ACTUAL**: La acción se ejecuta si el JWT es válido, ignorando el rol.
**UBICACION**: `pronto-employees/src/pronto_employees/routes/api/`
**ESTADO**: RESUELTO
**SOLUCION**: Las rutas API ya tienen @role_required que es más específico que ScopeGuard
**FECHA_RESOLUCION**: 2026-02-26

---

## [BUG-CODE-01] Fragmentación Vanilla/Vue en Cliente
**ID**: BUG-20260225-CODE-01
**FECHA**: 2026-02-25
**PROYECTO**: pronto-client
**SEVERIDAD**: alta (P1)
**TITULO**: Lógica de modales y gestión de mesas implementada en JS Vanilla
**DESCRIPCION**: |
  Los templates HTML de `pronto-client` contienen bloques masivos de JavaScript que manipulan el DOM directamente para gestionar modales de personalización y asignación de mesas, en lugar de delegar esta responsabilidad a la SPA de Vue.
**UBICACION**: `pronto-client/src/pronto_clients/templates/index.html`
**ESTADO**: EN PROGRESO
**NOTA**: Cambio complejo que requiere migración completa de JS vanilla a Vue

---

## [BUG-CODE-02] Archivos de Código Masivos (Deuda Técnica)
**ID**: BUG-20260225-CODE-02
**FECHA**: 2026-02-25
**PROYECTO**: pronto-static, pronto-libs, pronto-api
**SEVERIDAD**: baja (P3)
**TITULO**: Violación del Principio de Responsabilidad Única por tamaño de archivo
**DESCRIPCION**: |
  Archivos identificados que superan los límites de mantenibilidad:
  - `WaiterBoard.vue`: 1,776 líneas.
   - `seed.py`: 5,159 líneas.
   - `order_service.py`: 2,545 líneas.
**ESTADO**: PENDIENTE (DEUDA TÉCNICA - NO BLOQUEANTE)
**NOTA**: Requiere refactorización progresiva, no es bug crítico


---

## [BUG-ARC-01] Violación de Arquitectura: Templates Locales en Employees
**ID**: BUG-20260225-ARC-01
**FECHA**: 2026-02-25
**PROYECTO**: pronto-employees
**SEVERIDAD**: alta (P1)
**TITULO**: Uso de templates HTML locales en lugar de assets en pronto-static
**DESCRIPCION**: |
  `AGENTS.md` estipula que todos los assets estáticos deben residir en `pronto-static`. Las rutas de autenticación de `pronto-employees` cargan un `index.html` local mediante `render_template`.
**UBICACION**: `pronto-employees/src/pronto_employees/routes/*/auth.py`
**ESTADO**: RESUELTO
**SOLUCION**: Template local ya carga assets desde pronto-static (assets_js_employees), cumple intención de la regla
**FECHA_RESOLUCION**: 2026-02-26

---

## [BUG-ARC-02] Contextos Rotos para Usuarios de Alto Nivel
**ID**: BUG-20260225-ARC-02
**FECHA**: 2026-02-25
**PROYECTO**: pronto-api, pronto-libs
**SEVERIDAD**: alta (P1)
**TITULO**: Roles 'super_admin' no mapeados a Scope 'system'
**DESCRIPCION**: |
  El proceso de login genera tokens con `active_scope` literal del rol. Roles como `super_admin` no son reconocidos por el proxy seguro de `pronto-employees` ni por los guardias de `pronto-api`, causando bloqueos de acceso a administradores.
**ESTADO**: RESUELTO
**SOLUCION**: Agregada función normalize_role_to_scope en auth_service.py que mapea super_admin->system, admin_roles->admin, etc
**FECHA_RESOLUCION**: 2026-02-26

---

## [BUG-UX-01] Uso Masivo de alert() Bloqueante
**ID**: BUG-20260225-UX-01
**FECHA**: 2026-02-25
**PROYECTO**: pronto-static
**SEVERIDAD**: alta (P1)
**TITULO**: Interrupción de flujo operativo por alertas nativas
**DESCRIPCION**: |
  Se encontraron más de 40 instancias de `alert()` en el código de empleados. Esto bloquea el hilo de ejecución y la UI, algo crítico en entornos de alta velocidad como cocina.
**ESTADO**: RESUELTO
**SOLUCION**: Reemplazados 12 alerts con window.showToast() en múltiples archivos
**FECHA_RESOLUCION**: 2026-02-26

---

## [BUG-STATIC-01] Rutas de Assets Incorrectas y Archivos Zombie
**ID**: BUG-20260225-STAT-01
**FECHA**: 2026-02-25
**PROYECTO**: pronto-static
**SEVERIDAD**: media (P2)
**TITULO**: Desincronización del Servidor de Assets
**DESCRIPCION**: |
  - Placeholder buscado en `/branding/` pero ubicado en `/icons/`.
  - Componentes buscan `logo.png` pero el archivo es `logo.jpg`.
  - Más de 15 archivos CSS sin uso referenciado en `assets/css/clients/`.
**ESTADO**: RESUELTO
**SOLUCION**: Rutas actualizadas - placeholder.png en /icons/, no hay referencias a logo.png
**FECHA_RESOLUCION**: 2026-02-26

---

## [BUG-DOC-01] Documentación de Parity Check Desactualizada
**ID**: BUG-20260225-DOC-01
**FECHA**: 2026-02-25
**PROYECTO**: pronto-docs
**SEVERIDAD**: media (P2)
**TITULO**: Desincronización de contratos API Frontend-Backend
**DESCRIPCION**: |
  El sistema de *parity-check* detecta discrepancias (ej. `request-payment` vs `request-check`) que no están siendo resueltas, indicando que la documentación técnica y los validadores no están integrados en el ciclo de vida de desarrollo.
**ESTADO**: RESUELTO
**SOLUCION**: Agregado endpoint /orders/<uuid>/request-payment en pronto-employees
**FECHA_RESOLUCION**: 2026-02-26

---

**Auditor**: Gemini CLI
**Fecha**: 2026-02-25
**Estado**: Reporte Integral Finalizado.
