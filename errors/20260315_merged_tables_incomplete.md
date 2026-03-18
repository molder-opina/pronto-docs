ID: PRONTO-PAY-032
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: media
TITULO: Implementación incompleta de mesas unidas con posibles inconsistencias
DESCRIPCION: Aunque la funcionalidad de mesas unidas está implementada, puede tener inconsistencias relacionadas con la gestión de sesiones y pagos. Cuando se unen mesas, las sesiones secundarias se cierran con estado 'merged', pero no está claro cómo se manejan los pagos pendientes o las órdenes en diferentes estados.
PASOS_REPRODUCIR:
1. Crear múltiples sesiones en diferentes mesas
2. Tener órdenes en diferentes estados (new, queued, delivered, etc.)
3. Unir las mesas
4. Observar cómo se manejan las órdenes y pagos pendientes
5. Verificar si hay inconsistencias en los totales o estados
RESULTADO_ACTUAL: Funcionalidad de mesas unidas implementada pero con posibles inconsistencias en la gestión de órdenes y pagos pendientes cuando se fusionan sesiones.
RESULTADO_ESPERADO: La fusión de mesas debe manejar adecuadamente todas las órdenes y pagos pendientes, garantizando la consistencia financiera y operativa.
UBICACION:
- pronto-libs/src/pronto_shared/services/dining_session_service_impl.py:365-482
- pronto-api/src/api_app/routes/employees/sessions.py:439-464
EVIDENCIA: El análisis del código muestra que la fusión de mesas cierra sesiones secundarias con estado 'merged', pero no está claro cómo se manejan los escenarios complejos con órdenes y pagos en diferentes estados.
HIPOTESIS_CAUSA: La implementación se enfocó en el caso básico de fusión de mesas sin considerar adecuadamente los escenarios complejos con órdenes y pagos pendientes.
ESTADO: ABIERTO