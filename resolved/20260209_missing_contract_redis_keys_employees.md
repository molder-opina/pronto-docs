---
ID: BUG-MISSING-CONTRACT-REDIS-KEYS-001
FECHA: 2026-02-09
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: redis_keys.md de employees está vacío
DESCRIPCION: El contrato de Redis para pronto-employees no está documentado. El archivo pronto-docs/contracts/pronto-employees/redis_keys.md existe pero está vacío (0 bytes). Esto viola la regla de contratos públicos del proyecto que requiere documentar todas las keys de Redis usadas por cada módulo.
PASOS_REPRODUCIR: 1. Ir a pronto-docs/contracts/pronto-employees/redis_keys.md 2. Verificar que está vacío
RESULTADO_ACTUAL: Archivo vacío, sin especificación de keys de Redis
RESULTADO_ESPERADO: Archivo con tabla de keys igual que otros módulos (pattern, TTL, owner, PII, fields)
UBICACION: pronto-docs/contracts/pronto-employees/redis_keys.md
EVIDENCIA: Archivo vacío revisado en auditoría técnica
HIPOTESIS_CAUSA: El equipo documentó redis_keys para otros módulos pero olvido employees, o las keys de employees aún no fueron inventariadas
ESTADO: ABIERTO
