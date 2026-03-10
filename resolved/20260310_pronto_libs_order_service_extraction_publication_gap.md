ID: LIBS-20260310-ORDER-SERVICE-EXTRACTION-PUBLICATION-GAP
FECHA: 2026-03-10
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: `order_service_impl.py` mantiene lógica duplicada mientras `order_transitions` y `order_delivery` ya tienen consumidores reales
DESCRIPCION: Durante la limpieza incremental de `pronto-libs` se detectó que `order_service_impl.py` seguía concentrando helpers de transición/entrega ya extraídos localmente, mientras consumidores reales en `pronto-api` y tests ya apuntan a `order_transitions.py` y `order_delivery.py`. El gap dejaba la extracción sin publicar y aumentaba el riesgo de drift entre implementaciones duplicadas.
PASOS_REPRODUCIR:
1. Buscar consumidores de `transition_order(` y `deliver_order_items(` en el monorepo.
2. Revisar `pronto-libs/src/pronto_shared/services/order_service_impl.py`.
3. Verificar que `order_helpers.py`, `order_transitions.py` y `order_delivery.py` existen localmente pero no están publicados.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: Los módulos extraídos quedan publicados y `order_service_impl.py` pasa a importar/reexportar esa lógica, evitando duplicación y drift.
UBICACION:
- pronto-libs/src/pronto_shared/services/order_service_impl.py
- pronto-libs/src/pronto_shared/services/order_helpers.py
- pronto-libs/src/pronto_shared/services/order_transitions.py
- pronto-libs/src/pronto_shared/services/order_delivery.py
EVIDENCIA:
- `rg` devolvió consumidores reales en `pronto-api/src/api_app/routes/employees/orders.py` y tests para `transition_order`/`deliver_order_items`.
- `git diff` mostró eliminación local de helpers/transition/delivery desde `order_service_impl.py` y reemplazo por imports de módulos extraídos.
HIPOTESIS_CAUSA: Refactor parcial interrumpido: se extrajeron módulos auxiliares, pero quedó pendiente publicar el bloque completo y cerrar la duplicación en `order_service_impl.py`.
ESTADO: RESUELTO
SOLUCION:
- Se publican `order_helpers.py`, `order_transitions.py` y `order_delivery.py` como módulos extraídos con consumidores reales ya detectados en `pronto-api` y tests.
- `order_service_impl.py` se recablea para importar/reexportar esa lógica, eliminando la duplicación local de helpers, transitions y delivery.
- Validación ejecutada: búsqueda transversal `rg` para verificar consumidores/duplicados y `python3 -m py_compile` sobre los módulos objetivo. Los tests focalizados quedaron bloqueados por el entorno local (`cryptography`/`psycopg2` binarios incompatibles y falta de dependencias completas en el shell), no por un fallo funcional confirmado del refactor.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

