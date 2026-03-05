ID: CODE-20260303-016
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: NameError en servicio de memoria del orquestador

DESCRIPCION: |
  En `QdrantMemory.ensure_collection` se construían URLs usando variables no definidas (`url`, `collection`) en lugar de atributos de instancia (`self.url`, `self.collection`), provocando `NameError` al inicializar colección.

RESULTADO_ACTUAL: |
  `check_url = f"{url}/collections/{collection}"` y `create_url = f"{url}/collections/{collection}"` lanzaban NameError.

RESULTADO_ESPERADO: |
  Uso de atributos de instancia para construir URLs de Qdrant.

UBICACION: |
  - `pronto-libs/src/pronto_shared/orchestrator/memory.py`

ESTADO: RESUELTO

SOLUCION: |
  Se reemplazaron las referencias incorrectas por `self.url` y `self.collection` en `ensure_collection`.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
