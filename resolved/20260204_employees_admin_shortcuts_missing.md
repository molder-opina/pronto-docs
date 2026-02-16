---
ID: ERR-20260204-ADMIN-SHORTCUTS
FECHA: 2026-02-04
PROYECTO: pronto-static/pronto-employees
SEVERIDAD: media
TITULO: UI de atajos admin consume /api/admin/shortcuts sin backend
DESCRIPCION: El componente de atajos en pronto-static realiza CRUD en /api/admin/shortcuts, pero no hay rutas correspondientes en pronto-employees ni pronto-api.
PASOS_REPRODUCIR: 1) Abrir sección de atajos en admin. 2) Intentar cargar/crear/editar/eliminar un atajo. 3) Ver requests a /api/admin/shortcuts.
RESULTADO_ACTUAL: 404 en /api/admin/shortcuts.
RESULTADO_ESPERADO: Endpoints /api/admin/shortcuts disponibles o UI ajustada al backend real.
UBICACION: pronto-static/src/vue/employees/components/ShortcutsManager.vue:202,225,285,313
EVIDENCIA: fetch('/api/admin/shortcuts') y variantes en ShortcutsManager.vue; no existen rutas en pronto-employees/src ni en pronto-api/src.
HIPOTESIS_CAUSA: Implementación de API faltante en BFF de empleados.
ESTADO: RESUELTO
---

SOLUCION:
Se implementaron endpoints `/api/admin/shortcuts` en `pronto-employees` (BFF) con respuesta JSON estable.

COMMIT:
2f6533a

FECHA_RESOLUCION:
2026-02-05
