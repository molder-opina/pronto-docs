ID: PRONTO-PAY-020
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: crítica
TITULO: Violación sistemática de autoridad única de transiciones de estado
DESCRIPCION: Se han detectado múltiples violaciones sistemáticas de la regla P0 de autoridad única de transiciones de estado. El código base contiene numerosas asignaciones directas de workflow_status y payment_status fuera del servicio canónico order_state_machine.py, lo que rompe la encapsulación y puede causar transiciones inválidas o inconsistencias.
PASOS_REPRODUCIR:
1. Ejecutar búsqueda con rg para "workflow_status\s*=" excluyendo order_state_machine.py
2. Ejecutar búsqueda con rg para "payment_status\s*=" excluyendo order_state_machine.py  
3. Observar múltiples ocurrencias en servicios, tests, y otros archivos
4. Verificar que estas asignaciones no pasan por las validaciones de transición
RESULTADO_ACTUAL: Violación sistemática de la regla P0 que prohíbe escrituras directas de estados fuera del servicio canónico. Esto puede causar transiciones inválidas y corrupción de datos.
RESULTADO_ESPERADO: Todas las modificaciones de estados deben pasar exclusivamente por order_state_machine.py, que es la única autoridad para transiciones de estado.
UBICACION:
- Múltiples archivos en pronto-libs/src/pronto_shared/services/
- Archivos de test en pronto-tests/
- Archivos de migración y seed
EVIDENCIA: Búsqueda con rg muestra numerosas ocurrencias de asignaciones directas de estados fuera del servicio canónico, violando explícitamente la regla P0 definida en AGENTS.md.
HIPOTESIS_CAUSA: La regla de autoridad única de estados se estableció después de que gran parte del código base ya estaba implementado, y no se realizó una migración completa para cumplir con esta regla crítica.
ESTADO: RESUELTO