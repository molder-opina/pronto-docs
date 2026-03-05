ID: CODE-20260303-017
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: baja
TITULO: Código inalcanzable en load_config en config.py

DESCRIPCION: |
  `load_config` retornaba `AppConfig(...)` de forma inmediata y dejaba inalcanzable el bloque de logging de debug antes del `return config` final.

RESULTADO_ACTUAL: |
  El logging de verificación de configuración estática no se ejecutaba en debug.

RESULTADO_ESPERADO: |
  Ejecutar logging en debug y retornar `config` al final.

UBICACION: |
  - `pronto-libs/src/pronto_shared/config.py`

ESTADO: RESUELTO

SOLUCION: |
  Se refactorizó `load_config` para asignar primero `config = AppConfig(...)`, luego ejecutar bloque de logs de debug y finalmente `return config`.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
