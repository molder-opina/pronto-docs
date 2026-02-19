# Reviews de Bugs

Punto de entrada único para seguimiento operativo y ejecutivo de bugs.

## Orden recomendado de lectura
1. Semáforo (10 segundos): `20260218_bug_dashboard_semaforo.md`
2. Dashboard maestro (resumen + enlaces): `20260218_bug_dashboard_master.md`
3. Checklist general (estado de tickets): `20260218_bug_checklist.md`
4. Checklist por módulo: `20260218_bug_checklist_by_module.md`
5. Checklist por severidad: `20260218_bug_checklist_by_severity.md`
6. Top 10 ejecutivo: `20260218_bug_executive_top10.md`
7. SLA histórico: `20260218_bug_sla_report.md`
8. Aging histórico: `20260218_bug_aging_report.md`
9. Status standup (resumen corto): `STATUS.md`

## Cadencia sugerida
- Diario: semáforo + checklist general + aging.
- Semanal: severidad + SLA.
- Mensual: top 10 + tendencias del dashboard maestro.

## Fuente canónica de estado
1. Expediente en `pronto-docs/errors/` o `pronto-docs/resolved/`.
2. Registro en `pronto-docs/resueltos.txt`.

Estos tableros son vistas derivadas para monitoreo.

## Regenerar tableros
- Ejecutar: `bash pronto-scripts/bin/refresh-bug-reviews.sh`
- Verificar estado (modo check): `bash pronto-scripts/bin/refresh-bug-reviews.sh --check`
