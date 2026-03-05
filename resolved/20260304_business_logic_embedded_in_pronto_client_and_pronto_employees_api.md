ID: 20260304_business_logic_embedded_in_pronto_client_and_pronto_employees_api
FECHA: 2026-03-04
PROYECTO: pronto-client, pronto-employees, pronto-api, pronto-libs
SEVERIDAD: alta
TITULO: Lógica de negocio embebida en rutas /api de SSR
DESCRIPCION:
Se detectó que `pronto-client` y `pronto-employees` siguen exponiendo rutas `/api/*` con acceso directo a base de datos, validaciones de dominio y reglas de negocio. Esto viola la arquitectura canónica donde la lógica de negocio debe vivir en `pronto-api` y los SSR deben limitarse a UI/SSR y, en el caso permitido, a transporte técnico.
PASOS_REPRODUCIR:
1. Revisar `pronto-client/src/pronto_clients/routes/api/sessions.py`.
2. Revisar `pronto-client/src/pronto_clients/routes/api/shortcuts.py`.
3. Revisar `pronto-employees/src/pronto_employees/routes/api/orders.py`.
4. Revisar `pronto-employees/src/pronto_employees/routes/api/__init__.py`.
RESULTADO_ACTUAL:
Existen rutas `/api/*` en SSR que consultan DB, resuelven mesas, generan defaults, ejecutan reglas de sesión y manipulan datos de negocio fuera de `pronto-api`.
RESULTADO_ESPERADO:
Toda lógica de negocio debe vivir en `pronto-api`. `pronto-client` y `pronto-employees` deben quedar sin lógica de negocio en `/api/*`, usando solo rutas canónicas o proxy técnico permitido sin semántica de dominio.
UBICACION:
- pronto-client/src/pronto_clients/routes/api/sessions.py
- pronto-client/src/pronto_clients/routes/api/shortcuts.py
- pronto-employees/src/pronto_employees/routes/api/orders.py
- pronto-employees/src/pronto_employees/routes/api/__init__.py
EVIDENCIA:
- `pronto-client` consulta `Table`, `DiningSession`, `KeyboardShortcut`, `FeedbackQuestion` desde rutas SSR.
- `pronto-employees` registra múltiples blueprints de negocio completos bajo `/api/*`.
HIPOTESIS_CAUSA:
La migración hacia `pronto-api` quedó incompleta y se mantuvieron rutas SSR con lógica local por conveniencia/compatibilidad.
ESTADO: RESUELTO
SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
