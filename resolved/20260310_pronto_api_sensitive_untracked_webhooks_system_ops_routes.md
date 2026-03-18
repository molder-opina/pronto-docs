ID: BUG-20260310-PRONTO-API-SENSITIVE-UNTRACKED-WEBHOOKS-SYSTEM-OPS-ROUTES
FECHA: 2026-03-10
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: Se reintrodujeron rutas no trackeadas y sensibles (`webhooks`, `system_ops`) sin validación suficiente
DESCRIPCION: El diff local de `pronto-api` contenía dos archivos no trackeados: `src/api_app/routes/webhooks.py` y `src/api_app/routes/employees/system_ops.py`, ambos registrados en blueprints. `webhooks.py` incorporaba dependencia Stripe no declarada en `requirements.txt` y consultas SQL interpoladas; `system_ops.py` exponía operaciones de infraestructura/sistema (scripts, archivos estáticos, probes, restart/sync, auth ops) bajo API. Dado el mandato de curación segura y los guardrails P0/P1, esta superficie no debía mantenerse sin solicitud explícita y validación dedicada.
PASOS_REPRODUCIR:
1. Revisar `git status` en `pronto-api`.
2. Abrir `src/api_app/routes/webhooks.py` y `src/api_app/routes/employees/system_ops.py`.
3. Verificar su registro en `src/api_app/routes/__init__.py` y `src/api_app/routes/employees/__init__.py`.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: Las rutas sensibles no validadas deben retirarse de este corte conservador y dejar el repo en un estado seguro.
UBICACION:
- pronto-api/src/api_app/routes/webhooks.py
- pronto-api/src/api_app/routes/employees/system_ops.py
- pronto-api/src/api_app/routes/__init__.py
- pronto-api/src/api_app/routes/employees/__init__.py
EVIDENCIA:
- `requirements.txt` de `pronto-api` no declara Stripe.
- `webhooks.py` usaba SQL interpolado por f-string.
- `system_ops.py` exponía endpoints operativos (`/system/ops/*`) sin tests focalizados en esta ronda.
HIPOTESIS_CAUSA: Reaparición de trabajo en progreso/experimental durante el diff local de `pronto-api`.
ESTADO: RESUELTO
SOLUCION:
- Se removieron los registros de `webhooks` y `system_ops` desde los blueprints.
- Se eliminaron ambos archivos no trackeados para volver a una superficie API conservadora y validable.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

