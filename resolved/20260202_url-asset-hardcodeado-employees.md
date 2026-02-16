---
ID: 20260202-A1
FECHA: 2026-02-02
PROYECTO: pronto-employees
SEVERIDAD: bloqueante
TITULO: URL de asset hardcodeada en branding.html
DESCRIPCION: Se ha detectado una URL de asset construida manualmente con JavaScript en una plantilla, en lugar de usar las variables de contexto inyectadas (`assets_*`). Esto viola la regla #6 de AGENTS.md.
PASOS_REPRODUCIR: Revisar el código fuente del archivo `pronto-employees/src/pronto_employees/templates/branding.html`.
RESULTADO_ACTUAL: La URL se construye con `this.config.static_url + '/assets/' + ...`.
RESULTADO_ESPERADO: Se deben utilizar las variables de contexto predefinidas como `{{ assets_images }}` o `{{ restaurant_assets }}`.
UBICACION: pronto-employees/src/pronto_employees/templates/branding.html:90
EVIDENCIA: `this.config.static_url + '/assets/' + this.config.restaurant_slug + '/icons'`
HIPOTESIS_CAUSA: Desconocimiento de las variables de contexto inyectadas o refactorización incompleta.
ESTADO: RESUELTO
---
SOLUCION: Se modificó el backend para que el endpoint `/api/branding/config` devuelva una URL pre-construida (`placeholder_icon_url`). Se actualizó el template `branding.html` para consumir esta nueva URL, eliminando la construcción de la URL en el frontend.
COMMIT: N/A_AGENT
FECHA_RESOLUCION: 2026-02-02