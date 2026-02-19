## [BUG - Deuda Técnica] Múltiples Tablas y Sistemas Duplicados en el Esquema de la Base de Datos

**Componente:** `pronto-libs` (pronto_shared.models)
**Severidad:** Alta

**Descripción:**
La auditoría del esquema de la base de datos, definido en `pronto_shared/models.py` y confirmado por los scripts de migración en `pronto-scripts/init/sql/`, ha revelado varias áreas de duplicación conceptual y funcional. Esta redundancia incrementa la complejidad del sistema, dificulta el mantenimiento y aumenta el riesgo de inconsistencias de datos y bugs.

A continuación se detallan las áreas de duplicación identificadas:

### 1. Duplicación del Almacenamiento de Preferencias de Empleado
*   **Hallazgo:** Existen dos mecanismos para almacenar las preferencias de los empleados:
    1.  Una columna JSONB `preferences` en la tabla `pronto_employees`.
    2.  Una tabla separada, `pronto_employee_preferences`.
*   **Impacto:** Es confuso cuál de los dos sistemas es el preferido o si deben estar sincronizados. Esto puede llevar a que se almacenen datos en un lugar y se lean en otro, causando inconsistencias.
*   **Acción Recomendada:** Unificar el almacenamiento de preferencias en un solo sistema. Generalmente, para un simple almacenamiento de clave-valor, la columna JSONB es más eficiente. Se debe migrar cualquier dato relevante de la tabla `pronto_employee_preferences` a la columna JSONB y luego eliminar la tabla redundante.

### 2. Tres Sistemas de Permisos Paralelos (Crítico)
*   **Hallazgo:** El proyecto contiene tres sistemas de gestión de permisos distintos y superpuestos:
    1.  **Sistema 1 (Simple):** `pronto_route_permissions` y `pronto_employee_route_access`.
    2.  **Sistema 2 (RBAC):** `pronto_system_roles`, `pronto_system_permissions`, y `pronto_role_permission_bindings`.
    3.  **Sistema 3 (Personalizado):** `pronto_custom_roles` y `pronto_role_permissions`.
*   **Impacto:** Esta es la redundancia más grave. Complica enormemente la gestión de la autorización, hace difícil saber qué permisos tiene realmente un usuario y crea una pesadilla de mantenimiento. Un cambio de permisos podría requerir modificaciones en tres lugares diferentes.
*   **Acción Recomendada:** Realizar una refactorización mayor para unificar los tres sistemas en un único modelo de control de acceso basado en roles (RBAC). El sistema basado en `pronto_system_roles` parece el más robusto y podría servir como base. Los otros dos sistemas deberían ser migrados y eliminados.

### 3. Duplicación de Sistemas de Configuración
*   **Hallazgo:** Existen dos tablas de clave-valor casi idénticas para almacenar la configuración:
    1.  `pronto_business_config`
    2.  `pronto_system_settings`
*   **Impacto:** No queda claro cuándo usar una u otra. La configuración queda fragmentada, lo que dificulta su gestión y localización.
*   **Acción Recomendada:** Fusionar ambas tablas en una sola. Se debe elegir una como la fuente de verdad, migrar los datos de la otra y eliminar la tabla redundante.

### 4. Duplicación Conceptual de Sistemas de Programación de Productos
*   **Hallazgo:** Existen dos mecanismos para definir la disponibilidad de los productos del menú en diferentes momentos:
    1.  `pronto_day_periods` y `pronto_menu_item_day_periods`.
    2.  `pronto_product_schedules`.
*   **Impacto:** Complica la lógica de negocio para determinar si un producto está disponible, ya que podría ser necesario consultar dos sistemas diferentes.
*   **Acción Recomendada:** Analizar las diferencias funcionales entre ambos sistemas y unificarlos en un único modelo de gestión de horarios de productos.

### 5. Duplicación Conceptual de Sistemas de Descuento
*   **Hallazgo:** Las tablas `pronto_promotions` y `pronto_discount_codes` son conceptualmente muy similares. Ambas gestionan descuentos con reglas de aplicabilidad y fechas de validez.
*   **Impacto:** Si bien no es una duplicación directa, tener dos sistemas para descuentos complica la lógica de precios y la aplicación de ofertas en el checkout.
*   **Acción Recomendada:** Evaluar si ambas tablas pueden ser reemplazadas por un modelo más genérico de "Ofertas" o "Descuentos" que pueda manejar ambos casos de uso (promociones automáticas y códigos de descuento manuales), posiblemente con un campo de "tipo".

---

ID: AUDIT-20260215-DB-SCHEMA-DUPLICATION
FECHA: 2026-02-15
PROYECTO: pronto-libs, pronto-scripts
SEVERIDAD: alta
TITULO: Auditoría de duplicaciones de esquema en base de datos
ESTADO: RESUELTO
SOLUCION: Se validó estado actual del esquema runtime y los hallazgos críticos originales quedaron mitigados/obsoletos: no existen tablas legacy de permisos (`pronto_route_permissions`, `pronto_employee_route_access`, `pronto_custom_roles`, `pronto_role_permissions`) y no existe `pronto_business_config`; el sistema activo opera sobre RBAC unificado (`pronto_system_roles`, `pronto_system_permissions`, `pronto_role_permission_bindings`) y configuración en `pronto_system_settings`. Se mantienen observaciones conceptuales no bloqueantes (p. ej. separación promociones/códigos) como deuda de diseño.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
