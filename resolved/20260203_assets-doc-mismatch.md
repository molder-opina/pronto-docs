---
ID: ERR-20260203-ASSETS-DOC-MISMATCH
FECHA: 2026-02-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Documentacion de assets estatica no coincide con estructura real
DESCRIPCION: AGENTS.md define assets_images como /assets/pronto y estructura static_content con clients/employees/shared/clientsvue, pero la estructura real es /assets/{css,js,images,lib,branding,pronto} y la configuracion en pronto-libs expone assets_images en /assets/images.
PASOS_REPRODUCIR: 1) Abrir AGENTS.md seccion pronto-static. 2) Listar pronto-static/src/static_content y pronto-static/src/static_content/assets. 3) Revisar pronto-libs/src/pronto_shared/config.py static_assets_path y el uso de assets_images en pronto-client/pronto-employees.
RESULTADO_ACTUAL: Documentacion y variables de contexto no coinciden con la estructura real de assets.
RESULTADO_ESPERADO: AGENTS.md y variables de contexto reflejan rutas reales o se ajusta estructura para coincidir.
UBICACION: AGENTS.md; pronto-static/src/static_content; pronto-libs/src/pronto_shared/config.py
EVIDENCIA: pronto-static/src/static_content/assets contiene css/js/images/lib/branding/pronto; assets_images apunta a /assets/images.
HIPOTESIS_CAUSA: Documentacion desactualizada tras reorganizacion de assets.
ESTADO: ABIERTO
---
