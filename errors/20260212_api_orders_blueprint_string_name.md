ID: 20260212_api_orders_blueprint_string_name
FECHA: 2026-02-12
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: orders.py Blueprint usa string literal "__name__" en vez de variable __name__
DESCRIPCION: Blueprint("orders", "__name__") pasa el string literal "__name__" como import_name en vez de la variable __name__, causando resolución incorrecta de recursos.
PASOS_REPRODUCIR: Inspeccionar Blueprint registration de orders.
RESULTADO_ACTUAL: Blueprint import_name es el string "__name__".
RESULTADO_ESPERADO: Blueprint import_name es el módulo real.
UBICACION: pronto-api/src/api_app/routes/orders.py:34
EVIDENCIA: Código fuente muestra comillas alrededor de __name__.
HIPOTESIS_CAUSA: Typo al crear el Blueprint.
ESTADO: RESUELTO
SOLUCION: Cambiado "__name__" (string) a __name__ (variable).
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-12
