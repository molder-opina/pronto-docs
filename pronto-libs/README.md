# Pronto-Shared Library Documentation

## Overview

Pronto-Shared is the core shared library for the Pronto platform. It provides common functionality, models, services, and utilities that are used across all Pronto applications (pronto-clients, pronto-employees, pronto-api).

**Version:** 1.0.0
**Python:** 3.14+
**Framework:** SQLAlchemy, Flask extensions

## Installation

```bash
# Install from wheel file
pip install pronto_shared-1.0.0-py3-none-any.whl

# Install from local source
cd pronto-libs
pip install -e .
```

## Architecture

### Core Components

```
pronto_shared/
├── __init__.py
├── models.py                    # SQLAlchemy models (80KB)
├── constants.py                 # Application constants
├── config.py                    # Configuration management
├── db.py                        # Database connection utilities
├── extensions.py                # Flask extensions (CSRF)
├── schemas.py                   # Pydantic schemas
├── serializers.py               # Data serializers
├── validation.py                # Validation utilities
├── security.py                 # Security utilities
├── security_middleware.py      # Security middleware
├── audit_middleware.py          # Audit logging middleware
├── error_handlers.py           # Flask error handlers
├── error_catalog.py            # Error catalog
├── logging_config.py           # Logging configuration
├── jwt_service.py             # JWT token management
├── jwt_middleware.py          # JWT middleware for Flask
├── scope_guard.py              # JWT scope validation
├── permissions.py             # Permission system
├── datetime_utils.py          # Date/time utilities
├── table_utils.py             # Table management utilities
├── psycopg2_patch.py          # PostgreSQL patches
├── socketio_manager.py        # Socket.IO manager
├── notification_stream_service.py  # Notification streaming
├── migrations/                 # Alembic database migrations
├── auth/                       # Authentication utilities
├── orchestrator/              # Workflow orchestration
├── services/                   # Business logic services
├── supabase/                   # Supabase integration
├── static/                     # Static assets
└── templates/                  # Jinja2 templates
```

## Models

### Core Models (`models.py`)

#### Employee
Employee information and credentials
- `id` - Primary key
- `name` - Employee name
- `email` - Employee email (unique)
- `phone` - Employee phone
- `password_hash` - Password hash
- `role` - Employee role (waiter, chef, cashier, admin, system)
- `is_active` - Active status
- `created_at` - Creation timestamp
- `updated_at` - Last update timestamp

#### Customer
Customer information
- `id` - Primary key
- `name` - Customer name
- `email` - Customer email
- `phone` - Customer phone
- `created_at` - Creation timestamp
- `updated_at` - Last update timestamp

#### DiningSession
Dining session management
- `id` - Primary key
- `session_id` - Unique session identifier
- `table_id` - Associated table
- `customer_id` - Associated customer
- `status` - Session status (active, closed, merged)
- `created_at` - Creation timestamp
- `updated_at` - Last update timestamp

#### Order
Order data
- `id` - Primary key
- `order_number` - Unique order number
- `session_id` - Associated session
- `customer_id` - Associated customer
- `status` - Order status
- `total` - Order total
- `tax` - Tax amount
- `notes` - Order notes
- `created_at` - Creation timestamp
- `updated_at` - Last update timestamp

#### OrderItem
Order items
- `id` - Primary key
- `order_id` - Associated order
- `menu_item_id` - Menu item reference
- `quantity` - Item quantity
- `unit_price` - Unit price
- `total_price` - Total price
- `notes` - Item notes

#### OrderItemModifier
Order item modifiers
- `id` - Primary key
- `order_item_id` - Associated order item
- `modifier_id` - Modifier reference
- `quantity` - Modifier quantity

#### MenuItem
Menu item data
- `id` - Primary key
- `name` - Item name
- `description` - Item description
- `price` - Item price
- `category_id` - Associated category
- `image_url` - Image URL
- `is_available` - Availability status
- `created_at` - Creation timestamp
- `updated_at` - Last update timestamp

#### MenuCategory
Menu categories
- `id` - Primary key
- `name` - Category name
- `description` - Category description
- `display_order` - Display order
- `is_active` - Active status

#### Table
Table information
- `id` - Primary key
- `name` - Table name
- `area_id` - Associated area
- `capacity` - Table capacity
- `status` - Table status (available, occupied, reserved)

#### Area
Area/zone management
- `id` - Primary key
- `name` - Area name
- `description` - Area description
- `display_order` - Display order

#### DayPeriod
Day period configuration
- `id` - Primary key
- `name` - Period name (breakfast, lunch, dinner)
- `start_time` - Start time
- `end_time` - End time

#### Promotion
Promotions
- `id` - Primary key
- `name` - Promotion name
- `description` - Promotion description
- `discount_type` - Discount type (percentage, fixed)
- `discount_value` - Discount value
- `start_date` - Start date
- `end_date` - End date
- `is_active` - Active status

#### DiscountCode
Discount codes
- `id` - Primary key
- `code` - Discount code
- `discount_type` - Discount type
- `discount_value` - Discount value
- `max_uses` - Maximum uses
- `current_uses` - Current uses
- `is_active` - Active status

#### Modifier
Item modifiers
- `id` - Primary key
- `name` - Modifier name
- `price` - Modifier price
- `is_available` - Availability status

#### Feedback
Customer feedback
- `id` - Primary key
- `session_id` - Associated session
- `order_id` - Associated order
- `rating` - Rating (1-5)
- `comment` - Comment
- `created_at` - Creation timestamp

#### BusinessInfo
Business information
- `id` - Primary key
- `name` - Business name
- `description` - Business description
- `address` - Business address
- `phone` - Business phone
- `email` - Business email
- `website` - Website URL

#### Settings
Application settings
- `id` - Primary key
- `key` - Setting key
- `value` - Setting value
- `type` - Value type (string, number, boolean)
- `description` - Setting description

#### Role
Role definitions
- `id` - Primary key
- `name` - Role name
- `description` - Role description

#### Permission
Permission definitions
- `id` - Primary key
- `name` - Permission name
- `description` - Permission description

## Constants

### OrderStatus (`constants.py`)
- `PENDING` - Order pending
- `CONFIRMED` - Order confirmed
- `PREPARING` - Order preparing
- `READY` - Order ready
- `DELIVERED` - Order delivered
- `COMPLETED` - Order completed
- `CANCELLED` - Order cancelled

### SessionStatus (`constants.py`)
- `ACTIVE` - Session active
- `CLOSED` - Session closed
- `MERGED` - Session merged

### Permission Enum
- `LOGIN_SYSTEM` - Login to system
- `MANAGE_EMPLOYEES` - Manage employees
- `MANAGE_MENU` - Manage menu items
- `PROCESS_ORDERS` - Process orders
- `VIEW_ANALYTICS` - View analytics
- `MANAGE_SETTINGS` - Manage system settings
- `PAYMENTS_PROCESS` - Process payments
- `VIEW_REPORTS` - View reports
- `MANAGE_ROLES` - Manage roles and permissions

## Services

### Business Logic Services (`services/`)

#### order_service.py (73KB)
**Purpose:** Core order management logic
**Key Functions:**
- `create_order()` - Create new order
- `update_order()` - Update existing order
- `cancel_order()` - Cancel order
- `list_orders()` - List orders with filters
- `get_order()` - Get order details
- `get_dashboard_metrics()` - Get dashboard metrics
- `get_waiter_tips()` - Get waiter tips
- `validate_order()` - Validate order data

#### seed.py (173KB)
**Purpose:** Seed data initialization
**Key Functions:**
- `load_seed_data()` - Load seed data (UPSERT mode)
- `ensure_seed_data()` - Ensure seed data exists
- Seed data includes:
  - Default roles
  - Default permissions
  - Default business settings
  - Default menu categories
  - Default day periods
  - Default areas

#### menu_service.py
**Purpose:** Menu management
**Key Functions:**
- `list_menu()` - Get full menu
- `fetch_menu()` - Fetch menu with caching
- `validate_menu_item()` - Validate menu item

#### analytics_service.py (37KB)
**Purpose:** Analytics and reporting
**Key Functions:**
- `get_dashboard_analytics()` - Dashboard analytics
- `get_sales_analytics()` - Sales analytics
- `get_traffic_analytics()` - Traffic analytics
- `get_performance_analytics()` - Performance analytics

#### role_service.py
**Purpose:** Role and permission management
**Key Functions:**
- `list_roles()` - List all roles
- `get_role_permissions()` - Get role permissions
- `list_employees_by_permission()` - List employees by permission
- `list_employees_with_permissions()` - List employees with permissions

#### settings_service.py
**Purpose:** Application settings management
**Key Functions:**
- `get_setting()` - Get setting value
- `set_setting()` - Set setting value
- `get_settings()` - Get multiple settings
- `get_config_map()` - Get settings as map

#### business_config_service.py
**Purpose:** Business configuration management
**Key Functions:**
- `get_config_value()` - Get config value
- `get_config_map()` - Get config map
- `sync_env_config_to_db()` - Sync environment variables to database

#### secret_service.py
**Purpose:** Secret management
**Key Functions:**
- `load_env_secrets()` - Load secrets from environment
- `sync_env_secrets_to_db()` - Sync secrets to database
- `get_secret()` - Get secret value

#### auth_service.py
**Purpose:** Authentication services
**Key Functions:**
- `authenticate_user()` - Authenticate user
- `verify_password()` - Verify password
- `hash_password()` - Hash password

#### employee_service.py
**Purpose:** Employee management
**Key Functions:**
- `list_employees()` - List employees
- `get_employee()` - Get employee details
- `create_employee()` - Create employee
- `update_employee()` - Update employee

#### customer_service.py
**Purpose:** Customer management
**Key Functions:**
- `get_customer()` - Get customer details
- `update_customer()` - Update customer
- `create_customer()` - Create customer

#### feedback_service.py
**Purpose:** Feedback management
**Key Functions:**
- `list_feedback()` - List feedback
- `get_feedback()` - Get feedback details
- `create_feedback()` - Create feedback
- `respond_feedback()` - Respond to feedback

#### feedback_email_service.py
**Purpose:** Feedback email notifications
**Key Functions:**
- `send_feedback_email()` - Send feedback email
- `generate_feedback_email()` - Generate feedback email

#### image_service.py
**Purpose:** Image management
**Key Functions:**
- `upload_image()` - Upload image
- `optimize_image()` - Optimize image
- `delete_image()` - Delete image
- `get_image_url()` - Get image URL

#### ai_image_service.py
**Purpose:** AI-powered image processing
**Key Functions:**
- `generate_image_description()` - Generate image description
- `analyze_image()` - Analyze image content
- `suggest_image_tags()` - Suggest image tags

#### area_service.py
**Purpose:** Area/zone management
**Key Functions:**
- `list_areas()` - List areas
- `get_area()` - Get area details
- `create_area()` - Create area
- `update_area()` - Update area

#### day_period_service.py
**Purpose:** Day period management
**Key Functions:**
- `list_day_periods()` - List day periods
- `get_current_period()` - Get current period
- `get_period_by_time()` - Get period by time

#### notification_service.py
**Purpose:** Notification management
**Key Functions:**
- `send_notification()` - Send notification
- `list_notifications()` - List notifications
- `mark_notification_read()` - Mark notification as read

#### notifications_service.py
**Purpose:** Email notifications
**Key Functions:**
- `send_order_confirmation_email()` - Send order confirmation
- `send_order_status_email()` - Send order status update
- `send_welcome_email()` - Send welcome email

#### order_modification_service.py
**Purpose:** Order modification logic
**Key Functions:**
- `add_item_to_order()` - Add item to order
- `remove_item_from_order()` - Remove item from order
- `update_item_quantity()` - Update item quantity
- `add_modifier_to_item()` - Add modifier to item
- `remove_modifier_from_item()` - Remove modifier from item

#### order_state_machine.py
**Purpose:** Order state management
**Key Functions:**
- `transition_order_status()` - Transition order status
- `validate_status_transition()` - Validate status transition
- `get_allowed_transitions()` - Get allowed transitions

#### price_service.py
**Purpose:** Price calculations
**Key Functions:**
- `calculate_order_total()` - Calculate order total
- `calculate_order_tax()` - Calculate order tax
- `calculate_item_total()` - Calculate item total

#### recommendation_service.py
**Purpose:** Item recommendations
**Key Functions:**
- `get_recommendations()` - Get recommendations
- `get_popular_items()` - Get popular items
- `get_similar_items()` - Get similar items

#### report_export_service.py
**Purpose:** Report generation
**Key Functions:**
- `export_sales_report()` - Export sales report
- `export_orders_report()` - Export orders report
- `export_employees_report()` - Export employees report

#### ticket_pdf_service.py
**Purpose:** Ticket/PDF generation
**Key Functions:**
- `generate_order_ticket()` - Generate order ticket PDF
- `generate_receipt()` - Generate receipt PDF
- `generate_report_pdf()` - Generate report PDF

#### waiter_call_service.py
**Purpose:** Waiter call management
**Key Functions:**
- `create_waiter_call()` - Create waiter call
- `list_waiter_calls()` - List waiter calls
- `dismiss_waiter_call()` - Dismiss waiter call

#### waiter_table_assignment_service.py
**Purpose:** Waiter table assignments
**Key Functions:**
- `assign_tables()` - Assign tables to waiter
- `get_waiter_assignments()` - Get waiter assignments
- `release_tables()` - Release tables from waiter

#### cancel_order_service.py
**Purpose:** Order cancellation logic
**Key Functions:**
- `cancel_order()` - Cancel order
- `validate_cancellation()` - Validate cancellation

#### status_label_service.py
**Purpose:** Status label management
**Key Functions:**
- `get_status_label()` - Get status label
- `get_status_labels()` - Get all status labels

#### custom_role_service.py
**Purpose:** Custom role management
**Key Functions:**
- `create_custom_role()` - Create custom role
- `update_custom_role()` - Update custom role
- `delete_custom_role()` - Delete custom role

#### enhanced_search_service.py
**Purpose:** Enhanced search functionality
**Key Functions:**
- `search_menu_items()` - Search menu items
- `search_orders()` - Search orders
- `search_employees()` - Search employees

#### email_service.py
**Purpose:** Email service
**Key Functions:**
- `send_email()` - Send email
- `render_email_template()` - Render email template

#### menu_validation.py
**Purpose:** Menu validation
**Key Functions:**
- `validate_menu_item()` - Validate menu item
- `validate_category()` - Validate category

#### payments.py
**Purpose:** Payment utilities
**Key Functions:**
- `calculate_payment_amount()` - Calculate payment amount
- `validate_payment()` - Validate payment

## Database

### Connection Management (`db.py`)

#### Database Engine
- **Engine:** SQLAlchemy engine with connection pooling
- **Session:** Thread-safe session management
- **Initialization:** `init_engine()` and `init_db()`

#### Session Management
```python
from pronto_shared.db import get_session

# Using context manager
with get_session() as session:
    employee = session.query(Employee).first()
    print(employee.name)

# Manual session management
session = get_session()
try:
    employee = session.query(Employee).first()
    session.commit()
finally:
    session.close()
```

### Database Migrations (`migrations/`)

#### Alembic Configuration
- **Tool:** Alembic for database migrations
- **Location:** `migrations/versions/`
- **Configuration:** `migrations/alembic.ini`

#### Running Migrations
```bash
# Create new migration
alembic revision --autogenerate -m "description"

# Apply migrations
alembic upgrade head

# Rollback migration
alembic downgrade -1
```

## Authentication & Authorization

### JWT Service (`jwt_service.py`)

#### Token Generation
```python
from pronto_shared.jwt_service import generate_token, verify_token

# Generate token
token = generate_token(
    user_id="123",
    role="waiter",
    scope="waiter",
    expires_in=3600
)

# Verify token
payload = verify_token(token)
```

#### Token Types
- **Access Token:** Short-lived token (1 hour)
- **Refresh Token:** Long-lived token (7 days)
- **Scope:** Role-based scope (waiter, chef, cashier, admin, system)

### JWT Middleware (`jwt_middleware.py`)

#### Middleware Configuration
```python
from pronto_shared.jwt_middleware import init_jwt_middleware, get_current_user

# Initialize middleware
init_jwt_middleware(app)

# Get current user in routes
@app.route("/api/orders")
def get_orders():
    user = get_current_user()
    return jsonify({"user": user})
```

#### Decorators
- `@jwt_required()` - Require JWT authentication
- `@jwt_optional()` - Optional JWT authentication

### Permissions System (`permissions.py`)

#### Permission Checks
```python
from pronto_shared.permissions import has_permission, Permission

# Check permission
if has_permission("waiter", Permission.PROCESS_ORDERS):
    # Process order

# Get permissions for role
permissions = get_permissions_for_role("waiter")
```

#### Permission Decorators
- `@permission_required(Permission.MANAGE_MENU)` - Require specific permission
- `@web_login_required()` - Require login for web routes
- `@web_role_required("admin")` - Require specific role

## Security

### Security Middleware (`security_middleware.py`)

#### Security Headers
- **X-Content-Type-Options:** nosniff
- **X-Frame-Options:** DENY
- **X-XSS-Protection:** 1; mode=block
- **Strict-Transport-Security:** max-age=31536000
- **Content-Security-Policy:** Configurable

#### Configuration
```python
from pronto_shared.security_middleware import configure_security_headers

# Configure security headers
configure_security_headers(app)
```

### Audit Middleware (`audit_middleware.py`)

#### Audit Logging
```python
from pronto_shared.audit_middleware import init_audit_middleware

# Initialize audit middleware
init_audit_middleware(app)
```

#### Audit Log Format
```
timestamp|level|user|action|type|details|ip|user_agent
```

### Security Utilities (`security.py`)

#### Password Hashing
```python
from pronto_shared.security import hash_password, verify_password

# Hash password
hashed = hash_password("password123")

# Verify password
if verify_password("password123", hashed):
    # Password matches
```

### CSRF Protection (`extensions.py`)

#### CSRF Configuration
```python
from pronto_shared.extensions import csrf

# Initialize CSRF
csrf.init_app(app)

# Exempt routes
csrf.exempt(api_bp)
```

## Configuration

### Config Management (`config.py`)

#### Configuration Loading
```python
from pronto_shared.config import load_config, read_bool, validate_required_env_vars

# Load configuration
config = load_config("pronto-clients")

# Read boolean value
debug = read_bool("DEBUG_MODE", "false")

# Validate required environment variables
validate_required_env_vars(skip_in_debug=False)
```

#### Configuration Properties
- `app_name` - Application name
- `log_level` - Logging level
- `secret_key` - Flask secret key
- `debug_mode` - Debug mode flag
- `flask_debug` - Flask debug flag
- `tax_rate` - Tax rate
- `restaurant_name` - Restaurant name
- `restaurant_slug` - Restaurant slug
- `static_assets_path` - Static assets path
- `pronto_static_container_host` - Static assets host

## Error Handling

### Error Handlers (`error_handlers.py`)

#### Register Error Handlers
```python
from pronto_shared.error_handlers import register_error_handlers

# Register error handlers
register_error_handlers(app)
```

### Error Catalog (`error_catalog.py`)

#### Error Definitions
Standard error codes and messages:
- `VALIDATION_ERROR` - Input validation failed
- `AUTHENTICATION_ERROR` - Authentication failed
- `AUTHORIZATION_ERROR` - Authorization failed
- `NOT_FOUND_ERROR` - Resource not found
- `BUSINESS_ERROR` - Business rule violation
- `DATABASE_ERROR` - Database error

## Logging

### Logging Configuration (`logging_config.py`)

#### Configure Logging
```python
from pronto_shared.logging_config import configure_logging

# Configure logging
configure_logging("pronto-clients", "INFO")
```

#### Log Format
```
timestamp|level|app_name|module|function|line|message|extra_data
```

## Real-time

### Supabase Integration (`supabase/`)

#### Real-time Events (`supabase/realtime.py`)
- `emit_new_order()` - Emit new order event
- `emit_order_status_change()` - Emit order status change
- `emit_waiter_call()` - Emit waiter call event

### Socket.IO Manager (`socketio_manager.py`)

#### Socket.IO Configuration
```python
from pronto_shared.socketio_manager import socketio

# Initialize Socket.IO
socketio.init_app(app)
```

## Serialization

### Serializers (`serializers.py`)

#### Serialization Functions
- `serialize_order()` - Serialize order
- `serialize_order_item()` - Serialize order item
- `serialize_menu_item()` - Serialize menu item
- `serialize_employee()` - Serialize employee
- `serialize_customer()` - Serialize customer

### Schemas (`schemas.py`)

#### Pydantic Schemas
- `OrderSchema` - Order validation schema
- `OrderItemSchema` - Order item validation schema
- `MenuItemSchema` - Menu item validation schema
- `CustomerSchema` - Customer validation schema

## Validation

### Validation Utilities (`validation.py`)

#### Validation Functions
- `validate_email()` - Validate email address
- `validate_phone()` - Validate phone number
- `validate_required_fields()` - Validate required fields
- `sanitize_input()` - Sanitize user input

## Utilities

### Date/Time Utilities (`datetime_utils.py`)
- `format_datetime()` - Format datetime
- `parse_datetime()` - Parse datetime string
- `get_current_time()` - Get current time in timezone

### Table Utilities (`table_utils.py`)
- `format_table_name()` - Format table name
- `parse_table_name()` - Parse table name
- `generate_table_name()` - Generate table name

### PostgreSQL Patch (`psycopg2_patch.py`)
- `apply_psycopg2_patch()` - Apply PostgreSQL patches

## Orchestrator

### Workflow Orchestration (`orchestrator/`)
Workflow and business process orchestration:
- Order processing workflows
- Payment processing workflows
- Notification workflows

## Payment Providers

### Payment Provider Services (`services/payment_providers/`)
- `stripe_service.py` - Stripe payment provider
- `clip_service.py` - Clip payment provider

## Templates

### Jinja2 Templates (`templates/`)
- Shared Jinja2 templates
- Email templates
- Report templates

## Static Assets

### Static Files (`static/`)
- Shared static assets
- CSS files
- JavaScript files

## Development

### Building the Library
```bash
# Install build dependencies
pip install build

# Build wheel file
python -m build

# The wheel file will be in dist/
```

### Testing
```bash
# Run tests
pytest

# Run tests with coverage
pytest --cov=pronto_shared
```

### Development Installation
```bash
# Install in development mode
pip install -e .

# This will create a symlink to the source
# Changes will be reflected immediately
```

## Usage Examples

### Importing Models
```python
from pronto_shared.models import Employee, Order, MenuItem
from pronto_shared.db import get_session

with get_session() as session:
    employees = session.query(Employee).all()
    for employee in employees:
        print(employee.name)
```

### Using Services
```python
from pronto_shared.services.order_service import create_order
from pronto_shared.db import get_session

with get_session() as session:
    order = create_order(session, {
        "customer_id": "123",
        "items": [...]
    })
    session.commit()
```

### JWT Authentication
```python
from pronto_shared.jwt_service import generate_token, verify_token
from pronto_shared.jwt_middleware import jwt_required

@app.route("/api/orders", methods=["POST"])
@jwt_required()
def create_order_endpoint():
    user = get_current_user()
    # Process order
```

### Permission Checks
```python
from pronto_shared.permissions import has_permission, Permission

@app.route("/admin/settings", methods=["POST"])
def update_settings():
    user = get_current_user()
    if not has_permission(user["role"], Permission.MANAGE_SETTINGS):
        return jsonify({"error": "Permission denied"}), 403
    # Update settings
```

## Best Practices

### Database Operations
- Always use context managers for sessions
- Commit transactions explicitly
- Handle exceptions properly
- Use SQLAlchemy ORM instead of raw SQL

### Error Handling
- Use standardized error responses
- Log errors appropriately
- Provide clear error messages
- Use proper HTTP status codes

### Security
- Never expose sensitive data
- Validate all inputs
- Use prepared statements
- Implement proper authentication and authorization

### Performance
- Use database connection pooling
- Optimize database queries
- Implement caching where appropriate
- Use pagination for large datasets

## Dependencies

### Required Dependencies
- SQLAlchemy - ORM
- Flask - Web framework
- PyJWT - JWT handling
- Pydantic - Data validation
- psycopg2 - PostgreSQL adapter
- python-dotenv - Environment variables

### Optional Dependencies
- Flask-CORS - CORS support
- Flask-WTF - CSRF protection
- python-socketio - Socket.IO support
- supabase - Supabase client

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [Directory Structure](../estructura-directorios.md)
- [API Routes Documentation](../estructura-routes-api.md)
- [Environment Variables](../ENVIRONMENT_VARIABLES.md)
- [Logging Standard](../LOGGING_STANDARD.md)
- [Pronto-Clients](../pronto-clients/)
- [Pronto-Employees](../pronto-employees/)
- [Pronto-API](../pronto-api/)

## Contact

For questions or issues related to pronto-shared, please refer to the main project documentation or contact the development team.
