ID: LIBS-20260310-SERVICES-PACKAGE-EAGER-IMPORT-COUPLING
FECHA: 2026-03-10
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: `pronto_shared.services` importa `EmailSchedulerService` en eager y `order_helpers.py` arrastra modelos solo para type hints
DESCRIPCION: Al validar la migración de tests hacia módulos canónicos (`order_helpers.py`, `order_transitions.py`), se detectó que `pronto_shared.services.__init__` importaba `EmailSchedulerService` en eager y que `order_helpers.py` importaba modelos de `pronto_shared.models` solo para type hints. Esa combinación hacía que imports ligeros de helpers activaran dependencias pesadas/binarias (`cryptography`) sin necesidad funcional.
PASOS_REPRODUCIR:
1. Importar `pronto_shared.services.order_helpers` en un entorno con dependencias parciales o bindings binarios sensibles.
2. Observar que primero corre `pronto_shared.services.__init__`.
3. Revisar `pronto-libs/src/pronto_shared/services/__init__.py` y `order_helpers.py`.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: `pronto_shared.services` carga `EmailSchedulerService` bajo demanda y `order_helpers.py` usa `TYPE_CHECKING` para evitar imports runtime de modelos puramente tipados.
UBICACION:
- pronto-libs/src/pronto_shared/services/__init__.py
- pronto-libs/src/pronto_shared/services/order_helpers.py
EVIDENCIA:
- `pytest` focalizado sobre `tests/unit/services/test_order_service.py` falló cargando `pronto_shared.services.__init__` y luego `cryptography` vía `email_scheduler`/`models`.
- `order_helpers.py` importa `Customer`, `Employee` y `Order` solo para type hints.
HIPOTESIS_CAUSA: Acoplamiento histórico del paquete `services` y falta de aislamiento entre runtime imports y type hints durante la extracción modular reciente.
ESTADO: RESUELTO
SOLUCION:
- `pronto_shared.services.__init__` se cambió a lazy import de `EmailSchedulerService` usando `__getattr__`, evitando carga eager del scheduler al importar submódulos ligeros.
- `order_helpers.py` pasó a usar `TYPE_CHECKING` para `Customer`, `Employee` y `Order`, eliminando imports runtime de modelos usados solo para anotaciones.
- `ACTIVE_WAITER_STATUSES` se movió al módulo ligero `order_helpers.py` y `order_transitions.py` lo consume desde ahí, permitiendo validar el unit test asociado sin importar el módulo pesado de transiciones solo por una constante.
- Validación: `python3 -m py_compile` de archivos tocados y `pronto-libs/tests/unit/services/test_order_service.py` verde (`20 passed`). El test funcional de `pronto-tests` sigue bloqueado por `psycopg2._psycopg` ausente en el entorno local, no por este fix.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

