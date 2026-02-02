# Pronto-Static Documentation

## Overview

Pronto-Static provides static asset hosting for the Pronto platform. It serves optimized CSS, JavaScript, images, and other frontend assets for pronto-clients and pronto-employees applications.

**Port:** 9088
**Technology:** Nginx, Vite, Vue.js
**Purpose:** Static asset hosting and frontend build

## Architecture

### Core Components

```
pronto-static/
├── .git/                          # Git repository
├── node_modules/                   # Node.js dependencies
├── src/
│   ├── static_content/             # Static assets served by Nginx
│   │   ├── index.html             # Root HTML
│   │   ├── styles.css             # Global styles
│   │   ├── Dockerfile             # Nginx container config
│   │   ├── nginx.conf             # Nginx configuration
│   │   └── assets/                # Compiled assets
│   │       ├── css/                # Stylesheets
│   │       ├── js/                 # JavaScript bundles
│   │       └── images/             # Static images
│   └── vue/                       # Vue.js source code
│       ├── clients/               # Client app components
│       └── employees/             # Employee app components
├── package.json                   # Node.js dependencies
├── vite.config.ts                 # Vite build configuration
└── tsconfig.json                  # TypeScript configuration
```

## Build Targets

### Employees App
- **Source:** `src/vue/employees/`
- **Output:** `src/static_content/assets/js/employees/`
- **Base URL:** `/assets/js/employees/`
- **Entrypoints:**
  - `dashboard.ts` - Dashboard functionality
  - `base.ts` - Base functionality

### Clients App
- **Source:** `src/vue/clients/`
- **Output:** `src/static_content/assets/js/clients/`
- **Base URL:** `/assets/js/clients/`
- **Entrypoints:**
  - `base.ts` - Base functionality
  - `menu.ts` - Menu page logic
  - `thank-you.ts` - Thank you page logic

## Development

### Setup

```bash
# Install dependencies
npm install

# Or use pnpm
pnpm install
```

### Development Server

#### Employees App
```bash
npm run dev:employees

# Or with environment variable
PRONTO_TARGET=employees vite
```

#### Clients App
```bash
npm run dev:clients

# Or with environment variable
PRONTO_TARGET=clients vite
```

The development server runs on port 6080 and proxies:
- `/api/*` → `http://localhost:6081` (Employee API)
- `/static/*` → `http://localhost:9088/assets` (Static assets)
- `/assets/*` → `http://localhost:9088/assets` (Static assets)

### Build

#### Build All
```bash
npm run build
```

#### Build Employees App
```bash
npm run build:employees
```

#### Build Clients App
```bash
npm run build:clients
```

### Linting & Formatting

```bash
# Lint code
npm run lint

# Format code
npm run format
```

## Static Assets Structure

### CSS Organization

#### Clients CSS (`assets/css/clients/`)
- `main.css` - Main stylesheet
- `menu.css` - Menu page styles
- `menu-core.css` - Menu core styles
- `menu-filters.css` - Menu filter styles
- `menu-components.css` - Menu component styles
- `menu-orders.css` - Menu order styles
- `menu-checkout.css` - Checkout styles
- `menu-modals.css` - Modal styles
- `menu-alt.css` - Alternative menu styles
- `main-ux.css` - Main UX styles
- `modern-qsr.css` - Modern QSR styles
- `color-improvements.css` - Color improvements
- `qa-error-fixes.css` - QA error fixes
- `qa-fixes.css` - General QA fixes
- `fixes-qa-errors-1-2.css` - QA error fixes 1-2
- `qa-error-fixes-updated.css` - Updated QA error fixes
- `styles.css` - General styles
- `qa-error-fixes.css` - QA error fixes

#### Components CSS (`assets/css/clients/components/`)
- `breadcrumbs.css` - Breadcrumb navigation
- `micro-animations.css` - Micro animations
- `empty-state.css` - Empty state styles
- `skeleton.css` - Skeleton loading
- `mobile-nav.css` - Mobile navigation
- `progress-steps.css` - Progress steps

#### Modules CSS (`assets/css/clients/modules/`)
- `reset.css` - CSS reset
- `modals.css` - Modal styles
- `buttons.css` - Button styles
- `forms.css` - Form styles
- `inputs.css` - Input styles

#### Utilities CSS (`assets/css/clients/utilities/`)
- `spacing.css` - Spacing utilities
- `flexbox.css` - Flexbox utilities
- `grid.css` - Grid utilities

### JavaScript Organization

#### Employees JavaScript (`assets/js/employees/`)
- `dashboard.js` - Dashboard bundle
- `base.js` - Base bundle
- `chunks/` - Code-split chunks

#### Clients JavaScript (`assets/js/clients/`)
- `base.js` - Base bundle
- `menu.js` - Menu bundle
- `thank-you.js` - Thank you bundle
- `chunks/` - Code-split chunks

### Images

Images are organized under restaurant slug:
```
assets/
└── pronto/
    └── {restaurant_slug}/
        ├── menu-items/
        ├── categories/
        └── branding/
```

## Nginx Configuration

### Server Configuration

```nginx
server {
    listen 9088;
    server_name localhost;

    # Static content
    location / {
        root /static_content;
        index index.html;
        try_files $uri $uri/ /index.html;
    }

    # Assets with caching
    location /assets/ {
        root /static_content;
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # CSS with caching
    location /assets/css/ {
        root /static_content;
        expires 7d;
        add_header Cache-Control "public";
    }

    # JavaScript with caching
    location /assets/js/ {
        root /static_content;
        expires 7d;
        add_header Cache-Control "public";
    }

    # Images with long caching
    location /assets/images/ {
        root /static_content;
        expires 365d;
        add_header Cache-Control "public, immutable";
    }
}
```

## Environment Variables

### Build-Time Variables
```bash
# Static container host
PRONTO_STATIC_CONTAINER_HOST=http://localhost:9088

# Application base URL
APP_BASE_URL=http://localhost:6080
```

### Runtime Variables (injected by Vite)
```javascript
import.meta.env.VITE_STATIC_HOST
import.meta.env.VITE_APP_BASE_URL
```

## Deployment

### Docker Build

```bash
# Build Docker image
docker build -t pronto-static -f src/static_content/Dockerfile .

# Run container
docker run -d -p 9088:9088 pronto-static
```

### Production Deployment

1. **Build assets:**
```bash
npm run build
```

2. **Build Docker image:**
```bash
docker build -t pronto-static:latest .
```

3. **Deploy to registry:**
```bash
docker tag pronto-static:latest registry.example.com/pronto-static:latest
docker push registry.example.com/pronto-static:latest
```

4. **Run in production:**
```bash
docker run -d \
  --name pronto-static \
  -p 9088:9088 \
  pronto-static:latest
```

## Performance Optimization

### CSS Optimization
- Minification with Vite
- PurgeCSS for unused CSS removal
- Critical CSS extraction
- CSS compression

### JavaScript Optimization
- Tree-shaking for dead code elimination
- Code splitting for smaller bundles
- Lazy loading for routes
- Minification with Terser

### Asset Optimization
- Image compression (WebP, AVIF)
- SVG optimization
- Font subsetting
- Asset compression (Gzip, Brotli)

### Caching Strategy
- Long cache headers for immutable assets (1 year)
- Short cache headers for versioned assets (7 days)
- ETags for cache validation
- Service Worker for offline support

## Monitoring

### Asset Delivery Monitoring

#### Nginx Access Logs
```bash
# View access logs
docker logs pronto-static

# Monitor in real-time
docker logs -f pronto-static
```

#### Performance Metrics
- Response time
- Cache hit rate
- Bandwidth usage
- Error rate

## Troubleshooting

### Common Issues

#### Assets Not Loading
```bash
# Check Nginx is running
docker ps | grep pronto-static

# Check Nginx logs
docker logs pronto-static

# Verify assets exist
ls -la src/static_content/assets/
```

#### Build Failures
```bash
# Clear node_modules
rm -rf node_modules
npm install

# Clear Vite cache
rm -rf .vite
npm run build
```

#### CSS Not Applying
```bash
# Check CSS file exists
ls -la src/static_content/assets/css/clients/

# Verify CSS path in HTML
# Check browser console for errors

# Clear browser cache
```

## Best Practices

### Development
- Use environment-specific configurations
- Test assets in development before deployment
- Use versioned asset names for cache busting
- Implement asset optimization strategies
- Monitor asset delivery performance

### CSS
- Use CSS custom properties for theming
- Implement responsive design
- Use CSS Grid and Flexbox for layouts
- Optimize CSS for performance
- Use CSS modules for component isolation

### JavaScript
- Use TypeScript for type safety
- Implement lazy loading
- Use code splitting for better performance
- Handle errors gracefully
- Implement proper error boundaries

### Images
- Use modern image formats (WebP, AVIF)
- Implement responsive images
- Optimize image sizes
- Use CDN for image delivery
- Implement lazy loading for images

## Maintenance

### Regular Tasks

#### Daily
- Monitor asset delivery performance
- Check error logs
- Verify cache hit rate

#### Weekly
- Review asset sizes
- Update dependencies
- Test asset delivery

#### Monthly
- Review and update optimization strategies
- Audit unused assets
- Review CDN configuration

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [Directory Structure](../estructura-directorios.md)
- [CSS Modular Architecture](../CSS_MODULAR_ARCHITECTURE.md)
- [Pronto-Clients](../pronto-clients/)
- [Pronto-Employees](../pronto-employees/)

## Contact

For questions or issues related to pronto-static, please refer to main project documentation or contact development team.
