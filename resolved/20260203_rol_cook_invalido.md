---
ID: ERR-20260203-ROL-COOK
FECHA: 2026-02-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Rol no canónico "cook" usado en permisos de cocina
DESCRIPCION: El módulo de cocina trata el rol "cook" como equivalente a chef para habilitar acciones. El rol canónico es "chef"; "cook" no existe en los guardrails.
PASOS_REPRODUCIR: 1) Abrir kitchen board. 2) Revisar permisos con empleado role "chef" vs "cook".
RESULTADO_ACTUAL: Se acepta rol "cook" en lógica de permisos.
RESULTADO_ESPERADO: Solo roles canónicos (chef/admin/system) definidos en guardrails.
UBICACION: pronto-static/src/vue/employees/modules/kitchen-board.ts:200-201
EVIDENCIA: ['chef', 'cook', 'admin', 'admin', 'system'].includes(...)
HIPOTESIS_CAUSA: Alias histórico no eliminado tras normalización de roles.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
