ID: ERR-20260220-001
FECHA: 2026-02-20
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: 81 errores de tipo MyPy en rutas de employees
DESCRIPCION: |
  Multiples archivos en `src/api_app/routes/employees/` tienen errores de tipo MyPy
  relacionados con el tipo de retorno de las funciones de ruta.

  El problema es que las funciones declaran retorno `tuple[dict, int]` pero usan
  `jsonify()` que retorna `Response`, causando incompatibilidad de tipos.

  Total de errores encontrados: 81 errores en 7 archivos

PASOS_REPRODUCIR:
  1. cd pronto-api
  2. mypy src/ --ignore-missing-imports
  3. Observar errores de tipo en multiples archivos

RESULTADO_ACTUAL: |
  MyPy reporta errores como:
  - "Incompatible return value type (got 'tuple[Response, HTTPStatus]', expected 'tuple[dict[Any, Any], int]')"
  - "Incompatible types in assignment (expression has type 'int', variable has type 'str | None')"
  - "'Blueprint' has no attribute '_pronto_registered'"

RESULTADO_ESPERADO: |
  MyPy debe pasar sin errores de tipo.

UBICACION: |
  Archivos afectados (81 errores):
  - src/api_app/routes/employees/notifications.py (17 errores)
  - src/api_app/routes/employees/modifiers.py (35 errores)
  - src/api_app/routes/employees/business_info.py (1 error)
  - src/api_app/routes/employees/areas.py (12 errores)
  - src/api_app/routes/employees/api_branding.py (15 errores)
  - src/api_app/routes/employees/__init__.py (1 error)
  - src/api_app/routes/__init__.py (1 error)
  
  Archivos ya corregidos:
  - src/api_app/routes/employees/tables.py (CORREGIDO)

EVIDENCIA: |
  ```
  src/api_app/routes/employees/notifications.py:43:16: error: Incompatible return value type
  src/api_app/routes/employees/modifiers.py:127:24: error: Incompatible types in assignment
  src/api_app/routes/__init__.py:52:5: error: "Blueprint" has no attribute "_pronto_registered"
  ```

HIPOTESIS_CAUSA: |
  1. Patron inconsistente de usar `jsonify()` vs retornar directamente el dict.
  2. Algunas funciones usan `return jsonify(error_response(...)), HTTPStatus.BAD_REQUEST`
     cuando deberian usar `return error_response(...), HTTPStatus.BAD_REQUEST`
  3. Asignacion de atributos dinamicos a Blueprint sin declaracion de tipo
  4. Variables reasignadas con tipos incompatibles (str a int)

ESTADO: RESUELTO

ARCHIVOS_AFECTADOS:
  - src/api_app/routes/__init__.py (CORREGIDO - commit de63cbf)
  - src/api_app/routes/employees/__init__.py (CORREGIDO - commit de63cbf)
  - src/api_app/routes/employees/notifications.py (CORREGIDO - commit de63cbf)
  - src/api_app/routes/employees/modifiers.py (CORREGIDO - commit de63cbf)
  - src/api_app/routes/employees/business_info.py (CORREGIDO - commit de63cbf)
  - src/api_app/routes/employees/areas.py (CORREGIDO - commit de63cbf)
  - src/api_app/routes/employees/api_branding.py (CORREGIDO - commit de63cbf)
  - src/api_app/routes/employees/tables.py (CORREGIDO - commit 5807a02)
  - src/api_app/app.py (CORREGIDO - commit de63cbf)

ACCIONES_PENDIENTES:
  - [x] Corregir tables.py (commit 5807a02)
  - [x] Corregir notifications.py - remover jsonify()
  - [x] Corregir modifiers.py - remover jsonify() + fix type assignment
  - [x] Corregir business_info.py - remover jsonify()
  - [x] Corregir areas.py - remover jsonify()
  - [x] Corregir api_branding.py - remover jsonify()
  - [x] Corregir __init__.py archivos - agregar type ignore
  - [x] Corregir app.py - agregar type ignore para ProxyFix
  - [x] Ejecutar mypy completo para verificar (0 errores)

COMMITS:
  - 5807a02: fix(partial): correct mypy type errors in tables.py
  - de63cbf: fix: resolve all mypy type errors in pronto-api

SOLUCION:
  - Removido jsonify() de todos los return statements en rutas
  - Agregado type annotations correctos para parametros
  - Agregado type: ignore para atributos dinamicos en Blueprint
  - Agregado type: ignore[method-assign] para ProxyFix

FECHA_RESOLUCION: 2026-02-21
