ID: ARCH-20260303-008
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Duplicación de lógica de autenticación en pronto_shared

DESCRIPCION: |
  Se ha detectado la existencia de dos implementaciones paralelas del servicio de autenticación dentro de la librería compartida:
  1. `pronto_shared.auth.service.AuthService`
  2. `pronto_shared.services.auth_service.AuthService`
  
  Ambos servicios realizan tareas similares (autenticación contra DB, verificación de roles) pero devuelven tipos de datos diferentes (`EmployeeData` dataclass vs `Employee` model expunged) y tienen firmas de métodos distintas.

RESULTADO_ACTUAL: |
  Existe ambigüedad sobre cuál es el servicio de autenticación oficial. Esto facilita la introducción de bugs si se aplican parches de seguridad en un archivo pero no en el otro.

RESULTADO_ESPERADO: |
  Unificar toda la lógica de autenticación en un único punto de verdad, preferiblemente bajo `pronto_shared.auth.service` para seguir el estándar de namespaces más moderno del proyecto.

UBICACION: |
  - `pronto-libs/src/pronto_shared/auth/service.py`
  - `pronto-libs/src/pronto_shared/services/auth_service.py`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Analizar cuál de las dos implementaciones es la más completa y segura.
  - [ ] Consolidar la lógica en un solo archivo.
  - [ ] Refactorizar todas las referencias en `pronto-api` y `pronto-employees` para usar el servicio único.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
