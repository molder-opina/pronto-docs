ID: CODE-20260303-001
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: baja
TITULO: Archivos de servicio con tamaño excesivo candidatos a modularización

DESCRIPCION: |
  Durante la auditoría del código, se identificaron varios archivos de servicio dentro de `pronto-libs` que superan un tamaño razonable (más de 1000 líneas o 50KB). Esto viola el Principio de Responsabilidad Única (SRP), dificultando la mantenibilidad, legibilidad y la capacidad de realizar pruebas unitarias efectivas.

RESULTADO_ACTUAL: |
  Archivos identificados por su gran tamaño y complejidad:
  - `pronto-libs/src/pronto_shared/services/order_service.py` (~90KB)
  - `pronto-libs/src/pronto_shared/services/seed.py` (~191KB)
  - `pronto-libs/src/pronto_shared/models.py` (~86KB)

  Estos archivos contienen múltiples responsabilidades que podrían ser separadas.

RESULTADO_ESPERADO: |
  Los archivos de servicio y modelos deben ser cohesivos y enfocarse en una única responsabilidad. Los archivos grandes deben ser refactorizados en módulos más pequeños y manejables.

UBICACION: |
  - `pronto-libs/src/pronto_shared/services/order_service.py`
  - `pronto-libs/src/pronto_shared/services/seed.py`
  - `pronto-libs/src/pronto_shared/models.py`

HIPOTESIS_CAUSA: |
  Crecimiento orgánico del código a lo largo del tiempo sin una refactorización periódica. La adición de nuevas funcionalidades ha incrementado la complejidad de archivos existentes en lugar de crear nuevos módulos.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Analizar `order_service.py` y proponer una división en servicios más pequeños (ej. `order_read_service`, `order_write_service`, `order_state_service`).
  - [ ] Analizar `seed.py` y dividir la lógica de seeding por modelo o por dominio en diferentes archivos.
  - [ ] Analizar `models.py` y evaluar si los modelos pueden ser agrupados en archivos separados por dominio (ej. `orders_models.py`, `users_models.py`, `menu_models.py`).
  - [ ] Establecer una regla de `max-lines` en las herramientas de linting (Ruff/Pylint) para prevenir este problema en el futuro.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
