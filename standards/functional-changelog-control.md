# Functional Changelog Control Standard

## Objective

Establecer trazabilidad obligatoria y auditable para cada cambio funcional documentado en `pronto-docs`.

## Mandatory Policy

Todo cambio funcional nuevo en `pronto-docs` debe registrar evidencia en ambos artefactos:

1. `pronto-docs/change-logs/CHG-<timestamp>/result.md`
2. `pronto-docs/versioning/AI_VERSION_LOG.md`

Si falta uno de los dos registros, el cambio se considera incompleto.

## Required Fields Per Entry

Cada entrada en `result.md` y en `AI_VERSION_LOG.md` debe incluir, como minimo:

- `FECHA`
- `AGENTE`
- `MODULOS`
- `VERSION_ANTERIOR`
- `VERSION_NUEVA`
- `RESUMEN`
- `COMMIT_HASHES`
- `RUTAS_AFECTADAS`

## Folder and Naming Convention

Para cada cambio funcional:

1. Crear carpeta `CHG-<YYYYMMDD-HHMMSS>` dentro de `pronto-docs/change-logs/`.
2. Crear `result.md` usando la plantilla oficial.

## Correlation Rules

1. La entrada en `AI_VERSION_LOG.md` debe referenciar el mismo cambio registrado en `result.md`.
2. El campo `COMMIT_HASHES` debe apuntar a los commits de implementacion del cambio.
3. El campo `RUTAS_AFECTADAS` debe listar rutas reales modificadas.

## Blockers

Un cambio debe considerarse `REJECTED` cuando ocurra cualquiera de estos casos:

1. Existe `CHG-<timestamp>/result.md` sin entrada correlativa en `AI_VERSION_LOG.md`.
2. Existe entrada en `AI_VERSION_LOG.md` sin carpeta `CHG-<timestamp>/`.
3. Faltan campos obligatorios.

## Scope

Este estandar aplica solo a cambios funcionales de `pronto-docs`.
