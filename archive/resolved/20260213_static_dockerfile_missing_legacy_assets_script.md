ID: ERR-20260213-STATIC-DOCKERFILE-LEGACY-SCRIPT
FECHA: 2026-02-13
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Rebuild de static falla por script faltante en Docker image build context
DESCRIPCION: El comando de rebuild de static falla durante `npm run build:employees` porque el script `scripts/ensure-employees-legacy-assets.mjs` no existe dentro de la imagen builder (`/app/scripts/...`). Esto impide publicar assets nuevos y provoca desalineación visual/funcional entre frontend y código local.
PASOS_REPRODUCIR:
1. Ejecutar `bash pronto-scripts/bin/mac/rebuild.sh --keep-sessions static`.
2. Observar fallo en etapa `RUN npm run build:employees && npm run build:clients`.
RESULTADO_ACTUAL: Docker build aborta con `MODULE_NOT_FOUND` para `ensure-employees-legacy-assets.mjs`.
RESULTADO_ESPERADO: La imagen de static debe compilar ambos bundles sin errores y desplegar assets actualizados.
UBICACION: /Users/molder/projects/github-molder/pronto/pronto-static/Dockerfile
EVIDENCIA: Error en build Docker: `Error: Cannot find module '/app/scripts/ensure-employees-legacy-assets.mjs'`.
HIPOTESIS_CAUSA: El Dockerfile copia `package*.json`, `vite.config.ts`, `tsconfig.json`, `src/vue` y `src/static_content/assets`, pero no copia la carpeta `scripts/` requerida por el script de build.
ESTADO: RESUELTO
SOLUCION: Se agregó `COPY pronto-static/scripts ./scripts` en `/Users/molder/projects/github-molder/pronto/pronto-static/Dockerfile` para incluir el script `ensure-employees-legacy-assets.mjs` en el stage builder. Con esto, `npm run build:employees` y `npm run build:clients` completan exitosamente durante el build de la imagen `pronto-static`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
