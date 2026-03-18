ID: PRONTO-API-AUDIT-20260314
FECHA: 2026-03-14
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: Auditoria pronto-api - Hallazgos de compliance

DESCRIPCION:
Auditoria completa de pronto-api segun AGENTS.md. Se ejecutaron los gates obligatorios y verificaciones de compliance.

PASOS_REPRODUCIR:
Ejecutar los scripts de auditoria:
- Gate H: Order State Authority
- Gate G: API Parity  
- Gate B: Seguridad (flask.session)
- Gate F: DDL Runtime

RESULTADO_ACTUAL:
Hallazgos encontrados en la auditoría.

RESULTADO_ESPERADO:
Cero hallazgos críticos.

UBICACION:
pronto-api/src/

EVIDENCIA:

=== GATE H: Order State Authority ===
- workflow_status fuera de order_state_machine.py: OK (no encontrado)
- payment_status fuera de order_state_machine.py: OK (no encontrado)
- Estados hardcodeados: OK

=== GATE G: API Parity ===
- Employees parity: OK (ok: true)
- Clients parity: OK (ok: true)

=== GATE B: Seguridad ===
- flask.session en api: OK (no encontrado)
- CSRF exemptions: OK (solo /api/sessions/open - permitido)

=== GATE F: DDL Runtime ===
- DROP statements: OK (no encontrado)

=== GATE L: HTTP Client Canonical Patterns ===
- OK

=== OTRAS VERIFICACIONES ===
- legacy_mysql: NO encontrado
- sha256+pepper legacy: NO encontrado
- SQLAlchemy callbacks: NO encontrado
- print() en produccion: Solo en verify_pii.py (script de testing)

=== HALLAZGOS ADICIONALES (NO BLOQUEANTES) ===

1. CORRELATION ID NO IMPLEMENTADO (Severidad: media)
   - Ubicacion: todo pronto-api
   - Problema: No se propaga X-Correlation-ID en requests
   - Impacto: Seccion 0.6.1 de AGENTS.md viola trazabilidad
   - evidencia:
     rg -n --hidden "X-Correlation-ID" pronto-api/src
     (sin resultados)

2. LOGGING INCONSISTENTE (Severidad: baja)
   - Ubicacion: Multiple archivos
   - Problema: Mezcla de current_app.logger y StructuredLogger
   - Impacto: Seccion 0.6.2 de AGENTS.md - no es consistente
   - evidencia:
     - current_app.logger: feedback.py:240, feedback.py:268
     - StructuredLogger: employees/orders.py, employees/auth.py, customers/orders.py
   - Recomendacion: Estandarizar en StructuredLogger

HIPOTESIS_CAUSA:
1. Correlation ID no fue implementado en el flujo de requests
2. Logging no fue consolidado completamente

ESTADO: ABIERTO

SOLUCION:
1. Implementar middleware de correlation ID
2. Estandarizar logging a StructuredLogger

COMMIT: N/A
FECHA_RESOLUCION: N/A
