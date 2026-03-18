ID: PRONTO-PAY-015
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Inconsistencia en contrato de configuración con tres claves relacionadas
DESCRIPCION: El contrato de configuración (config_contract.py) define tres claves relacionadas con permisos de pago: waiter_can_collect, payments.enable_cashier_role, y payments.allow_waiter_cashier_operations. Esta duplicación crea confusión sobre cuál es la fuente de verdad y puede causar comportamientos inconsistentes.
PASOS_REPRODUCIR:
1. Analizar config_contract.py líneas 176, 251, 258
2. Observar que existen tres claves para controlar permisos de cobro
3. Verificar que waiter_can_collect es una configuración booleana simple
4. Verificar que payments.* son configuraciones matriciales completas
5. Configurar valores inconsistentes entre estas claves
RESULTADO_ACTUAL: Tres claves relacionadas que pueden tener valores inconsistentes, causando comportamiento impredecible dependiendo de qué parte del sistema se utilice.
RESULTADO_ESPERADO: Una única fuente de verdad para los permisos de pago, ya sea waiter_can_collect o la configuración matricial payments.*, pero no ambas simultáneamente.
UBICACION:
- pronto-libs/src/pronto_shared/config_contract.py:176,251,258
EVIDENCIA: El contrato de configuración mantiene tanto la configuración legacy (waiter_can_collect) como la nueva configuración matricial (payments.*), lo que viola el principio de una única fuente de verdad.
HIPOTESIS_CAUSA: La migración de waiter_can_collect a la configuración matricial nunca se completó, dejando ambas configuraciones activas simultáneamente.
ESTADO: ABIERTO