---
ID: ERR-20260203-DEFAULT-AVATAR
FECHA: 2026-02-03
PROYECTO: pronto-client / pronto-static
SEVERIDAD: baja
TITULO: Default avatar no existe en assets
DESCRIPCION: La plantilla de cliente referencia {{ assets_images }}/default-avatar.png pero el archivo no existe en pronto-static.
PASOS_REPRODUCIR:
1. Abrir una vista que renderice el avatar por defecto en pronto-client.
2. Cargar la pagina.
RESULTADO_ACTUAL: La imagen default-avatar.png retorna 404.
RESULTADO_ESPERADO: La imagen default-avatar.png carga correctamente.
UBICACION: /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/templates/base.html:1384
EVIDENCIA: Falta el archivo /Users/molder/projects/github-molder/pronto/pronto-static/src/static_content/assets/pronto/default-avatar.png.
HIPOTESIS_CAUSA: Asset eliminado o renombrado (existen avatars en /assets/pronto/avatars).
ESTADO: ABIERTO
---
