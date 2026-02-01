# Flujos del Sistema Pronto

## 1. Ciclo de Vida de Sesión vs. Estado de Orden

Comparativa del flujo de vida de una sesión (Anónima vs. Firmada) en relación con los estados de las órdenes.

```mermaid
graph TD
    subgraph "Estados de Orden (OrderStatus)"
        New[NEW] --> Queued[QUEUED]
        Queued --> Prep[PREPARING]
        Prep --> Ready[READY]
        Ready --> Delivered[DELIVERED]
        Delivered --> AwaitingPay[AWAITING_PAYMENT]
        AwaitingPay --> Paid[PAID]
    end

    subgraph "Sesión Anónima (Cliente Sin Login)"
        AS_Start(Inicio: Escaneo QR) --> AS_Open{Estado: OPEN}
        AS_Open -- "Agrega Items" --> AS_Active
        AS_Active -- "Pide Cuenta" --> AS_WaitTip{Estado: AWAITING_TIP}
        AS_WaitTip -- "Selecciona Propina" --> AS_WaitPay{Estado: AWAITING_PAYMENT}
        AS_WaitPay -- "Paga (Stripe/Efectivo)" --> AS_Paid{Estado: PAID}
        AS_Paid -- "Cierre Automático" --> AS_Closed(Estado: CLOSED)
    end

    subgraph "Sesión Usuario Firmado (Login)"
        US_Login(Login / Registro) --> US_Start(Inicio: Escaneo QR)
        US_Start --> US_Open{Estado: OPEN}
        US_Open -- "Agrega Items (Historial Guardado)" --> US_Active
        US_Active -- "Pide Cuenta" --> US_WaitTip{Estado: AWAITING_TIP}
        US_WaitTip -- "Selecciona Propina" --> US_WaitPay{Estado: AWAITING_PAYMENT}
        US_WaitPay -- "Paga (Método Guardado?)" --> US_Paid{Estado: PAID}
        US_Paid -- "Acumula Puntos/Historial" --> US_Closed(Estado: CLOSED)
    end

    %% Relaciones
    New -.-> AS_Open
    New -.-> US_Open
    Delivered -.-> AS_WaitTip
    Delivered -.-> US_WaitTip
    Paid -.-> AS_Paid
    Paid -.-> US_Paid
```

## 2. Flujo de Uso de Compra de una Orden

Diferencias entre usuario firmado y no logueado durante el proceso de compra.

```mermaid
sequenceDiagram
    participant User as Usuario (Anon/Firmado)
    participant ClientApp as Cliente App
    participant Session as Session Service
    participant Order as Order Service
    participant Payment as Payment Service

    Note over User, ClientApp: Inicio del Flujo

    alt Usuario Anónimo
        User->>ClientApp: Escanea QR / Abre App
        ClientApp->>Session: Crea Sesión Temporal (ID aleatorio)
        Session-->>ClientApp: Sesión Iniciada (Cookie Anon)
    else Usuario Firmado
        User->>ClientApp: Login / Abre App
        ClientApp->>Session: Verifica Token / Crea Sesión Vinculada
        Session-->>ClientApp: Sesión Iniciada (Customer ID vinculado)
    end

    User->>ClientApp: Selecciona Productos
    User->>ClientApp: Ver Carrito -> Confirmar Orden

    alt Usuario Anónimo
        ClientApp->>ClientApp: Solicita Nombre/Teléfono (Opcional pero recomendado)
        User->>ClientApp: Ingresa Datos Contacto
    else Usuario Firmado
        ClientApp->>ClientApp: Pre-carga Datos del Perfil
    end

    ClientApp->>Order: Crear Orden (Items)
    Order-->>ClientApp: Orden Creada (Status: NEW)

    Note over Order: Flujo de Cocina / Entrega...

    Order-->>ClientApp: Orden Entregada (Status: DELIVERED)
    User->>ClientApp: Solicitar Cuenta

    alt Usuario Anónimo
        ClientApp->>Payment: Iniciar Checkout
        Payment-->>ClientApp: Opciones de Pago
        User->>ClientApp: Ingresa Tarjeta / Selecciona Efectivo
    else Usuario Firmado
        ClientApp->>Payment: Iniciar Checkout
        Payment-->>ClientApp: Opciones (Tarjetas Guardadas?)
        User->>ClientApp: Confirma Método
    end

    User->>ClientApp: Pagar
    ClientApp->>Payment: Procesar Pago
    Payment-->>Order: Actualizar a PAID
    Payment-->>Session: Actualizar a PAID

    alt Usuario Firmado
        Payment->>User: Guardar en Historial de Pedidos
        Payment->>User: Enviar Recibo a Email Registrado
    else Usuario Anónimo
        Payment->>User: Enviar Recibo a Email (si se proporcionó)
    end
```
