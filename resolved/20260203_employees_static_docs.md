---
ID: ERR-20260203-EMPLOYEES-STATIC-DOCS
FECHA: 2026-02-03
PROYECTO: pronto-docs/pronto-employees
SEVERIDAD: media
TITULO: Docs de employees mencionan static local pero app usa static_folder=None
DESCRIPCION: Documentación menciona carpeta static local, pero la app desactiva static_folder y usa assets de pronto-static.
PASOS_REPRODUCIR:
1) Revisar pronto-docs/pronto-employees/README.md y pronto-docs/**
2) Revisar pronto-employees/src/pronto_employees/app.py
RESULTADO_ACTUAL: Docs describen static local.
RESULTADO_ESPERADO: Docs indican static_folder=None y assets desde pronto-static.
UBICACION: pronto-docs/**, pronto-employees/src/pronto_employees/app.py
EVIDENCIA: app.py crea Flask con static_folder=None.
HIPOTESIS_CAUSA: Documentación quedó desalineada con la configuración real.
ESTADO: ABIERTO
---
