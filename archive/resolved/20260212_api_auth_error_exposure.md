ID: 20260212_api_auth_error_exposure
FECHA: 2026-02-12
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: auth.py refresh endpoint expone mensajes de error internos al cliente
DESCRIPCION: El except genérico en refresh token devuelve str(e) al cliente, pudiendo revelar stack traces, nombres de tablas u otra información interna.
PASOS_REPRODUCIR: Provocar un error en el flujo de refresh token.
RESULTADO_ACTUAL: Mensaje de error interno expuesto en la respuesta JSON.
RESULTADO_ESPERADO: Mensaje genérico al cliente, error real loggeado internamente.
UBICACION: pronto-api/src/api_app/routes/employees/auth.py:179-180
EVIDENCIA: return error_response(f"Refresh failed: {str(e)}")
HIPOTESIS_CAUSA: Falta de sanitización en manejo de errores.
ESTADO: RESUELTO
SOLUCION: Separado JWTError (401) del except genérico (500). Error real se loggea con current_app.logger.error. Cliente recibe mensaje genérico.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-12
