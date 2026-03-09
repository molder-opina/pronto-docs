ID: STA-20260307-003
FECHA: 2026-03-07
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: artefactos temporales y reportes fuera de carpeta canonica tmp
DESCRIPCION:
  Se detectaban artefactos temporales de desarrollo/QA en la raiz del repo y carpetas ad-hoc
  (`cart_test.png`, `print_stack*.cjs`, `.wcag_reports/`, `test-results/`), fuera de `tmp/`.
PASOS_REPRODUCIR:
  1. Listar archivos de `pronto-static/`.
  2. Verificar presencia de reportes y scripts temporales fuera de `tmp/`.
RESULTADO_ACTUAL:
  Los artefactos detectados fueron eliminados y `.gitignore` ahora cubre estos residuos temporales.
RESULTADO_ESPERADO:
  Mover/eliminar temporales y concentrarlos en `tmp/` cuando aplique.
UBICACION:
  - pronto-static/cart_test.png
  - pronto-static/print_stack.cjs
  - pronto-static/print_stack2.cjs
  - pronto-static/print_stack3.cjs
  - pronto-static/.wcag_reports/
  - pronto-static/test-results/
EVIDENCIA:
  - `find pronto-static -maxdepth 1 ...` => sin archivos temporales restantes
  - `find pronto-static/.wcag_reports -type f` => sin archivos
  - `find pronto-static/test-results -type f` => sin archivos
HIPOTESIS_CAUSA:
  Ejecuciones manuales de Playwright/WCAG sin limpieza posterior ni redireccion a `tmp/`.
ESTADO: RESUELTO
SOLUCION:
  Se eliminaron los archivos temporales detectados y se agregaron reglas de ignore para `cart_test.png`, `print_stack*.cjs`, `.wcag_reports/` y `test-results/`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07