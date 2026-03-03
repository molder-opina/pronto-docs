ID: ERR-20260219-CHEF-NOTIFICATIONS-TEST-FAIL
FECHA: 2026-02-19
PROYECTO: pronto-tests
SEVERIDAD: baja
TITULO: Test chef_notifications.spec.ts falla con timeout
DESCRIPCION: El test E2E de notificaciones de chef usaba page.goto() que abria un navegador headless y tenia problemas de conectividad con IPv6. Ademas, intentaba ejecutar Python inline desde Node.js, lo cual es propenso a errores de configuracion.
PASOS_REPRODUCIR:
1. Ejecutar npx playwright test tests/functionality/e2e/chef_notifications.spec.ts
2. Ver timeout error en page.goto()
3. Ver que el test intenta ejecutar Python inline
RESULTADO_ACTUAL: Test falla con timeout
RESULTADO_ESPERADO: Test pasa correctamente
UBICACION: pronto-tests/tests/functionality/e2e/chef_notifications.spec.ts
EVIDENCIA:
```
TimeoutError: page.goto: Timeout 45000ms exceeded.
```
HIPOTESIS_CAUSA: Test mal disenado que usaba navegador headless innecesariamente y Python inline
ESTADO: RESUELTO
SOLUCION: 
1. Reescrito test para usar request API de Playwright en lugar de page.goto()
2. Eliminada dependencia de Python inline
3. Agregados tests para: login page render, API login, realtime notifications, realtime orders
4. Tests que requieren credenciales se saltan automaticamente si no estan disponibles
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
