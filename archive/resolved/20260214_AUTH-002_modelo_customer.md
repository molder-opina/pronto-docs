ID: AUTH-002
FECHA: 2026-02-14
PROYECTO: pronto-libs
SEVERIDAD: bloqueante
TITULO: Modelo Customer - Agregar campos kind y kiosk_location
DESCRIPCION: 
El modelo Customer en models.py no tiene mapeados los campos kind y kiosk_location.
Después de migration AUTH-001, el modelo debe reflejar los nuevos campos.
PASOS_REPRODUCIR:
1. from pronto_shared.models import Customer
2. Customer.kind no existe como atributo mapeado
RESULTADO_ACTUAL:
Modelo sin campos kind y kiosk_location
RESULTADO_ESPERADO:
Modelo con kind: Mapped[str] y kiosk_location: Mapped[str | None]
UBICACION:
- pronto-libs/src/pronto_shared/models.py (líneas 102-128)
EVIDENCIA:
AttributeError al acceder a customer.kind
HIPOTESIS_CAUSA:
Modelo creado antes de migration
ESTADO: RESUELTO
SOLUCION:
- Agregado campo kind: Mapped[str] = mapped_column(String(20), nullable=False, default="customer")
- Agregado campo kiosk_location: Mapped[str | None] = mapped_column(String(50), nullable=True)
- Agregado índice ix_customer_kind en __table_args__
- Agregada hybrid property is_kiosk que retorna self.kind == "kiosk"
COMMIT: manual-applied
FECHA_RESOLUCION: 2026-02-14
DEPENDENCIAS: AUTH-001 (requiere migration aplicada)
BLOQUEA: AUTH-003, AUTH-004