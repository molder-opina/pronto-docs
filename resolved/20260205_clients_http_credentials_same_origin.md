---
ID: ERR-20260205-CLIENTS-CREDENTIALS-SAME-ORIGIN
FECHA: 2026-02-05
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Wrapper HTTP de clients usa credentials same-origin (canon requiere include)
DESCRIPCION: Guardrails recomiendan credentials: 'include' para llamadas /api/* en clients. El wrapper actual usa credentials: 'same-origin'. Aunque en algunos despliegues puede funcionar, se estandariza para evitar drift entre entornos.
PASOS_REPRODUCIR: 1) Abrir pronto-static/src/vue/clients/core/http.ts. 2) Ver fetch(..., { credentials: 'same-origin' }).
RESULTADO_ACTUAL: Riesgo de inconsistencias en cookies en despliegues con dominios/subdominios.
RESULTADO_ESPERADO: Usar credentials: 'include' en wrapper canonico.
UBICACION: pronto-static/src/vue/clients/core/http.ts
EVIDENCIA: requestJSON usa credentials: 'same-origin'.
HIPOTESIS_CAUSA: Wrapper fue implementado con supuestos de same-origin estrictos.
ESTADO: RESUELTO
---

SOLUCION:
Se enforcea `credentials: include` en el wrapper HTTP de clients y en el modulo base legacy.

COMMIT:
237f17b

FECHA_RESOLUCION:
2026-02-05
