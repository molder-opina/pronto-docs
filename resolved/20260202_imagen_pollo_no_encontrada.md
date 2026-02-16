---
ID: ERR-20260202-001
FECHA: 2026-02-02
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Imagen pollo_parrilla.png devuelve 404
DESCRIPCION: La imagen de menu pollo_parrilla.png no se encuentra. El archivo existe en el servidor con nombre pollo_parrilla_1769982743280.png pero el seed referencia el nombre incorrecto.
PASOS_REPRODUCIR: Abrir pagina de cliente y ver productos del menu
RESULTADO_ACTUAL: 404 NOT FOUND para pollo_parrilla.png
RESULTADO_ESPERADO: La imagen debe cargarse correctamente
UBICACION: pronto-static/src/static_content/assets/pronto/menu/
EVIDENCIA: /api/config/client_session_validation_interval_minutes devuelve 404
HIPOTESIS_CAUSA: El sistema de upload renombra archivos con timestamp pero el seed.py mantiene referencias al nombre original
SOLUCION: Corregidas referencias en seed.py lineas 1291 y 2420 para usar nombre con timestamp
COMMIT: PENDIENTE
FECHA_RESOLUCION: 2026-02-02
ESTADO: RESUELTO
---
