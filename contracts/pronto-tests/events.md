| Event / Artifact | Producer | Consumers | Notes |
|---|---|---|---|
| `playwright-report/` | Playwright | QA / developers | Reporte HTML de ejecuciones browser |
| `test-results/results.json` | Playwright / scripts | QA / CI | Resumen estructurado de resultados |
| `docs/test-report.md` | scripts/manual QA | developers | Consolidado legible de hallazgos |
| `tmp/*.md` | análisis temporales | developers | Evidencia y diagnósticos locales |

### Notas
- `pronto-tests` centraliza evidencia de validación, no lógica de negocio.
- Los artefactos deben interpretarse junto con las suites canónicas del repo y sus entornos reales.
