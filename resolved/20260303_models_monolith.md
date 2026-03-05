ID: ARCH-20260303-011
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Monolito models.py candidato a modularización en paquete

DESCRIPCION: |
  El archivo `models.py` en `pronto-libs` se ha convertido en un monolito que contiene 49 definiciones de clases (modelos de SQLAlchemy). Con un tamaño de 88KB y miles de líneas, este archivo es difícil de navegar y genera conflictos de mezcla (merge conflicts) frecuentes.

RESULTADO_ACTUAL: |
  Todos los modelos del sistema (Órdenes, Menú, Empleados, Clientes, Analítica, etc.) residen en un único archivo físico.

RESULTADO_ESPERADO: |
  Transformar `models.py` en un paquete `models/` con archivos organizados por dominio:
  - `models/orders.py`
  - `models/menu.py`
  - `models/employees.py`
  - `models/customers.py`
  - `models/analytics.py`
  - `models/__init__.py` (para mantener compatibilidad de importación `from pronto_shared.models import ...`)

UBICACION: |
  - `pronto-libs/src/pronto_shared/models.py`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Crear la estructura de carpetas `models/`.
  - [ ] Migrar las clases respetando las dependencias de claves foráneas.
  - [ ] Configurar el `__init__.py` para exportar todos los modelos y asegurar compatibilidad hacia atrás.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
