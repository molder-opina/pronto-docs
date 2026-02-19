## [BUG - Deuda Técnica] Código Frontend con Alta Complejidad y Duplicación

**Componente:** `pronto-static`
**Severidad:** Media

**Descripción:**
La auditoría de la estructura del código fuente de Vue en `pronto-static/src/vue` ha revelado una deuda técnica significativa relacionada con la complejidad y la duplicación de código. Aunque se siguen buenas prácticas como el uso de un directorio `shared` para componentes y utilidades, existen problemas estructurales que dificultan el mantenimiento.

### 1. Módulos de Lógica Excesivamente Grandes ("God Files")
*   **Hallazgo:** Varios archivos TypeScript (`.ts`) en los directorios de módulos (`clients/modules/` y `employees/modules/`) han crecido de forma desproporcionada, superando los 30-60KB.
    *   Ejemplos en `clients`: `active-orders.ts` (61KB), `menu-flow.ts` (39KB), `tables-manager.ts` (38KB).
    *   Ejemplos en `employees`: `menu-manager.ts` (48KB), `payments-flow.ts` (47KB), `cashier-board.ts` (41KB).
*   **Impacto:** Estos archivos violan el principio de responsabilidad única. Su gran tamaño los hace difíciles de leer, depurar, probar y mantener. Cualquier cambio en uno de estos archivos conlleva un alto riesgo de introducir regresiones.
*   **Acción Recomendada:** Refactorizar estos "god files" en módulos más pequeños y cohesivos. Cada nuevo módulo debe tener una única responsabilidad bien definida (p. ej., un módulo para la lógica de la API, otro para la gestión del estado, otro para los efectos secundarios, etc.).

### 2. Componentes de Vue Monolíticos
*   **Hallazgo:** Algunos componentes de Vue, como `RolesManager.vue` (22KB), son demasiado grandes. Esto suele indicar que el componente maneja demasiada lógica, tiene una plantilla HTML muy extensa o contiene estilos que podrían ser reutilizados.
*   **Impacto:** Los componentes monolíticos son difíciles de reutilizar y probar. La lógica de negocio y la de la vista están demasiado acopladas.
*   **Acción Recomendada:** Descomponer los componentes grandes en sub-componentes más pequeños y enfocados. Extraer la lógica de negocio a "composables" de Vue (`/utils`) o a stores de Pinia para mejorar la reutilización y la testeabilidad.

### 3. Lógica de Negocio Duplicada entre Aplicaciones
*   **Hallazgo:** Se ha identificado una duplicación de lógica conceptual entre las aplicaciones de `clients` y `employees`. Por ejemplo, ambas tienen un archivo `tables-manager.ts` y archivos para gestionar el flujo de pagos (`checkout-handler.ts` y `payments-flow.ts`).
*   **Impacto:** La duplicación de código aumenta el esfuerzo de mantenimiento. Un bug relacionado con la gestión de mesas, por ejemplo, tendría que ser corregido en dos lugares diferentes, aumentando el riesgo de inconsistencias.
*   **Acción Recomendada:** Abstraer la lógica de negocio común (como la gestión de mesas, sesiones, o incluso partes del flujo de pago) al directorio `pronto-static/src/vue/shared`. Esta lógica puede ser expuesta a través de "composables" o servicios compartidos que las aplicaciones de `clients` y `employees` puedan consumir.

---

ID: AUDIT-20260215-FRONTEND-TECH-DEBT
FECHA: 2026-02-15
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Auditoría frontend deuda técnica por módulos monolíticos y duplicación
ESTADO: RESUELTO
SOLUCION: La evidencia original quedó desactualizada y duplicada en el propio documento. Los módulos citados como críticos (`active-orders.ts`, `menu-manager.ts`, `payments-flow.ts`) ya no existen y el inventario actual muestra módulos más pequeños (máximos actuales ~42KB y ~37KB en `cashier-board.ts` y `tables-manager.ts`), con refactorización previa del frontend en chunks y separación de responsabilidades.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
