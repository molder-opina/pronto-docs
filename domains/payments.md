## Dominio `Payments`

### Superficies principales
- `pronto-api` para checkout y pago canónico
- `pronto-client` para flujos de cobro del navegador

### Rutas clave
- `/api/customer/payments/sessions/<uuid:session_id>/checkout`
- `/api/customer/payments/sessions/<uuid:session_id>/pay`
- `/api/customer/payments/sessions/<uuid:session_id>/request-payment`
- `/api/customer/payments/sessions/<uuid:session_id>/confirm-tip`
- `/api/customer/payments/sessions/<uuid:session_id>/stripe/intent`
- `/api/sessions/<uuid:session_id>/pay`
- `/api/sessions/<uuid:session_id>/pay/cash`
- `/api/sessions/<uuid:session_id>/pay/clip`
- `/api/sessions/<uuid:session_id>/pay/stripe`

### Reglas importantes
- Los pagos del cliente suelen requerir `X-CSRFToken`.
- En consumo directo contra `pronto-api`, propaga `X-PRONTO-CUSTOMER-REF` cuando corresponda.
- Hay coexistencia entre endpoints canónicos de customer payments y BFF cliente por compatibilidad.

### Flujos típicos
1. Obtener checkout.
2. Solicitar cobro o iniciar pago.
3. Confirmar tip si aplica.
4. Completar pago y continuar con ticket/factura.

### Documentos relacionados
- `../SYSTEM_ROUTES_MATRIX.md`
- `../SYSTEM_ROUTES_SPEC.md`
- `../pronto-api/POSTMAN_USAGE.md`
- `../pronto-api/INSOMNIA_USAGE.md`
- `../contracts/pronto-api/domain_contracts.md`
- `../contracts/pronto-client/domain_contracts.md`