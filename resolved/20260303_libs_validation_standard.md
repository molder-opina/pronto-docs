ID: CODE-20260303-LIBS-VALIDATION
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Falta de capa de validación y serialización estandarizada

DESCRIPCION: |
  El proyecto carece de una capa de validación de datos (como Pydantic) y serialización (como Marshmallow o Pydantic) estandarizada. Actualmente, la validación se realiza mediante sentencias `if/else` manuales o métodos en los modelos, y la serialización se hace mediante funciones `to_dict()` personalizadas que son propensas a errores (ej. el bug detectado con UUIDs).
  
  Esto provoca:
  1. Código repetitivo en los controladores de API.
  2. Documentación de API (OpenAPI) difícil de generar automáticamente.
  3. Errores de tipo en tiempo de ejecución.

RESULTADO_ACTUAL: |
  Mezcla de validación manual en rutas y servicios. Serializadores `serialize_*` manuales en `serializers.py`.

RESULTADO_ESPERADO: |
  Adoptar **Pydantic** para definir esquemas de entrada y salida (DTOs). Esto permitiría validación automática por parte de Flask (vía integraciones) y serialización robusta que maneje UUIDs, fechas y tipos complejos de forma nativa.

UBICACION: |
  - `pronto-libs/src/pronto_shared/schemas.py` (Casi vacío)
  - `pronto-libs/src/pronto_shared/serializers.py`

ESTADO: RESUELTO
SOLUCION: Revisión concluida sin implementación inmediata: la adopción global de Pydantic/DTO en `pronto-libs` implica cambio arquitectónico transversal y está bloqueada por guardrail P0 (no modificar arquitectura sin instrucción explícita). Se mantiene el stack actual con validación/serialización existente y se deja como mejora mayor futura fuera de este lote correctivo.
COMMIT: PENDING_AFINACIONFINALV1
FECHA_RESOLUCION: 2026-03-06

ACCIONES_PENDIENTES:
  - [ ] Implementar modelos Pydantic para las entidades principales (Order, Employee, MenuItem).
  - [ ] Migrar los serializadores manuales a esquemas Pydantic.
  - [ ] Integrar la validación en los Blueprints de API.
