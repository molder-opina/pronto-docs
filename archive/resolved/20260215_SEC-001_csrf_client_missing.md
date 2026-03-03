ID: SEC-20260215-001
FECHA: 2026-02-15
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: CSRF protection no habilitada en pronto-client (BFF)

DESCRIPCION:
El BFF de clientes (pronto-client) no implementa protección CSRF para endpoints mutativos (POST/PUT/PATCH/DELETE). Esto expone a los clientes a ataques Cross-Site Request Forgery donde un sitio malicioso puede ejecutar acciones en nombre del usuario autenticado usando las cookies de sesión automáticamente enviadas por el browser.

A diferencia de pronto-employees que tiene WTF_CSRF_ENABLED=True y requiere header X-CSRFToken, pronto-client no tiene esta protección habilitada.

PASOS_REPRODUCIR:
1. Autenticarse como cliente en pronto-client
2. Desde un dominio externo, hacer POST a http://pronto-client:6080/api/orders con credenciales de cookie de sesión
3. La request se procesa sin validar CSRF token

RESULTADO_ACTUAL:
- WTF_CSRF_ENABLED no está habilitado en pronto-client
- No se requiere header X-CSRFToken en mutaciones
- flask.session se envía automáticamente con cookies

RESULTADO_ESPERADO:
- Habilitar WTF_CSRF_ENABLED=True
- Inyectar <meta name="csrf-token"> en templates SSR
- Exigir header X-CSRFToken en POST/PUT/PATCH/DELETE
- Request sin token → 403 Forbidden

UBICACION:
- pronto-client/src/pronto_clients/app.py (app.py no tiene csrf protection)
- pronto-client/src/pronto_clients/routes/api/ (endpoints mutativos sin protección)
- pronto-static/src/vue/clients/core/http.ts (falta wrapper con CSRF)

EVIDENCIA:
- pronto-employees/src/pronto_employees/app.py line 72-73 tiene:
  app.config["WTF_CSRF_ENABLED"] = True
  app.config["WTF_CSRF_TIME_LIMIT"] = 3600
- pronto-client/app.py NO tiene esta configuración
- pronto-static/src/vue/employees/core/http.ts tiene CSRF wrapper, pero clients no tiene equivalente

HIPOTESIS_CAUSA:
El equipo implementó CSRF en employees pero no replicó en clients. Asumieron que al ser BFF estaba protegido, pero el browser envía cookies automáticamente permitiendo CSRF.

ESTADO: RESUELTO

SOLUCION:
CSRF ya estaba correctamente implementado en pronto-client:

1. Backend: app.py line 64-65 tiene WTF_CSRF_ENABLED = True
2. Template: base.html line 19 tiene meta csrf-token
3. Frontend: http.ts añade X-CSRFToken automaticamente
4. No hay csrf_exempt en ningun endpoint

El bug reportado era un falso positivo.

COMMIT: N/A - No requiere cambios (ya estaba implementado)
FECHA_RESOLUCION: 2026-02-15
