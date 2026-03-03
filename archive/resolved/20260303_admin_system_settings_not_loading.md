ID: ERR-20260303-ADMIN-SYSTEM-SETTINGS-NOT-LOADING
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Vista de Configuración en admin no carga los parámetros del sistema
DESCRIPCION: Al entrar a `/admin/dashboard/config`, la vista muestra `Sin coincidencias` aun con el buscador vacío, aunque el endpoint `/api/config` sí expone parámetros. El frontend queda con `configs=[]` por leer un shape de respuesta incorrecto.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/config`.
2. Esperar la carga inicial.
3. Observar que no aparecen parámetros y la pantalla entra al estado vacío.
RESULTADO_ACTUAL: La lista de parámetros del sistema no se renderiza.
RESULTADO_ESPERADO: La vista debe cargar y agrupar los parámetros devueltos por `/api/config`.
UBICACION: pronto-static/src/vue/employees/admin/views/config/SystemSettings.vue
EVIDENCIA: Captura compartida por el usuario en sesión.
HIPOTESIS_CAUSA: `SystemSettings.vue` consume `res.configs`, pero el endpoint responde envuelto en `success_response` como `data.configs`.
ESTADO: RESUELTO
SOLUCION: Se corrigió `SystemSettings.vue` para leer el contrato real del endpoint `/api/config`, que responde con `success_response` y expone los parámetros en `data.configs`. La vista ahora también conserva compatibilidad defensiva con un shape legacy `configs` si llegara a aparecer.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
