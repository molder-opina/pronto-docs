ID: ARCH-20260303-006
FECHA: 2026-03-03
PROYECTO: pronto-client, pronto-employees
SEVERIDAD: bloqueante
TITULO: Violación crítica de aislamiento de API (API Isolation)

DESCRIPCION: |
  Se ha detectado que tanto `pronto-client` como `pronto-employees` definen, mantienen y sirven endpoints bajo el prefijo `/api/*`. Esto viola directamente la Regla de Oro P0 definida en `AGENTS.md` (Sección 12.1), la cual establece que la única ruta canónica de API es "/api/*" servida exclusivamente por `pronto-api` en el puerto 6082. 
  
  En `pronto-client`, se encuentran más de 15 archivos de rutas de API (auth, orders, payments, split_bills, etc.) que contienen lógica de negocio y proxying manual.
  En `pronto-employees`, se han migrado solo parcialmente las rutas, manteniendo una estructura de API paralela a `pronto-api`.

PASOS_REPRODUCIR: |
  1. Inspeccionar `pronto-client/src/pronto_clients/routes/api/`
  2. Inspeccionar `pronto-employees/src/pronto_employees/routes/api/`
  3. Verificar registros de blueprints en `app.py` de ambos servicios.

RESULTADO_ACTUAL: |
  Múltiples servicios exponen la misma estructura de rutas `/api/*`, fragmentando la lógica de negocio y dificultando el mantenimiento de la seguridad y el despliegue.

RESULTADO_ESPERADO: |
  Toda la lógica de `/api/*` debe vivir únicamente en `pronto-api`. `pronto-client` y `pronto-employees` deben ser servicios puramente SSR/UI que consuman la API central.

UBICACION: |
  - `pronto-client/src/pronto_clients/routes/api/`
  - `pronto-employees/src/pronto_employees/routes/api/`

HIPOTESIS_CAUSA: |
  Migración incompleta hacia la arquitectura de "API Única". El código legacy no se ha movido totalmente a `pronto-api` o no se ha desactivado en los servicios de UI.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Migrar los endpoints restantes de `pronto-client` a `pronto-api`.
  - [ ] Eliminar la carpeta `routes/api` de `pronto-client` una vez completada la migración.
  - [ ] Unificar las rutas de `pronto-employees` en `pronto-api` y configurar el frontend para apuntar directamente al puerto 6082.
  - [ ] Desactivar el registro de `api_bp` en los servicios de UI.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
