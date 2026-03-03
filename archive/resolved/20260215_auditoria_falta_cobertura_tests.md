## [BUG - Calidad de Código] Ausencia Crítica de Pruebas Unitarias para Servicios de Negocio Clave

**Componente:** `pronto-libs`, `pronto-tests`
**Severidad:** Alta

**Descripción:**
La auditoría ha revelado una ausencia total de pruebas unitarias para varios servicios de negocio críticos y financieramente sensibles dentro de la librería `pronto_shared`. La falta de estas pruebas constituye una deuda técnica grave, ya que cualquier modificación a estos servicios tiene un alto riesgo de introducir regresiones no detectadas que podrían tener un impacto directo en los cálculos financieros y la lógica de negocio principal.

### 1. Ausencia de Pruebas para `price_service.py`
*   **Hallazgo:** No se encontraron archivos de prueba (ej. `test_price_service.py`) ni pruebas unitarias específicas que validen la lógica dentro de `pronto_shared/services/price_service.py`. Las pruebas existentes solo validan el campo de precio a nivel de la API y del modelo, pero no la lógica de cálculo de impuestos.
*   **Impacto:** La función `calculate_price_breakdown`, que maneja la lógica de precios con y sin impuestos incluidos, no está probada. Un error en esta función podría llevar a que todos los precios y totales de las órdenes en el sistema sean incorrectos. Dado que se identificó y corrigió un bug crítico en este servicio durante la auditoría, la falta de una suite de regresión es especialmente peligrosa.
*   **Acción Recomendada:** Crear una suite de pruebas unitarias para `price_service.py` que cubra todos los casos de la función `calculate_price_breakdown` (modo `tax_included` y `tax_excluded`) con varios valores de entrada para asegurar la precisión de los cálculos.

### 2. Ausencia Total de Pruebas para `order_modification_service.py`
*   **Hallazgo:** La búsqueda de pruebas relacionadas con la modificación de órdenes (`order.*modification`) no arrojó ningún resultado en el directorio `pronto-tests`.
*   **Impacto:** Todo el flujo de modificación de órdenes (creación, aprobación por el cliente, rechazo, aplicación de cambios, recálculo de totales) no tiene ninguna prueba automatizada. Esta es una funcionalidad compleja que modifica órdenes activas, y un bug podría corromper los datos de una orden, causar fallos en el checkout o generar totales incorrectos.
*   **Acción Recomendada:** Desarrollar una suite de pruebas de integración y unitarias para `order_modification_service.py`. Estas pruebas deben cubrir el ciclo de vida completo de una modificación, incluyendo:
    *   Creación de una modificación por un cliente (auto-aplicada).
    *   Creación de una modificación por un mesero (requiere aprobación).
    *   Aprobación y rechazo de una modificación por un cliente.
    *   Validación de que los totales de la orden se recalculan correctamente después de aplicar una modificación.
    *   Pruebas de los casos de error (ej. intentar modificar una orden no modificable).

---

ID: AUDIT-20260215-TEST-COVERAGE
FECHA: 2026-02-15
PROYECTO: pronto-libs, pronto-tests
SEVERIDAD: alta
TITULO: Auditoría de cobertura de pruebas para servicios críticos
ESTADO: RESUELTO
SOLUCION: Verificada cobertura de `price_service` y `order_modification_service` en suites unitarias/integración. Evidencia: `pronto-tests/tests/functionality/unit/test_price_service.py`, `pronto-libs/tests/unit/services/test_price_service.py`, `pronto-tests/tests/functionality/unit/test_order_modification_service.py`, `pronto-libs/tests/unit/services/test_order_modification_service.py`.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
