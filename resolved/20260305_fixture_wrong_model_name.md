ID: TEST-006
FECHA: 2026-03-05
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Fixtures de tests usan nombres de modelos incorrectos
DESCRIPCION: Los fixtures en conftest.py como sample_category importan Category en vez de MenuCategory, causando ImportError.
PASOS_REPRODUCIR:
1. Ejecutar tests que usen sample_category
2. Observar ImportError: "cannot import name 'Category'"
RESULTADO_ACTUAL: ImportError
RESULTADO_ESPERADO: El import debería ser MenuCategory
UBICACION: pronto-tests/conftest.py
EVIDENCIA: sample_category fixture fallaba
HIPOTESIS_CAUSA: El modelo fue renombrado a MenuCategory pero los fixtures no se actualizaron
ESTADO: RESUELTO
SOLUCION: Cambiado import de Category a MenuCategory en sample_category fixture
COMMIT: N/A (fix en conftest.py)
FECHA_RESOLUCION: 2026-03-05
