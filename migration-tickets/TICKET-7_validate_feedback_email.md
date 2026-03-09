# TICKET-7: Validar feedback_email.py

**Prioridad**: MEDIA
**Fase**: Fase 3 (Semana 4)
**Tiempo estimado**: 1 día
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Validar que pronto-api cubre todos los endpoints de feedback que actualmente expone pronto-client.

## Archivo Origen

`pronto-client/src/pronto_clients/routes/api/feedback_email.py`

## Archivo Destino

`pronto-api/src/api_app/routes/feedback.py` (ya existe)

## Endpoints a Validar

1. `POST /api/orders/<uuid:order_id>/feedback/email-trigger`
   - Enviar email de feedback post-pago
   - Validar que pronto-api tiene este endpoint

2. `POST /api/feedback/bulk`
   - Enviar feedback masivo
   - Validar que pronto-api tiene este endpoint

3. `GET /api/feedback/questions`
   - Obtener preguntas de feedback
   - Validar que pronto-api tiene este endpoint

## Pasos de Implementación

1. **Analizar código existente**
   - Leer `pronto-client/src/pronto_clients/routes/api/feedback_email.py`
   - Listar todos los endpoints implementados

2. **Comparar con pronto-api**
   - Leer `pronto-api/src/api_app/routes/feedback.py`
   - Validar que cada endpoint existe en pronto-api
   - Verificar compatibilidad de request/response contracts

3. **Documentar gaps**
   - Si falta algún endpoint en pronto-api, crear TICKET-X
   - Si hay incompatibilidad de contrato, documentar y crear TICKET-Y

4. **Actualizar pronto-client proxy**
   - Convertir `pronto-client/src/pronto_clients/routes/api/feedback_email.py`
   - Reemplazar lógica de negocio con proxy simple
   - Usar `_forward_to_api` helper

5. **Testing**
   - Ejecutar `pronto-api-parity-check clients`
   - Ejecutar tests de feedback en pronto-tests
   - Testing manual de flujo de feedback

## Criterios de Aceptación

- [ ] Todos los endpoints de feedback_email.py existen en pronto-api
- [ ] pronto-client hace proxy sin lógica de negocio
- [ ] pronto-api-parity-check clients: ok: true
- [ ] Tests de feedback pasan
- [ ] Contrato API compatible con frontend

## Riesgos

- **Riesgo**: Incompatibilidad de contrato API
  - **Mitigación**: Versioning de API, migración gradual

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- Validar que `FeedbackEmailService` está en pronto-libs
- Validar integración con email service
