# PRONTO FRONTEND DESIGN RULES - BASELINE DOCUMENTATION

## **1. Application Segmentation**

### **Client Application (pronto-clients)**
- **Theme**: Dark theme (`background: #1a202c`, `color: #f7fafc`)
- **Primary Color**: Orange-red gradient (`#ff8c5a` → `#ff6b35`)
- **Purpose**: Customer-facing ordering and payment interface
- **Design Philosophy**: Mobile-first, touch-friendly, minimal cognitive load

### **Employee Applications (pronto-employees)**
- **Theme**: Light theme (`background: #f8fafc`, `color: #0f172a`)
- **Primary Color**: Vibrant orange (`#ff6b35`)
- **Purpose**: Role-specific operational interfaces (waiter, chef, cashier, admin, system)
- **Design Philosophy**: Desktop-optimized with mobile support, information-dense, action-oriented

## **2. Layout System**

### **Grid & Spacing**
- Base spacing unit: rem-based system (0.25rem increments)
- Grid system: CSS Grid + Flexbox hybrid
- Container max-width: 1280px for main content areas
- Responsive breakpoints:
  - Mobile: ≤ 768px
  - Tablet: 768px - 1024px  
  - Desktop: ≥ 1024px
- Product cards: `clamp(180px, 22vw, 240px)` responsive sizing
- Sticky elements: Header (z-index 12060), navigation tabs (z-index 9999)

### **Component Layouts**
- Cards: Border-radius 16-20px, subtle shadows with hover elevation
- Modals: Centered with backdrop overlay, smooth fade/slide animations
- Forms: Consistent padding (1.25rem), proper label/input spacing
- Navigation: Sticky headers with backdrop blur effects

## **3. Color System**

### **Client Application (Dark Theme)**
- Primary: `#ff8c5a` (orange-red gradient)
- Primary Dark: `#ff6b35`
- Background: `#1a202c` (dark blue-gray)
- Text: `#f7fafc` (light gray-white)
- Text Secondary: `#a0aec0` (medium gray)
- Text Tertiary: `#718096` (dark gray)
- Surface: `#2d3748` (slightly lighter background)
- Success: `#68d391` (green)
- Error: `#fc8181` (red)

### **Employee Application (Light Theme)**
- Primary: `#ff6b35` (vibrant orange)
- Primary Light: `#fff1eb` (pale orange)
- Background: White/light gray backgrounds
- Text: `#0f172a` (dark blue-black)
- Text Secondary: `#64748b` (medium gray)
- Border: `#e2e8f0` (light gray)
- Surface: `#f8fafc` (very light blue)

### **Status Colors**
- New Order: Blue (`#dbeafe` background, `#1e40af` text)
- Confirmed: Green (`#dcfce7` background, `#166534` text)  
- Kitchen In Progress: Orange (`#fed7aa` background, `#9a3412` text)
- Ready for Delivery: Green (`#d1fae5` background, `#065f46` text)
- Sold Out: Red (`#fee2e2` background, `#b91c1c` text)

## **4. Typography**

### **Font Stack**
- Primary font: 'Inter', system-ui, sans-serif
- Font weights: 400 (regular), 500 (medium), 600 (semibold), 700 (bold), 800 (extrabold)
- Line heights: 1.2-1.6 depending on context

### **Typography Scale**
- Headings: 
  - H1: 1.25-1.5rem (client), 1.12rem (employees)
  - H2: 1.5rem (modals)
  - H3: 1.25rem (cards)
  - H4: 0.9-1.1rem (subsections)
- Body text: 0.875-1rem
- Captions: 0.75-0.85rem
- Buttons: 0.83-1rem with 700 weight

### **Text Styling**
- Truncation: `-webkit-line-clamp` for multi-line text
- Letter spacing: -0.025em for headings, normal for body
- Color hierarchy: Primary → Secondary → Tertiary

## **5. Component Specifications**

### **Buttons**
- Primary: 
  - Background: Linear gradient (`#ff6b35` to `#ff8c42`)
  - Text: White
  - Border-radius: 8-10px
  - Padding: 0.75-1rem
  - Hover: Transform scale + enhanced shadow
- Secondary: 
  - Background: White/light surface
  - Border: 1-2px solid
  - Text: Primary color or dark gray
- Icon buttons: 44px square, circular border-radius
- States: Hover, active, focus-visible, disabled (50% opacity)

### **Cards**
- Product Cards:
  - Border-radius: 20px
  - Shadow: `0 4px 20px rgba(0, 0, 0, 0.04)`
  - Hover: `transform: translateY(-6px)`, enhanced shadow
  - Image aspect ratio: 4/3
  - Quick-add button: Circular (+) with pulse animation
- Modifier Group Cards:
  - Border-radius: 16px
  - Background: White
  - Header: Light gray background with badges
  - Badges: Small tags with specific background colors

### **Form Elements**
- Inputs: 
  - Height: 46-48px
  - Border-radius: 8-12px
  - Border: 1-2px solid
  - Focus: Primary color outline + shadow
- Select dropdowns: Custom arrow indicator, consistent styling
- Checkboxes/Radio: Standard browser with custom styling
- Textareas: Min-height 96px, resizable vertical

### **Navigation Components**
- Tabs: 
  - Active state: Primary color bottom border
  - Hover: Background lightening
  - Badge indicators: Circular with count
- Category Tabs: Horizontal scrollable, pill-shaped
- Sidebar (Employees): Dark gradient background, module-based organization

## **6. Interactions & Animations**

### **Micro-interactions**
- Hover states: Subtle transforms, color changes, shadow enhancements
- Focus states: 2px primary color outline with offset
- Active states: Scale down transforms (0.95-0.98)
- Disabled states: 50% opacity, no pointer events

### **Animations**
- Transitions: 0.2-0.3s ease/ease-out
- Transforms: Cubic-bezier timing for natural motion
  - Card transforms: `0.3s cubic-bezier(0.4, 0, 0.2, 1)`
  - Image transforms: `0.4s ease`
- Loading states: Spinner animations, skeleton screens
- Modal entrances: Fade + slide combinations
- Notification pulses: Ringing bell animations for alerts

### **Accessibility Features**
- Keyboard navigation: Full tab support with visual focus indicators
- Reduced motion: Respects `prefers-reduced-motion` media query
- ARIA labels: Proper labeling for screen readers
- Color contrast: Meets WCAG standards for text/background

## **7. Iconography & Visual Elements**

### **Icons**
- SVG icons: Inline SVG with stroke-based styling
- Icon buttons: Consistent 20px sizing
- Status indicators: Emoji-based (🍽️, 📜, ⚙️, 🚪)
- Badge icons: Contextual (promo, sold-out, quick-serve)

### **Images**
- Product images: WebP format with PNG fallback
- Avatars: Circular with role-based borders
- Placeholder images: SVG-generated with initials
- Image loading: Lazy loading with error handling

### **Badges & Labels**
- Promo badges: Primary orange background, white text
- Sold-out badges: Red background, white text  
- Service mode: Green (quick-serve) vs Blue (prep required)
- Count badges: Circular with primary background

## **8. Responsive Design Patterns**

### **Mobile-First Approach**
- Touch targets: Minimum 44px for interactive elements
- Spacing: Reduced padding/margins on mobile
- Typography: Smaller font sizes with maintained readability
- Layout: Single column on mobile, multi-column on desktop

### **Adaptive Components**
- Product grids: 1-2 columns on mobile, 4+ on desktop
- Navigation: Hamburger menu on mobile, full navigation on desktop
- Forms: Full-width inputs on mobile, constrained width on desktop
- Modals: Full-screen on mobile, centered on desktop

## **9. State Management & Feedback**

### **Loading States**
- Global loading: Fixed top-right spinner with "Cargando" text
- Component loading: Skeleton screens for cards
- Button loading: Disabled state with spinner

### **Error Handling**
- Form validation: Inline error messages with red coloring
- API errors: Toast notifications with error details
- Network errors: User-friendly messages (no technical details)

### **Success States**
- Confirmation: Green success messages with checkmark icons
- Order confirmation: Confetti animations for positive feedback
- Form submission: Success modals with next steps

## **10. Design Tokens & Variables**

### **CSS Custom Properties**

**Employee Application (from tokens.css):**
```css
:root {
  /* BRAND COLORS */
  --color-primary: #ff6b35;
  --color-primary-dark: #e85a2b;
  --color-primary-light: #ff8c42;
  --color-primary-bg: #fff7ed;

  /* STATUS COLORS */
  --color-success: #10b981;
  --color-success-bg: #dcfce7;
  --color-success-text: #166534;
  --color-warning: #f59e0b;
  --color-warning-bg: #fef3c7;
  --color-warning-text: #92400e;
  --color-danger: #ef4444;
  --color-danger-bg: #fee2e2;
  --color-danger-text: #991b1b;
  --color-info: #3b82f6;
  --color-info-bg: #dbeafe;
  --color-info-text: #1e40af;

  /* NEUTRAL COLORS */
  --color-white: #ffffff;
  --color-gray-50: #f9fafb;
  --color-gray-100: #f3f4f6;
  --color-gray-200: #e5e7eb;
  --color-gray-300: #d1d5db;
  --color-gray-400: #9ca3af;
  --color-gray-500: #6b7280;
  --color-gray-600: #4b5563;
  --color-gray-700: #374151;
  --color-gray-800: #1f2937;
  --color-gray-900: #111827;

  /* SPACING */
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-3: 0.75rem;
  --space-4: 1rem;
  --space-5: 1.25rem;
  --space-6: 1.5rem;
  --space-8: 2rem;
  --space-10: 2.5rem;
  --space-12: 3rem;
  --space-16: 4rem;

  /* BORDER RADIUS */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
  --radius-xl: 16px;
  --radius-full: 9999px;

  /* SHADOWS */
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
  --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
  --shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.15);
  --shadow-inner: inset 0 2px 4px rgba(0, 0, 0, 0.06);

  /* TYPOGRAPHY */
  --font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-size-xs: 0.75rem;
  --font-size-sm: 0.875rem;
  --font-size-base: 1rem;
  --font-size-lg: 1.125rem;
  --font-size-xl: 1.25rem;
  --font-size-2xl: 1.5rem;
  --font-size-3xl: 1.875rem;
  --font-size-4xl: 2.25rem;
  --font-weight-normal: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;
  --line-height-tight: 1.25;
  --line-height-normal: 1.5;
  --line-height-relaxed: 1.75;

  /* TRANSITIONS */
  --transition-fast: 150ms ease;
  --transition-base: 200ms ease;
  --transition-slow: 300ms ease;

  /* Z-INDEX SCALE */
  --z-dropdown: 1000;
  --z-sticky: 1020;
  --z-fixed: 1030;
  --z-modal-backdrop: 1040;
  --z-modal: 1050;
  --z-popover: 1060;
  --z-tooltip: 1070;
}
```

**Client Application (from design-system.css):**
```css
:root {
  --client-bg: #f1f5f9;
  --client-surface: #ffffff;
  --client-border: #dbe4ee;
  --client-text: #0f172a;
  --client-muted: #64748b;
  --client-primary: #ff6b35;
  --client-primary-strong: #f97316;
}
```

### **Theme Switching**
- Client: Dark theme enforced
- Employees: Light theme with dark sidebar option
- Variables: Scoped to prevent cross-contamination

## **11. Component Actions & Behaviors**

### **Product Card Actions**
- Click card: Opens product detail modal
- Quick-add button: Adds product to cart immediately
- Hover: Elevates card with shadow enhancement
- Sold out: Grayscale filter with overlay message

### **Employee Board Actions**
- Star orders: Toggle favorite status for quick access
- Order selection: Opens detailed order view
- Status updates: Mark as ready, cancel, etc.
- Table management: Assign/unassign tables to orders

### **Navigation Actions**
- Tab switching: Updates active view with smooth transition
- Search: Filters content in real-time
- Filter application: Updates visible items immediately
- Modal opening: Smooth entrance with backdrop

## **12. Consistency Rules**

### **Cross-Platform Consistency**
- Shared components: Reusable Vue components across applications
- API patterns: Consistent HTTP client patterns
- State management: Centralized stores for shared data
- Error handling: Unified error message system

### **Design Language**
- Rounded corners: Consistent border-radius values (8px, 12px, 16px, 20px)
- Shadow depth: Layered shadows for depth perception
- Color harmony: Limited palette with clear hierarchy
- Typography rhythm: Consistent line-height and spacing