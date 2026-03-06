ID: DOCS-20260303-004
FECHA: 2026-03-03
PROYECTO: pronto-docs
SEVERIDAD: alta
TITULO: Guía de variables de entorno (ENVIRONMENT_VARIABLES.md) desactualizada

DESCRIPCION: |
  El documento `ENVIRONMENT_VARIABLES.md` tiene como fecha de última actualización el 2026-01-30. Una revisión comparativa con el cargador de configuración real (`pronto-libs/src/pronto_shared/config.py`) revela que faltan múltiples variables nuevas y que algunas rutas mencionadas son incorrectas.
  
  Variables faltantes o desactualizadas:
  - Variables de Supabase/Storage.
  - Variables de Nginx (`NGINX_HOST`, `NGINX_PORT`).
  - Nuevas variables de debug (`AUTO_READY_QUICK_SERVE`, etc.).
  - Las rutas a archivos de código (`build/shared/config.py`) son obsoletas (ahora en `pronto-libs/...`).

RESULTADO_ACTUAL: |
  Un desarrollador siguiendo esta guía no podrá configurar correctamente el entorno local o de producción, lo que provocará fallos en el arranque de los servicios por falta de variables críticas.

RESULTADO_ESPERADO: |
  Actualizar el documento para reflejar fielmente la estructura de la clase `AppConfig` y las rutinas de validación en `pronto_shared/config.py`.

UBICACION: |
  - `pronto-docs/ENVIRONMENT_VARIABLES.md`

ESTADO: RESUELTO
SOLUCION: Se actualizó `ENVIRONMENT_VARIABLES.md` con variables faltantes de `AppConfig` (Supabase/Storage/Nginx/AUTO_READY_QUICK_SERVE), se corrigieron rutas de referencia al código real (`pronto-libs/src/pronto_shared/config.py`) y se refrescó fecha/versión del documento.
COMMIT: PENDING_AFINACIONFINALV1
FECHA_RESOLUCION: 2026-03-06

ACCIONES_PENDIENTES:
  - [ ] Sincronizar la lista de variables con `pronto_shared/config.py`.
  - [ ] Corregir las rutas a los archivos de referencia.
  - [ ] Añadir sección para variables de orquestador AI (Ollama, Qdrant).
