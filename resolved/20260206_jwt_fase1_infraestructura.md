---
ID: ERR-2026-0206-001
FECHA: 2026-02-06
PROYECTO: pronto-api / pronto-client / pronto-static
SEVERIDAD: alta
TITULO: Migración Fase 1 - Infraestructura JWT unificada para clientes
DESCRIPCION: |
  Implementación de infraestructura base para migrar autenticación de clientes
  a JWT unificado con empleados. Esta Fase 1 incluye:
  
  - CORS cross-host configurado para api.pronto.com
  - Cookies access_token (SameSite=None, Secure, HttpOnly)
  - Endpoints /api/auth/*, /api/sessions/*, /api/branding/* en pronto-api
  - Frontend apuntando a api.pronto.com con credentials:include
  - Eliminación completa de flask.session en pronto-client
  - Clip payment deshabilitado temporalmente
  
  Endpoints auth y sessions funcionan pero retornan placeholders (501)
  hasta que se implementen servicios canónicos en Fase 2.

PASOS_REPRODUCIR: N/A - Feature implementada
RESULTADO_ACTUAL: Infraestructura lista, auth en modo placeholder
RESULTADO_ESPERADO: JWT funcional con servicios canónicos (Fase 2)
UBICACION:
  - pronto-api/src/api_app/routes/client_auth.py
  - pronto-api/src/api_app/routes/client_sessions.py
  - pronto-api/src/api_app/routes/branding.py
  - pronto-static/src/vue/clients/modules/client-profile.ts
  - pronto-static/src/vue/clients/modules/client-base.ts
  - pronto-static/src/vue/clients/modules/thank-you.ts
  - pronto-client/src/pronto_clients/routes/api/orders.py
  - pronto-client/src/pronto_clients/routes/api/notifications.py
  - pronto-client/src/pronto_clients/routes/api/feedback_email.py
  - pronto-client/src/pronto_clients/routes/web.py
  
EVIDENCIA: |
  Cambios aplicados en branch feat/jwt-client-unified
  - 0 flask.session remaining en pronto-client (verificado con rg)
  - CORS configurado con supports_credentials: True
  - Cookie name: access_token (cross-host, SameSite=None, Secure)
  
HIPOTESIS_CAUSA: N/A - Implementación intencional
ESTADO: RESUELTO
SOLUCION: |
  Fase 1 completada:
  1. pronto-api: Nuevos endpoints con CORS y JWT middleware
  2. pronto-static: Cross-host fetch con credentials:include
  3. pronto-client: Eliminación completa flask.session
  
  Fase 2 pendiente (BUG-JWT-DUAL-MODE-001):
  - Wiring servicios canónicos (Customer, DiningSession)
  - JWT dual mode: anonymous (8h) + client (4h)
  
COMMIT: feat/jwt-client-unified
FECHA_RESOLUCION: 2026-02-06
---
