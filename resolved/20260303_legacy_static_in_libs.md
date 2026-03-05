ID: ARCH-20260303-009
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Residuos de frontend legacy dentro de pronto_shared

DESCRIPCION: |
  Se ha identificado una carpeta `static/` completa dentro de `pronto-libs/src/pronto_shared`. Esta carpeta contiene archivos JavaScript, CSS y TypeScript que parecen ser una versión antigua o redundante de la lógica de frontend. 
  
  La existencia de este código en la librería de servidor:
  1. Rompe la separación de responsabilidades.
  2. Genera confusión sobre cuál es el código de frontend activo (Vue en `pronto-static` vs Vanilla JS en `pronto_shared`).
  3. Aumenta el peso de la librería compartida innecesariamente.

RESULTADO_ACTUAL: |
  Presencia de código de UI (waiter-board, realtime, shortcuts) dentro de un paquete Python. Parte de este código es referenciado por servicios de backend, lo que indica un acoplamiento indebido.

RESULTADO_ESPERADO: |
  Eliminar todo el contenido de `pronto_shared/static` y asegurar que cualquier lógica necesaria (ej. constantes de teclado) resida exclusivamente en `pronto-static` o sea servida vía API desde el backend sin depender de archivos estáticos locales en la librería.

UBICACION: |
  - `pronto-libs/src/pronto_shared/static/`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Identificar si algún archivo en esta carpeta es consumido por el proceso de build de `pronto-static`.
  - [ ] Migrar las constantes o lógica compartida a `pronto-static/src/vue/shared`.
  - [ ] Eliminar la carpeta `static/` de la librería Python.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
