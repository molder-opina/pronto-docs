---
ID: CLIENT_FE_API_WRAPPER_NON_COMPLIANCE
FECHA: 20260206
PROYECTO: pronto-static
SEVERIDAD: bloqueante
TITULO: Incumplimiento del wrapper obligatorio para llamadas a la API en el frontend de clientes
DESCRIPCION: A pesar de que `pronto-static/src/vue/clients/core/http.ts` define un wrapper (`requestJSON`) para las llamadas a la API, no se ha encontrado ninguna importación de `http.ts` ni uso de sus funciones (`requestJSON`) dentro de `pronto-static/src/vue/clients`. Esto indica una grave inconsistencia arquitectónica y un incumplimiento de los patrones esperados para la comunicación API desde el frontend, similar al hallazgo en el frontend de empleados.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-static/src/vue/clients/core/http.ts` para confirmar la definición de `requestJSON`.
2. Realizar una búsqueda exhaustiva de `import .* from '\./core/http'` (o variaciones) y de `requestJSON` en los archivos `.js`, `.ts`, `.vue` dentro de `pronto-static/src/vue/clients`.
RESULTADO_ACTUAL: No se encontró evidencia de que las funciones del wrapper (`requestJSON`) o el propio módulo `http.ts` sean importados o utilizados en el frontend de clientes. Esto sugiere que las llamadas a la API se están realizando de una manera no estandarizada o que no se están realizando llamadas a la API en absoluto.
RESULTADO_ESPERADO: El frontend de clientes debe utilizar el wrapper `http.ts` (`requestJSON`) para todas las llamadas a la API, para asegurar un manejo consistente de la comunicación.
UBICACION:
- pronto-static/src/vue/clients/core/http.ts (definición del wrapper)
- pronto-static/src/vue/clients/ (módulo donde debería usarse)
EVIDENCIA:
```bash
# Búsqueda de importación del wrapper
search_file_content(case_sensitive=False, dir_path='pronto-static/src/vue/clients', include='*.ts|*.js|*.vue', no_ignore=True, pattern='import .* from '\./core/http'')
# Output: No matches found

# Búsqueda de uso de requestJSON
search_file_content(case_sensitive=False, dir_path='pronto-static/src/vue/clients', include='*.ts|*.js|*.vue', no_ignore=True, pattern='requestJSON')
# Output: No matches found
```
HIPOTESIS_CAUSA: La arquitectura del frontend no sigue el patrón establecido para las llamadas a la API, o el `http.ts` es un código muerto no utilizado por el resto de la aplicación cliente.
ESTADO: ABIERTO
---