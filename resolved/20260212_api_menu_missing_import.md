ID: 20260212_api_menu_missing_import
FECHA: 2026-02-12
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: menu.py usa success_response sin importarlo
DESCRIPCION: En menu.py se usa success_response() pero solo se importa error_response de pronto_shared.serializers.
PASOS_REPRODUCIR: Llamar a un endpoint de menu que use success_response.
RESULTADO_ACTUAL: NameError: name 'success_response' is not defined
RESULTADO_ESPERADO: Respuesta exitosa serializada correctamente.
UBICACION: pronto-api/src/api_app/routes/menu.py:16
EVIDENCIA: Import solo incluye error_response.
HIPOTESIS_CAUSA: Omisión al agregar success_response a la ruta.
ESTADO: RESUELTO
SOLUCION: Agregado success_response al import existente de pronto_shared.serializers.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-12
