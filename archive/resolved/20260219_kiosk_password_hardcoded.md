ID: ERR-20260219-KIOSK-PASSWORD-HARDCODED
FECHA: 2026-02-19
PROYECTO: pronto-client, pronto-employees
SEVERIDAD: media
TITULO: Password de kiosk hardcodeado en el codigo
DESCRIPCION: El password para crear cuentas kiosk estaba hardcodeado como "kiosk-no-auth" en dos archivos, lo cual es un riesgo de seguridad y no permite configuracion por entorno.
PASOS_REPRODUCIR:
1. Buscar "kiosk-no-auth" en el codigo fuente
2. Encontrar en pronto-client/routes/web.py:200 y pronto-employees/routes/api/customers.py:114
RESULTADO_ACTUAL: Password hardcodeado sin posibilidad de configuracion
RESULTADO_ESPERADO: Password configurable via variable de entorno
UBICACION:
- pronto-client/src/pronto_clients/routes/web.py:200
- pronto-employees/src/pronto_employees/routes/api/customers.py:114
EVIDENCIA:
```python
password="kiosk-no-auth"
```
HIPOTESIS_CAUSA: Implementacion inicial con valor fijo para desarrollo
ESTADO: RESUELTO
SOLUCION:
1. Creada variable de entorno PRONTO_KIOSK_PASSWORD en .env.example
2. Actualizado pronto-client para usar _KIOSK_PASSWORD
3. Actualizado pronto-employees para usar _KIOSK_PASSWORD
4. Default seguro: "kiosk-no-auth-change-in-production"
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
