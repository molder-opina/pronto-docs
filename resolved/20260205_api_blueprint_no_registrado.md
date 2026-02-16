---
ID: ERR-20260205-API-BLUEPRINT-NO-REG
FECHA: 2026-02-05
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: pronto-api no registra blueprint /api; rutas no existen en runtime
DESCRIPCION: Los endpoints esperados por UI para realtime/notifications existen a nivel de codigo, pero pronto-api no registra el blueprint con url_prefix /api. Esto provoca 404 y reabre el problema reportado en ERR-20260203-REALTIMEEVENTS y relacionados.
PASOS_REPRODUCIR: 1) Iniciar pronto-api. 2) Llamar GET /api/realtime/notifications. 3) Ver 404. 4) Revisar pronto-api/src/api_app/app.py y confirmar ausencia de app.register_blueprint(api_bp, url_prefix=\"/api\").
RESULTADO_ACTUAL: /api/* no se enruta; endpoints no existen en runtime.
RESULTADO_ESPERADO: app registra api_bp con url_prefix \"/api\" y expone /api/realtime/notifications y /api/notifications/*.
UBICACION: pronto-api/src/api_app/app.py
EVIDENCIA: No existe register_blueprint(api_bp, url_prefix=\"/api\") en app.py; rutas viven en pronto-api/src/api_app/routes/*.
HIPOTESIS_CAUSA: Faltante de wiring del blueprint en create_app() durante refactor de rutas.
ESTADO: RESUELTO
---

SOLUCION: Se registro el blueprint api_bp con url_prefix \"/api\" en pronto-api/src/api_app/app.py para habilitar rutas /api/realtime/notifications y /api/notifications/*.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-05
