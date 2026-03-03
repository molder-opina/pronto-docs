ID: ERR-20260219-INITIALIZE-APP-UNDEFINED
FECHA: 2026-02-19
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: menu.ts llama a funcion initializeApp que no existe
DESCRIPCION: El archivo menu.ts contenia una llamada a initializeApp() que nunca fue definida ni importada, causando un ReferenceError en runtime que impedia la inicializacion del menu de clientes.
PASOS_REPRODUCIR:
1. Abrir la pagina del menu de clientes en el navegador
2. Abrir DevTools Console
3. Ver error: "Uncaught ReferenceError: initializeApp is not defined"
RESULTADO_ACTUAL: Error en consola, posible fallo en inicializacion
RESULTADO_ESPERADO: Menu carga sin errores
UBICACION: pronto-static/src/vue/clients/entrypoints/menu.ts:18
EVIDENCIA:
```typescript
// Antes del fix
void initializeApp();  // Funcion no definida
```
HIPOTESIS_CAUSA: Codigo residual de refactorizacion anterior
ESTADO: RESUELTO
SOLUCION: Eliminada la llamada a initializeApp() y el import no utilizado de session-manager
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
