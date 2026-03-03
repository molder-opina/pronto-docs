# Reporte de Auditoría Técnica Integral - 2026-02-25

Este documento resume los hallazgos de la auditoría técnica realizada al ecosistema Pronto, cubriendo Seguridad, Arquitectura, Código y UX.

## 1. Seguridad y Privacidad

### [CRÍTICO] Encriptación Inconsistente de PII
- **Hallazgo**: El modelo `Customer` encripta email y teléfono, pero `Employee` los mantiene en texto plano.
- **Riesgo**: Exposición de datos de empleados en caso de brecha de DB.
- **Acción**: Migrar `Employee` al patrón de propiedades híbridas encriptadas.

### [CRÍTICO] Exposición de Rutas sin ScopeGuard
- **Hallazgo**: `pronto-employees` expone rutas `/api/*` duplicadas que no validan el scope del JWT.
- **Riesgo**: Un mesero puede ejecutar acciones de administrador llamando directamente al puerto 6081.
- **Acción**: Eliminar rutas redundantes y forzar el uso del proxy seguro.

## 2. Arquitectura y Contextos

### [ALTO] Roles No Canónicos
- **Hallazgo**: Roles como `super_admin` no están mapeados a los 5 scopes canónicos (`waiter`, `chef`, `cashier`, `admin`, `system`).
- **Impacto**: Bloqueos de acceso en el proxy de seguridad.
- **Acción**: Implementar mapeo de roles a scopes en el proceso de generación de JWT.

### [MEDIO] Redirección Multi-Consola
- **Hallazgo**: Existía un bug donde usuarios de Cocina/Caja eran redirigidos a la página de Mesero al intentar re-autenticarse.
- **Estado**: **SOLUCIONADO** y verificado con 25 tests E2E.

## 3. Calidad de Código y Deuda Técnica

### [ALTO] Lógica Fragmentada (Vanilla JS)
- **Hallazgo**: El frontend de clientes (`pronto-client`) depende de grandes bloques de JS vanilla inline para modales críticos.
- **Riesgo**: Inconsistencia de estado y dificultad de mantenimiento.
- **Acción**: Migrar a componentes Vue 3 nativos.

### [ALTO] Archivos Monolíticos
- **Hallazgo**: `WaiterBoard.vue` (>1700 líneas) y `seed.py` (>5000 líneas).
- **Acción**: Modularización inmediata.

## 4. Gestión de Assets

### [BAJO] Rutas y Extensiones Incorrectas
- **Hallazgo**: Discrepancias entre `.png` y `.jpg` para logos, y rutas de placeholders rotas en el cliente.
- **Acción**: Normalizar todos los assets a `.png` y actualizar referencias.

---
**Auditor**: Gemini CLI
**Fecha**: 2026-02-25
