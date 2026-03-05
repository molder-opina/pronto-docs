ID: CODE-20260303-008
FECHA: 2026-03-03
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Duplicación masiva de lógica de login en pronto-employees

DESCRIPCION: |
  Se ha detectado que el proceso de inicio de sesión (`process_login`) está implementado de forma casi idéntica en 5 archivos diferentes de `pronto-employees`, uno por cada scope de rol. Esto genera una deuda técnica considerable y riesgo de inconsistencias ante cambios en el flujo de autenticación.

RESULTADO_ACTUAL: |
  La función `process_login` está duplicada en:
  - `src/pronto_employees/routes/admin/auth.py`
  - `src/pronto_employees/routes/chef/auth.py`
  - `src/pronto_employees/routes/system/auth.py`
  - `src/pronto_employees/routes/waiter/auth.py`
  - `src/pronto_employees/routes/cashier/auth.py`

RESULTADO_ESPERADO: |
  La lógica de autenticación debe estar centralizada en un único módulo o blueprint compartido que acepte el `scope` como parámetro dinámico, eliminando la redundancia.

UBICACION: |
  - `pronto-employees/src/pronto_employees/routes/*/auth.py`

HIPOTESIS_CAUSA: |
  Diseño inicial basado en aislamiento estricto de directorios por rol que llevó a copiar y pegar la lógica de autenticación en lugar de utilizar un helper común.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Crear un blueprint de autenticación unificado o un servicio de auth común en `pronto-employees`.
  - [ ] Refactorizar las rutas de login para delegar en el componente centralizado.
  - [ ] Asegurar que el manejo de cookies namespaced (`access_token_{scope}`) se mantenga correcto tras la unificación.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
