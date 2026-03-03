ID: AUTH-014
FECHA: 2026-02-14
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Vue admin panel - UI gestión de kioskos
DESCRIPCION: 
No hay interfaz Vue en admin para gestionar kioskos.
Se requiere panel con tabla, crear, eliminar.
PASOS_REPRODUCIR:
1. Ir a http://localhost:6081/admin/customers/kiosks
2. 404 o página sin componente
RESULTADO_ACTUAL:
Sin UI de gestión kioskos
RESULTADO_ESPERADO:
- Componente Vue KiosksManager
- Tabla con kioskos existentes
- Modal crear kiosko
- Confirmación eliminar
UBICACION:
- pronto-static/src/vue/employees/components/admin/KiosksManager.vue (nuevo)
- pronto-static/src/vue/employees/views/admin/KiosksView.vue (nuevo)
EVIDENCIA:
Archivos no existen
HIPOTESIS_CAUSA:
Funcionalidad no implementada
ESTADO: POSTERGADO
DEPENDENCIAS: AUTH-013 (requiere API endpoints)
BLOQUEA: Ninguna
NOTA: UI de gestión de kioskos puede implementarse posteriormente. El API está listo.