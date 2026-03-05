ID: CODE-20260303-LIBS-RBAC
FECHA: 2026-03-03
PROYECTO: pronto-libs, pronto-ai
SEVERIDAD: media
TITULO: Contradicción de fuente de verdad sobre el sistema de permisos (RBAC)

DESCRIPCION: |
  El documento maestro `pronto-ai/AGENTS.md` establece explícitamente como regla CRÍTICA: "Simple role-to-console mapping... NO custom roles, NO permission systems". 
  Sin embargo, existe el archivo `pronto-libs/src/pronto_shared/services/rbac_service.py` y los modelos `SystemRole` y `SystemPermission` en `models.py`. 
  Esta contradicción entre la documentación de arquitectura y la implementación real puede confundir a los desarrolladores y a la IA, llevando a implementaciones inconsistentes.

RESULTADO_ACTUAL: |
  Documentación prohíbe sistemas de permisos, pero el código los implementa.

RESULTADO_ESPERADO: |
  Sincronizar la documentación con la realidad del código. Si se decidió implementar RBAC, `AGENTS.md` debe reflejarlo y definir los guardrails para su uso.

UBICACION: |
  - `pronto-ai/AGENTS.md`
  - `pronto-libs/src/pronto_shared/services/rbac_service.py`

ESTADO: ABIERTO

ACCIONES_PENDIENTES:
  - [ ] Decidir si el sistema RBAC es el estándar oficial.
  - [ ] Actualizar `AGENTS.md` para eliminar la prohibición de sistemas de permisos si se mantiene RBAC.
  - [ ] Documentar los roles y permisos canónicos en el nuevo sistema.
