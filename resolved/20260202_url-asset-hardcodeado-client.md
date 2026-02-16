---
ID: 20260202-A2
FECHA: 2026-02-02
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: URLs de assets hardcodeadas en base.html
DESCRIPCION: Se ha detectado el uso del patrón `{{ static_host_url }}/assets/...` para construir URLs de assets. Esto está explícitamente marcado como incorrecto en la regla #6 de AGENTS.md y viola la arquitectura de estáticos.
PASOS_REPRODUCIR: Revisar el código fuente del archivo `pronto-client/src/pronto_clients/templates/base.html`.
RESULTADO_ACTUAL: Las URLs de imágenes y scripts se construyen manualmente usando `static_host_url`.
RESULTADO_ESPERADO: Se deben utilizar las variables de contexto específicas como `{{ assets_images }}`, `{{ assets_js_clients }}`, y `{{ assets_js_shared }}`.
UBICACION: pronto-client/src/pronto_clients/templates/base.html:1384, 3298, 3380
EVIDENCIA: 
- `<img src="{{ static_host_url }}/assets/images/default-avatar.png" ...>`
- `<script type="module" src="{{ static_host_url }}/assets/js/clients/base.js...>`
- `<script defer src="{{ static_host_url }}/assets/js/shared/bindings.js">`
HIPOTESIS_CAUSA: Desconocimiento de las variables de contexto específicas o un patrón de codificación antiguo que no ha sido actualizado.
ESTADO: RESUELTO
---
SOLUCION: Se modificó el archivo `pronto-client/src/pronto_clients/templates/base.html` para reemplazar las URLs hardcodeadas por las variables de contexto correctas (`assets_images`, `assets_js_clients`, `assets_js`).
COMMIT: N/A_AGENT
FECHA_RESOLUCION: 2026-02-02