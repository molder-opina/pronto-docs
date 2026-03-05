ID: ARCH-20260303-010
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: critica
TITULO: Acoplamiento de sistema de archivos entre backend y frontend

DESCRIPCION: |
  El servicio `shortcuts_static_service.py` utiliza rutas absolutas de Linux (ej. `/opt/pronto/pronto-static/...`) para intentar escribir archivos de configuración directamente en el directorio de otro servicio (`pronto-static`). 
  
  Esto viola el principio de aislamiento de servicios en Docker:
  1. El backend no debería tener permisos de escritura en el contenedor de estáticos.
  2. Las rutas fallarán si se despliega en un entorno diferente (ej. desarrollo local en macOS vs contenedores).
  3. Rompe la capacidad de escalar los servicios independientemente.

RESULTADO_ACTUAL: |
  Uso de `Path("/opt/pronto/...")` y `Path("/var/www/...")` hardcodeados en el código Python. Fallos silenciosos o logs de advertencia en entornos locales.

RESULTADO_ESPERADO: |
  El backend debe exponer los atajos a través de un endpoint de API (`/api/shortcuts`). El frontend debe consumir esta API y, si es necesario por rendimiento, cachear el resultado en su propio almacenamiento local (Redis o LocalStorage) sin depender de escrituras directas en disco por parte del backend.

UBICACION: |
  - `pronto-libs/src/pronto_shared/services/shortcuts_static_service.py` (función `get_shortcuts_static_paths`)

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Eliminar la lógica de escritura directa a disco hacia otros servicios.
  - [ ] Implementar el endpoint `/api/employees/auth/shortcuts` en `pronto-api`.
  - [ ] Refactorizar el frontend para cargar los atajos desde la API durante el bootstrap de la aplicación.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
