ID: PRONTO-PAY-007
FECHA: 2026-03-15
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Falta de tests E2E para escenarios de permisos de pago
DESCRIPCION: No existen tests E2E o de integración que validen los diferentes escenarios de configuración de permisos de pago. Solo existen tests unitarios para el backend y frontend, pero no hay cobertura para escenarios reales donde se combinan diferentes configuraciones.
PASOS_REPRODUCIR:
1. Buscar tests E2E en pronto-tests que validen configuraciones de permisos de pago
2. Verificar que no existen tests que cubran los tres escenarios principales:
   - Solo meseros pueden cobrar
   - Meseros y cajeros pueden cobrar  
   - Solo cajeros pueden cobrar
3. Observar que no hay tests que validen la consistencia entre backend y frontend
RESULTADO_ACTUAL: Sin cobertura de tests para escenarios de permisos reales. Riesgo alto de regresiones no detectadas.
RESULTADO_ESPERADO: Deben existir tests E2E que validen todos los escenarios de configuración de permisos y la consistencia entre backend y frontend.
UBICACION:
- pronto-tests/tests/e2e/
- pronto-tests/tests/integration/
- pronto-tests/tests/functionality/
EVIDENCIA: Análisis exhaustivo de la suite de tests muestra que solo existen tests unitarios para el servicio de permisos y el composable, pero no hay tests que validen el comportamiento completo del sistema.
HIPOTESIS_CAUSA: Los tests E2E fueron postergados o no se consideraron prioritarios durante el desarrollo inicial del sistema de permisos.
ESTADO: ABIERTO