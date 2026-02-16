---
ID: HARDCODED_PLACEHOLDER_URL
FECHA: 20260206
PROYECTO: pronto-employees
SEVERIDAD: baja
TITULO: URL de ejemplo hardcodeada en placeholders de input
DESCRIPCION: Se ha encontrado una URL de ejemplo hardcodeada (`https://ejemplo.com/imagen-producto.jpg`) en el atributo `placeholder` de inputs de tipo URL en los templates de `pronto-employees`. Aunque es un placeholder, el uso de una URL completa y específica como ejemplo viola el principio de evitar hardcodes de URLs y muestra una falta de generalización.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-employees/src/pronto_employees/templates/dashboard.html` o `pronto-employees/src/pronto_employees/templates/includes/_menu_chef.html`.
2. Buscar el input con `id="product-image-url"`.
RESULTADO_ACTUAL: El placeholder muestra una URL de ejemplo `https://ejemplo.com/imagen-producto.jpg`.
RESULTADO_ESPERADO: El placeholder debería ser más genérico, como "URL de la imagen del producto" o si se requiere un formato URL, usar un ejemplo abstracto como "https://example.com/image.jpg" sin implicaciones de un dominio específico.
UBICACION:
- pronto-employees/src/pronto_employees/templates/dashboard.html:L2219
- pronto-employees/src/pronto_employees/templates/includes/_menu_chef.html:L924
EVIDENCIA:
```html
placeholder="https://ejemplo.com/imagen-producto.jpg"
```
HIPOTESIS_CAUSA: Se utilizó un ejemplo práctico para el placeholder sin considerar la directriz de evitar hardcodes.
ESTADO: RESUELTO
SOLUCION: Reemplazado `https://ejemplo.com/imagen-producto.jpg` con `https://example.com/product-image.jpg` en ambos archivos para usar dominio genérico estándar.
FECHA_RESOLUCION: 2026-02-09
---