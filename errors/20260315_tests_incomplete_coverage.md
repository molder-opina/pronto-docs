ID: PRONTO-PAY-021
FECHA: 2026-03-15
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Cobertura incompleta de tests para escenarios de permisos y estados
DESCRIPCION: Los tests existentes no cubren adecuadamente los escenarios críticos del sistema de permisos de pago y la gestión de estados. Faltan tests E2E que validen la consistencia entre backend y frontend, y tests que verifiquen los invariantes financieros como remaining_balance = 0 al cerrar sesión.
PASOS_REPRODUCIR:
1. Analizar la cobertura de tests existentes
2. Observar que solo existen tests unitarios para el servicio de permisos y el composable
3. Verificar que no hay tests E2E para los tres escenarios principales de permisos
4. Confirmar que no hay tests que validen invariantes financieros
RESULTADO_ACTUAL: Cobertura de tests incompleta que no valida escenarios reales ni garantiza la integridad financiera del sistema.
RESULTADO_ESPERADO: Deben existir tests E2E que cubran todos los escenarios de permisos, validen la consistencia entre backend y frontend, y garanticen los invariantes financieros.
UBICACION:
- pronto-tests/tests/e2e/
- pronto-tests/tests/integration/
- pronto-tests/tests/functionality/
EVIDENCIA: El análisis de la suite de tests muestra que la cobertura se limita a tests unitarios y falta validación de escenarios completos y consistentes.
HIPOTESIS_CAUSA: Los tests E2E fueron considerados de menor prioridad durante el desarrollo inicial, o se postergaron para una fase posterior que nunca se implementó.
ESTADO: ABIERTO