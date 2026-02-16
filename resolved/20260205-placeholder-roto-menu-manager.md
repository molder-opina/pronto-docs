---
ID: 20260205-F3
FECHA: 2026-02-05
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Ruta a imagen placeholder rota en el gestor de menú
DESCRIPCION: El módulo `menu-manager.ts` intenta cargar una imagen de placeholder desde `'/static/img/placeholder.png'`. Esta ruta es incorrecta por dos razones: 1) Utiliza el prefijo `/static/` en lugar del `/assets/` canónico. 2) El archivo no existe en esa ubicación.
PASOS_REPRODUCIR: 1. Abrir la sección de "Gestión de Menú" en el dashboard de empleados. 2. Intentar visualizar un item del menú que no tenga imagen. 3. Observar la consola del navegador por un error 404 para la imagen del placeholder.
RESULTADO_ACTUAL: La imagen del placeholder no se carga, resultando en un error 404.
RESULTADO_ESPERADO: Se debería mostrar una imagen de placeholder por defecto. La ruta debería apuntar a un archivo existente bajo la carpeta `/assets/`.
UBICACION: `pronto-static/src/vue/employees/modules/menu-manager.ts:85`
EVIDENCIA: `? ... : '/static/img/placeholder.png';` y el resultado del comando `ls` que confirma que el archivo no existe.
HIPOTESIS_CAUSA: Un refactor o cambio en la estructura de directorios de `pronto-static` dejó esta referencia de ruta obsoleta y rota.
ESTADO: RESUELTO
---
SOLUCION: Se reemplazó la ruta rota `'/static/img/placeholder.png'` por una ruta a una imagen existente y válida: `'/assets/images/default-avatar.png'`. Aunque no es un placeholder de producto ideal, previene el error 404.
COMMIT: N/A_AGENT
FECHA_RESOLUCION: 2026-02-05