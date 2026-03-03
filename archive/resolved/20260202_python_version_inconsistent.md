---
ID: DOCS-20260202-001
FECHA: 2026-02-02
PROYECTO: pronto-docs
SEVERIDAD: baja
TITULO: Versiones de Python inconsistentes entre INDEX.md y READMEs de módulos
DESCRIPCION:
El archivo pronto-docs/INDEX.md especifica Python 3.14+ como el lenguaje principal del backend, pero todos los READMEs de los módulos especifican Python 3.11+ como requisito mínimo.

PASOS_REPRODUCIR:
1. Abrir pronto-docs/INDEX.md
2. Buscar "Python 3.14+" (líneas 128 y 420)
3. Abrir pronto-employees/README.md, pronto-client/README.md, pronto-api/README.md
4. Verificar que especifican "Python 3.11+"

RESULTADO_ACTUAL:
INDEX.md: "Python 3.14+"
READMEs módulos: "Python 3.11+"

RESULTADO_ESPERADO:
Todos los archivos deberían especificar la misma versión de Python como requisito mínimo.

UBICACION:
- pronto-docs/INDEX.md:128, 420
- pronto-employees/README.md:17
- pronto-client/README.md:7
- pronto-api/README.md:7

EVIDENCIA:
grep "Python 3.14" pronto-docs/INDEX.md
grep "Python 3.11" pronto-*/README.md

HIPOTESIS_CAUSA:
INDEX.md se actualizó a una versión más nueva de Python (3.14+) mientras que los READMEs de módulos se quedaron con la versión anterior (3.11+).

ESTADO: RESUELTO
---
