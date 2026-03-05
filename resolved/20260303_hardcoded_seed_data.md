ID: CODE-20260303-012
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Datos de negocio hardcodeados en seed.py

DESCRIPCION: |
  El archivo `seed.py` (195KB, >5000 líneas) contiene miles de líneas de instanciaciones manuales de objetos `MenuItem`, `MenuCategory` y `Modifier` con datos de negocio (nombres, descripciones, precios) hardcodeados en español directamente en el código Python. 
  
  Esta práctica:
  1. Dificulta enormemente el mantenimiento del catálogo de productos.
  2. Aumenta innecesariamente el tamaño del código fuente.
  3. Impide la fácil localización/traducción del sistema.
  4. Genera riesgo de errores de sintaxis Python al editar datos masivos.

RESULTADO_ACTUAL: |
  Un archivo de más de 5000 líneas que mezcla lógica de base de datos con el catálogo completo de un restaurante.

RESULTADO_ESPERADO: |
  Separar los datos de la lógica. Los datos de semilla deben residir en archivos externos (JSON, CSV o YAML) y `seed.py` debe limitarse a ser un motor de carga que itere sobre dichos archivos.

UBICACION: |
  - `pronto-libs/src/pronto_shared/services/seed.py`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Extraer el catálogo de productos a un archivo `initial_menu.json`.
  - [ ] Refactorizar `seed.py` para cargar los datos desde el JSON.
  - [ ] Implementar un validador de esquema para el archivo de datos.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
