---
ID: MENU-20260202-001
FECHA: 2026-02-02
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Menú no visible en dashboard de waiters
DESCRIPCION:
Los archivos de plantilla de menú existen en pronto-employees/templates/includes/ (_menu_waiter.html y _menu_chef.html) pero NO son incluidos en los dashboards correspondientes.

El problema específico es que waiter/dashboard.html no hace include del archivo _menu_waiter.html, por lo que el menú no se muestra en la interfaz de meseros.

PASOS_REPRODUCIR:
1. Navegar a http://localhost:6081/waiter/dashboard
2. Iniciar sesión como mesero
3. Observar que NO aparece la sección de menú ("🍽️ Catálogo de productos")

RESULTADO_ACTUAL:
La sección de menú no se muestra en el dashboard de waiters. Solo aparece la sección de órdenes.

RESULTADO_ESPERADO:
Debería aparecer el menú de productos con el título "🍽️ Catálogo de productos" después de la sección de órdenes, permitiendo a los meseros consultar precios, ingredientes y disponibilidad.

UBICACION:
- Template: pronto-employees/src/pronto_employees/templates/waiter/dashboard.html
- Include faltante: pronto-employees/src/pronto_employees/templates/includes/_menu_waiter.html
- Datos disponibles: pronto-employees/src/pronto_employees/routes/waiter/auth.py (línea 169: menu_data = list_menu())

EVIDENCIA:
- _menu_waiter.html existe en templates/includes/
- _menu_chef.html existe en templates/includes/
- dashboard.html NO hace {% include 'includes/_menu_waiter.html' %}
- La variable `menu` está disponible en el contexto (definida en routes/waiter/auth.py)

HIPOTESIS_CAUSA:
El include del menú nunca fue agregado al dashboard de waiters durante el desarrollo inicial del componente de menú. Los archivos de menú fueron creados en la carpeta includes/ pero no fueron integrados en los dashboards correspondientes.

ESTADO: RESUELTO
SOLUCION:
Se agregó el include 'includes/_menu_waiter.html' en waiter/dashboard.html después de la sección principal de órdenes (antes del header legacy oculto).

COMMIT: pendiente de commit
FECHA_RESOLUCION: 2026-02-02
---
