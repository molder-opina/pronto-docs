ID: ERR-20260220-003
FECHA: 2026-02-20
PROYECTO: pronto-api
SEVERIDAD: baja
TITULO: Imports no usados en app.py
DESCRIPCION: |
  El archivo `src/api_app/app.py` tiene imports que no son utilizados:
  - `flask.request`
  - `pronto_shared.trazabilidad.TrazabilidadMiddleware`

PASOS_REPRODUCIR:
  1. cd pronto-api
  2. ruff check src/ --select=F401

RESULTADO_ACTUAL: |
  ```
  F401 `flask.request` imported but unused
  F401 `pronto_shared.trazabilidad.TrazabilidadMiddleware` imported but unused
  ```

RESULTADO_ESPERADO: |
  No debe haber imports no usados.

UBICACION: src/api_app/app.py

EVIDENCIA: |
  Line 14: from flask import Flask, jsonify, request
  Line 24: from pronto_shared.trazabilidad import TrazabilidadMiddleware

HIPOTESIS_CAUSA: |
  Imports residuales de refactoring anterior.

ESTADO: RESUELTO

SOLUCION: |
  - Removido `request` del import de flask
  - Removido `TrazabilidadMiddleware` del import

COMMIT: 6a5bae5
FECHA_RESOLUCION: 2026-02-21
