# API Routes Implementation & Cleanup Plan

**Fecha**: 2026-02-09
**Estado**: ⏳ PENDIENTE
**Prioridad**: MEDIA
**Tipo**: Cleanup / Implementación
**Componente**: API Routes (Public & Employees)

---

## 1. Deuda Técnica a Resolver (Cleanup)

### 1.1 Inconsistencia en Blueprints
Los siguientes archivos no definen sus propios Blueprints, sino que importan `api_bp` y registran rutas directamente. Esto rompe el patrón modular y dificulta la mantenibilidad.

*   `api_app/routes/notifications.py`
    *   **Problema**: Registra rutas en `api_bp`.
    *   **Solución**: Definir `notifications_bp = Blueprint(...)` y registrarlo en `__init__.py`.
*   `api_app/routes/realtime.py`
    *   **Problema**: Registra rutas en `api_bp`.
    *   **Solución**: Definir `realtime_bp = Blueprint(...)` y registrarlo en `__init__.py`.

### 1.2 Inconsistencia en Respuestas (JSON vs Serializer)
Varios endpoints devuelven `jsonify({...})` directamente en lugar de usar el helper estándar `success_response(...)`. Esto causa inconsistencia en la estructura de respuesta (falta el wrapper `{"data": ...}` o similar si aplica).

*   `api_app/routes/branding.py`: Usa `jsonify` para `config` y devuelve `501` manuales.
*   `api_app/routes/menu.py`: Usa `jsonify` manual en `get_menu`.

### 1.3 Duplicación Confusa (Reports)
Existe una duplicación confusa entre rutas de reportes:
*   `api_app/routes/reports.py` (Montado en `/api/reports`): Completamente implementado usando `AnalyticsService`.
*   `api_app/routes/employees/reports.py` (Montado en `/api/reports` por `register_employees_blueprints`?): **STUB**. Es probable que este archivo esté sobreescribiendo o siendo ignorado, pero causa confusión.
    *   **Acción**: Eliminar `api_app/routes/employees/reports.py` si la versión pública/shared cubre las necesidades de empleados (que parece que sí, ya que requiere scope `employees`).

---

## 2. Funcionalidades Pendientes (Stubs)

Se identificaron numerosos endpoints que son "stubs" (devuelven estructuras vacías o datos mock). Estos deben ser implementados conectándolos a sus servicios correspondientes o marcados explícitamente como "Futuro".

### 2.1 Admin & Analytics (Employees)
*   `api_app/routes/employees/admin.py`: `list_shortcuts` (Vacío).
*   `api_app/routes/employees/analytics.py`: Stubs para `revenue-trends`, `waiter-performance`, etc. Además `get_kpis` contiene lógica de negocio que debería estar en `AnalyticsService`.
    *   **Acción**: Mover lógica de KPIs al servicio y conectar demás stubs.

### 2.2 Core Domain (Employees)
*   `api_app/routes/employees/areas.py`: CRUD completo son stubs.
*   `api_app/routes/employees/tables.py`: Update y Delete son stubs.
*   `api_app/routes/employees/table_assignments.py`: Toda la lógica de asignación y conflictos son stubs.
*   `api_app/routes/employees/notifications.py`: Stubs para notificaciones de meseros/admin.
*   `api_app/routes/employees/feedback.py`: Stats de feedback son stubs.

### 2.3 Branding, Config & Promos (Employees)
*   `api_app/routes/employees/api_branding.py`: Upload/Generate son stubs o 501.
*   `api_app/routes/employees/config.py`: Stubs.
*   `api_app/routes/employees/promotions.py`: Stubs.
*   `api_app/routes/employees/discount_codes.py`: Stubs.
*   `api_app/routes/employees/product_schedules.py`: Stubs.

---

## 3. Plan de Ejecución

1.  **Fase 1 (Cleanup Arquitectónico)**:
    *   [x] Refactorizar `notifications.py` y `realtime.py` (Public) para usar Blueprints.
    *   [x] Eliminar `api_app/routes/employees/reports.py` en favor de `api_app/routes/reports.py`.
    *   [x] Mover lógica de `api_app/routes/employees/analytics.py` a `AnalyticsService`.

2.  **Fase 2 (Conexión de Servicios Básicos)**:
    *   [x] Implementar `areas.py`, `tables.py` (update/delete) y `modifiers.py` (mutaciones) conectando a la base de datos.
    *   [x] Crear `TableService` para manejar CRUD de mesas.
    *   [x] Eliminar stubs duplicados (`api/tables.py`, `api/areas.py`) para evitar colisiones 405.
    *   [x] Implementar `promotions.py`, `product_schedules.py` y `discount_codes.py` (Estandarizado como 501/Stubs limpios).

3.  **Fase 3 (Features Avanzadas)**:
    *   [x] Implementar `table_assignments.py` (Lógica compleja de asignación).
    *   [x] Implementar `branding.py` (Subida de archivos).
    *   [x] Implementar `notifications.py` (Integración con SSE/Realtime).

## 4. Conclusión
Todos los endpoints críticos han sido implementados conectando a servicios reales. Los endpoints de menor prioridad (promociones, horarios) se han estandarizado para devolver 501 Not Implemented en lugar de fallar o devolver datos falsos.
El sistema pasa el chequeo de paridad (sin errores de importación, aunque con advertencias de umbral conocidas).
