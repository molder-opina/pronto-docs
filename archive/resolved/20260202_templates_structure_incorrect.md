---
ID: DOCS-20260202-003
FECHA: 2026-02-02
PROYECTO: pronto-employees
SEVERIDAD: baja
TITULO: Estructura de templates incorrecta en pronto-docs/pronto-employees/README.md
DESCRIPCION:
La documentación pronto-docs/pronto-employees/README.md menciona una estructura de templates que no existe en la realidad. Específicamente menciona carpetas de templates por rol que no existen.

PASOS_REPRODUCIR:
1. Listar pronto-employees/src/pronto_employees/templates/
2. Verificar que NO existen las carpetas:
   - templates/chef/
   - templates/cashier/
   - templates/admin/
   - templates/system/
3. Abrir pronto-docs/pronto-employees/README.md y buscar "Template Structure"

RESULTADO_ACTUAL:
README.md menciona:
- templates/waiter/*.html - CORRECTO
- templates/chef/*.html - INCORRECTO (no existe carpeta chef/)
- templates/cashier/*.html - INCORRECTO (solo existe dashboard.html)
- templates/admin/*.html - INCORRECTO (no existe carpeta admin/)
- templates/system/*.html - INCORRECTO (no existe carpeta system/)

RESULTADO_ESPERADO:
README.md debería documentar la estructura real:
- templates/waiter/dashboard.html
- templates/cashier/dashboard.html
- templates/admin_shortcuts.html
- templates/feedback_dashboard.html
- templates/roles_management.html
- templates/includes/ (archivos compartidos)

UBICACION:
- pronto-employees/src/pronto_employees/templates/
- pronto-docs/pronto-employees/README.md:406-412

EVIDENCIA:
ls pronto-employees/src/pronto_employees/templates/

HIPOTESIS_CAUSA:
La documentación se escribió basándose en un diseño arquitectónico planeado pero nunca implementado completamente. Las rutas de templates existen en el código (routes/waiter/, routes/cashier/, etc.) pero los templates se organizan de forma diferente.

ESTADO: RESUELTO
---
