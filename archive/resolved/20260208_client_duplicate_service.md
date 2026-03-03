---
ID: ERR-20260208-011
FECHA: 2026-02-08
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Código duplicado obsoleto (services/order_service.py)
DESCRIPCION: Existe un archivo order_service.py en pronto-client que contiene una copia de la lógica de validación y creación de órdenes. Este archivo está desactualizado respecto a la versión en pronto-shared (ej. manejo de UUIDs en mesas), lo que genera confusión y bugs si es importado por error.
PASOS_REPRODUCIR:
1) Comparar pronto-client/src/pronto_clients/services/order_service.py con pronto-libs/src/pronto_shared/services/order_write_service.py.
RESULTADO_ACTUAL: Dos archivos con la misma responsabilidad pero lógica divergente.
RESULTADO_ESPERADO: El archivo local debe eliminarse y todas las referencias deben apuntar a la librería compartida.
UBICACION: pronto-client/src/pronto_clients/services/order_service.py
EVIDENCIA: Existencia del archivo con lógica de cálculo de totales redundante.
HIPOTESIS_CAUSA: Residuo de una migración incompleta de servicios a la librería compartida.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Verificar que no haya imports activos hacia el service local.
2. Eliminar pronto-client/src/pronto_clients/services/order_service.py.
3. Asegurar que las rutas del cliente usen pronto_shared.services.order_write_service.
