---
ID: ERR-20260202-002
FECHA: 2026-02-02
PROYECTO: pronto-client
SEVERIDAD: baja
TITULO: Endpoint client_session_validation_interval_minutes devuelve 404
DESCRIPCION: El endpoint /api/config/client_session_validation_interval_minutes no encuentra la configuracion en BD y no tiene valor por defecto implementado.
PASOS_REPRODUCIR: Inicializar pagina de cliente y abrir consola
RESULTADO_ACTUAL: 404 NOT FOUND
RESULTADO_ESPERADO: Debe devolver valor por defecto de 15 minutos
UBICACION: pronto-client/src/pronto_clients/routes/api/config.py:47
EVIDENCIA: Error en consola del navegador
HIPOTESIS_CAUSA: Falta agregar valor por defecto en el diccionario defaults de get_config()
SOLUCION: Agregado valor por defecto client_session_validation_interval_minutes al diccionario defaults
COMMIT: PENDIENTE
FECHA_RESOLUCION: 2026-02-02
ESTADO: RESUELTO
---
