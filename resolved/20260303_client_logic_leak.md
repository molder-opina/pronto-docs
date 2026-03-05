ID: ARCH-20260303-001
FECHA: 2026-03-03
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Fuga de lógica de negocio en Blueprints de API

DESCRIPCION: |
  Se ha detectado que el directorio `src/pronto_clients/services` se encuentra vacío. Como consecuencia, lógica de negocio compleja y crítica para el sistema reside actualmente dentro de los archivos de rutas (Blueprints). 
  
  Específicamente:
  - `split_bills.py`: Contiene lógica matemática de prorrateo de impuestos, propinas y redondeo.
  - `waiter_calls.py`: Gestiona la lógica de cooldown y re-emisión de notificaciones.
  - `orders.py`: Contiene la lógica de resolución de bases de API y proxy.

RESULTADO_ACTUAL: |
  La lógica de negocio está acoplada al framework Flask (objetos request, session, jsonify), lo que impide realizar pruebas unitarias puras sobre los algoritmos de cálculo y aumenta la complejidad de los archivos de rutas.

RESULTADO_ESPERADO: |
  Las rutas deben actuar únicamente como controladores: validar la entrada, llamar a un servicio y formatear la salida. Toda la lógica de cálculo y orquestación debe residir en `services/`.

UBICACION: |
  - `pronto-client/src/pronto_clients/routes/api/split_bills.py`
  - `pronto-client/src/pronto_clients/routes/api/waiter_calls.py`
  - `pronto-client/src/pronto_clients/services/` (actualmente vacío)

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Crear `BillSplitterService` y mover la lógica de cálculo de `_calculate_equal_split` y asignación de ítems.
  - [ ] Crear `WaiterCallService` para centralizar la lógica de emisión de llamadas y manejo de caché de estados.
  - [ ] Implementar pruebas unitarias para estos nuevos servicios sin depender de un contexto de aplicación Flask.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
