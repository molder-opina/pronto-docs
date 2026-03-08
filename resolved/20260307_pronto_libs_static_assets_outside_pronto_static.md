ID: LIBS-20260307-005
FECHA: 2026-03-07
PROYECTO: pronto-libs
SEVERIDAD: critica
TITULO: pronto-libs mantiene estáticos (JS/CSS) fuera de pronto-static
DESCRIPCION:
  AGENTS.md define que todo contenido estático debe vivir exclusivamente en `pronto-static`.
  `pronto-libs` contiene árbol de assets en `src/pronto_shared/static/**`, incluyendo JS/TS/CSS.
PASOS_REPRODUCIR:
  1. Listar archivos bajo `pronto-libs/src/pronto_shared/static/`.
  2. Verificar presencia de CSS y JS/TS en ese árbol.
RESULTADO_ACTUAL:
  Propiedad de estáticos distribuida fuera del repositorio canónico `pronto-static`.
RESULTADO_ESPERADO:
  Centralizar assets en `pronto-static` y dejar en libs solo código compartido no estático.
UBICACION:
  - pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts
  - pronto-libs/src/pronto_shared/static/js/src/core/http.ts
  - pronto-libs/src/pronto_shared/static/css/styles.css
EVIDENCIA:
  - Estructura `pronto-libs/src/pronto_shared/static/js/**` y `.../static/css/**` presente.
HIPOTESIS_CAUSA:
  Arrastre histórico de assets SSR previos a la consolidación en `pronto-static`.
ESTADO: RESUELTO
SOLUCION:
  Se eliminaron los archivos bajo `pronto-libs/src/pronto_shared/static/**`,
  `pronto-libs/pyproject.toml` dejó de empaquetarlos, `shortcuts_static_service.py`
  ya solo resuelve assets desde `pronto-static`, y una regresión unitaria exige que
  ese árbol no vuelva a contener archivos.
COMMIT: afa7192
FECHA_RESOLUCION: 2026-03-07