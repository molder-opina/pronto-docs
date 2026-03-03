---
ID: ERR-20260205-EMP-LOGO-EXT
FECHA: 2026-02-05
PROYECTO: pronto-employees/pronto-static
SEVERIDAD: baja
TITULO: Template empleados referencia branding/logo.png pero assets demo provee branding/logo.jpg
DESCRIPCION: El layout base de empleados referencia `{{ restaurant_assets }}/branding/logo.png`, pero en pronto-static los assets de branding (demo) están como `logo.jpg`. Esto activa el onerror y degrada la UX (aunque no bloquea).
PASOS_REPRODUCIR: 1) Configurar restaurant_assets apuntando a un slug con logo.jpg (ej. assets/cafeteria-de-prueba/branding/logo.jpg). 2) Abrir UI empleados. 3) Ver 404 en logo.png y fallback.
RESULTADO_ACTUAL: 404 en branding/logo.png; se renderiza fallback SVG.
RESULTADO_ESPERADO: Referencia a la extensión correcta o asegurar que exista logo.png en el contenedor estático.
UBICACION: pronto-employees/src/pronto_employees/templates/base.html:1456-1457
EVIDENCIA: `<img src="{{ restaurant_assets | to_https }}/branding/logo.png" ...>` y assets existentes `pronto-static/src/static_content/assets/*/branding/logo.jpg`.
HIPOTESIS_CAUSA: Cambio de formato de asset (png -> jpg) sin actualizar template.
ESTADO: RESUELTO
---
SOLUCION: Se corrigió la extensión del archivo del logo en la plantilla `pronto-employees/src/pronto_employees/templates/base.html` de `.png` a `.jpg` para que coincidiera con el asset real en `pronto-static/src/static_content/assets/pronto/branding/logo.jpg`.
COMMIT: c9665fe
FECHA_RESOLUCION: 2026-02-06