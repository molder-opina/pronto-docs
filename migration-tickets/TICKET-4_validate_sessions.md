# TICKET-4: Validar sessions.py

**Prioridad**: MEDIA
**Fase**: Fase 2 (Semana 2)
**Tiempo estimado**: 1 día
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Validar que pronto-api cubre todos los endpoints de sesiones que actualmente expone pronto-client.

## Archivo Origen

`pronto-client/src/pronto_clients/routes/api/sessions.py`

## Archivo Destino

`pronto-api/src/api_app/routes/client_sessions.py` (ya existe)

## Endpoints a Validar

1. `POST /api/sessions/open`
   - Abrir nueva sesión de cliente
   - Validar que pronto-api tiene este endpoint

2. `GET /api/sessions/<uuid:session_id>`
   - Obtener detalles de sesión
   - Validar que pronto-api tiene este endpoint

3. `GET /api/sessions/<uuid:session_id>/timeout`
   - Validar timeout de sesión
   - Validar que pronto-api tiene este endpoint

4. `POST /api/sessions/<uuid:session_id>/set-table-context`
   - Establecer contexto de mesa
   - Validar que pronto-api tiene este endpoint

## Pasos de Implementación

1. **Analizar código existente**
   - Leer `pronto-client/src/pronto_clients/routes/api/sessions.py`
   - Listar todos los endpoints implementados

2. **Comparar con pronto-api**
   - Leer `pronto-api/src/api_app/routes/client_sessions.py`
   - Validar que cada endpoint existe en pronto-api
   - Verificar compatibilidad de request/response contracts

3. **Documentar gaps**
   - Si falta algún endpoint en pronto-api, crear TICKET-X
   - Si hay incompatibilidad de contrato, documentar y crear TICKET-Y

4. **Actualizar pronto-client proxy**
   - Convertir `pronto-client/src/pronto_clients/routes/api/sessions.py`
   - Reemplazar lógica de negocio con proxy simple
   - Usar `_forward_to_api` helper

5. **Testing**
   - Ejecutar `pronto-api-parity-check clients`
   - Ejecutar tests de sesiones en pronto-tests
   - Testing manual de flujo de sesiones

## Criterios de Aceptación

- [ ] Todos los endpoints de sessions.py existen en pronto-api
- [ ] pronto-client hace proxy sin lógica de negocio
- [ ] pronto-api-parity-check clients: ok: true
- [ ] Tests de sesiones pasan
- [ ] Contrato API compatible con frontend

## Riesgos

- **Riesgo**: Incompatibilidad de contrato API
  - **Mitigación**: Versioning de API, migración gradual

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- customer_session_store debe estar en pronto-libs
- Validar que auth con X-PRONTO-CUSTOMER-REF funciona
