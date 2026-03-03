---
ID: 20260205-F4
FECHA: 2026-02-05
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Imagen placeholder de iconos no existe
DESCRIPCION: Varios módulos del frontend (`modal-manager.ts`, `menu-flow.ts`) hacen referencia a una imagen de placeholder en `/assets/pronto/icons/placeholder.png`. Este archivo no existe, lo que causa íconos de imagen rotos en la UI.
PASOS_REPRODUCIR: 1. Navegar un flujo que use un modal con una imagen faltante. 2. Observar el error 404 para `.../assets/pronto/icons/placeholder.png` en la consola.
RESULTADO_ACTUAL: Íconos de imagen rotos en la interfaz.
RESULTADO_ESPERADO: Debería mostrarse una imagen de placeholder.
UBICACION: `pronto-static/src/vue/clients/modules/modal-manager.ts:175` y otros.
EVIDENCIA: La referencia al archivo en el código y el resultado del comando `ls` que confirma que el archivo no existe.
HIPOTESIS_CAUSA: El archivo de imagen nunca fue añadido al repositorio o fue eliminado sin actualizar las referencias en el código.
ESTADO: RESUELTO
---
