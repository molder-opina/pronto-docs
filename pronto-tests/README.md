# Pronto-Tests Documentation

## Overview

Pronto-Tests provides comprehensive testing framework for Pronto platform. It includes unit tests, integration tests, and end-to-end (E2E) tests using Playwright.

**Purpose:** Automated testing and quality assurance
**Testing Tools:** Playwright, pytest
**Coverage:** Unit, integration, E2E tests

## Architecture

### Core Components

```
pronto-tests/
├── tests/
│   ├── functionality/         # API, integration, UI, E2E y unit funcional
│   ├── accessibility/         # Axe / accessibility checks
│   ├── design/                # Diseño, screenshots y reportes visuales
│   └── unit/                  # Unit tests compartidos del workspace
├── scripts/
│   └── run-tests.sh           # Runner principal {all|functionality|performance|design}
├── playwright.config.ts       # Playwright configuration
├── pytest.ini                 # Pytest configuration
├── package.json               # Tooling frontend para Playwright
└── README.md                  # This file
```

## Test Structure

### E2E Tests
Located canonically in `tests/functionality/e2e/`; these tests simulate real user interactions across the entire platform.

#### Test Categories
- **Customer Flow** - Browse menu, add items, checkout
- **Employee Flow** - Login, process orders, manage tables
- **Admin Flow** - Manage employees, settings, menu
- **Payment Flow** - Process payments, handle refunds

### Integration Tests
Located canonically in `tests/functionality/integration/`; these tests verify interactions between components and services.

#### Test Categories
- **API Integration** - Test API endpoints
- **Database Integration** - Test database operations
- **Service Integration** - Test service interactions
- **External Services** - Test third-party integrations

### Unit Tests
Primary functional unit coverage lives in `tests/functionality/unit/`, while shared workspace unit checks also exist under `tests/unit/`.

#### Test Categories
- **Model Tests** - Test SQLAlchemy models
- **Service Tests** - Test business logic
- **Utility Tests** - Test helper functions
- **Component Tests** - Test Vue components

## Configuration

### Playwright Configuration

```typescript
// playwright.config.ts
export default defineConfig({
  testDir: './tests',
  timeout: 30000,
  retries: 2,
  workers: process.env.CI ? 1 : undefined,
  reporter: [
    ['html'],
    ['json', { outputFile: 'test-results/results.json' }],
  ],
  use: {
    baseURL: 'http://localhost:6080',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
  ],
  webServer: {
    command: 'npm run dev',
    port: 6080,
  },
});
```

### Environment Variables

```bash
# Test Environment
TEST_ENVIRONMENT=development

# Base URLs
CLIENTS_BASE_URL=http://localhost:6080
EMPLOYEES_BASE_URL=http://localhost:6081
API_BASE_URL=http://localhost:6082

# Database
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=pronto
POSTGRES_PASSWORD=pronto123
POSTGRES_DB=pronto_test

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379

# Test Credentials
TEST_EMPLOYEE_EMAIL=test@example.com
TEST_EMPLOYEE_PASSWORD=Test123!
TEST_CUSTOMER_EMAIL=customer@example.com
TEST_CUSTOMER_PASSWORD=Test123!

# Test Timeout
TEST_TIMEOUT=30000
```

## Running Tests

### Install Dependencies

```bash
# Install Node.js dependencies
npm install

# Install Playwright browsers
npx playwright install
```

### Run All Tests

```bash
# Canonical aggregated runner
./scripts/run-tests.sh all
```

### Run E2E Tests

```bash
# Run all E2E tests
npx playwright test tests/functionality/e2e/

# Run specific test file
npx playwright test tests/functionality/e2e/<file>.spec.ts

# Run tests in specific browser
npx playwright test --project=chromium

# Run tests in headed mode
npx playwright test --headed

# Run tests in debug mode
npx playwright test --debug
```

### Run Integration Tests

```bash
# Run all integration tests
pytest tests/functionality/integration/

# Run specific test file
pytest tests/functionality/integration/<file>.py

# Run with coverage
pytest tests/functionality/integration/ --cov --cov-report=html
```

### Run Unit Tests

```bash
# Functional unit suite
pytest tests/functionality/unit/

# Shared workspace unit suite
pytest tests/unit/

# Run with coverage
pytest tests/functionality/unit/ --cov --cov-report=html

# Run specific test
pytest tests/unit/<file>.py::<test_name>
```

## Test Scripts

### Available Scripts

#### `scripts/run-tests.sh`
Runs the canonical aggregated test suite.

**Usage:**
```bash
./scripts/run-tests.sh all
./scripts/run-tests.sh functionality
./scripts/run-tests.sh performance
./scripts/run-tests.sh design
```

#### `scripts/setup-test-env.sh`
Sets up test environment.

**Usage:**
```bash
./scripts/setup-test-env.sh
```

## Test Data

### Seed Data
Test environment is seeded with:
- Default roles and permissions
- Test employees (waiter, chef, cashier, admin)
- Test menu items
- Test customers
- Test orders

### Test Fixtures
Located in `tests/fixtures/` directory:
- `employee.py` - Employee fixtures
- `customer.py` - Customer fixtures
- `order.py` - Order fixtures
- `menu.py` - Menu fixtures

## Writing Tests

### E2E Test Example

```typescript
// tests/customer-flow.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Customer Flow', () => {
  test('should browse menu and place order', async ({ page }) => {
    // Navigate to menu
    await page.goto('/menu');

    // Browse categories
    await page.click('text=Breakfast');

    // Add item to cart
    await page.click('[data-testid="menu-item-1"]');
    await page.click('text=Add to Order');

    // Navigate to checkout
    await page.click('text=Checkout');

    // Fill checkout form
    await page.fill('[name="name"]', 'John Doe');
    await page.fill('[name="email"]', 'john@example.com');

    // Place order
    await page.click('text=Place Order');

    // Verify order confirmation
    await expect(page.locator('text=Thank you!')).toBeVisible();
  });
});
```

### Integration Test Example

```python
# tests/integration/test_orders.py
import pytest
from pronto_shared.db import get_session
from pronto_shared.models import Order, Employee

@pytest.fixture
def test_employee():
    with get_session() as session:
        employee = Employee(
            name="Test Waiter",
            email="waiter@example.com",
            role="waiter"
        )
        session.add(employee)
        session.commit()
        yield employee
        session.delete(employee)
        session.commit()

def test_create_order(test_employee):
    with get_session() as session:
        order = Order(
            employee_id=test_employee.id,
            status="pending",
            total=100.00
        )
        session.add(order)
        session.commit()
        
        assert order.id is not None
        assert order.status == "pending"
```

### Unit Test Example

```python
# unit/test_models.py
import pytest
from pronto_shared.models import Employee

def test_employee_creation():
    employee = Employee(
        name="Test User",
        email="test@example.com",
        role="waiter"
    )
    assert employee.name == "Test User"
    assert employee.email == "test@example.com"
    assert employee.role == "waiter"

def test_employee_validation():
    with pytest.raises(ValueError):
        Employee(
            name="",
            email="test@example.com",
            role="waiter"
        )
```

## Coverage

### Coverage Targets

- **Line Coverage:** 80%+
- **Branch Coverage:** 75%+
- **Function Coverage:** 85%+

### Generate Coverage Report

```bash
# Generate HTML coverage report
pytest --cov=src --cov-report=html

# Generate JSON coverage report
pytest --cov=src --cov-report=json

# Generate XML coverage report
pytest --cov=src --cov-report=xml
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm install
      
      - name: Install Playwright browsers
        run: npx playwright install --with-deps
      
      - name: Run tests
        run: npm test
      
      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: test-results
          path: test-results/
```

## Troubleshooting

### Common Issues

#### Tests Timing Out
```bash
# Increase timeout
# playwright.config.ts
timeout: 60000

# Or run with increased timeout
npx playwright test --timeout=60000
```

#### Browser Not Found
```bash
# Install Playwright browsers
npx playwright install

# Install specific browser
npx playwright install chromium
```

#### Database Connection Failed
```bash
# Start test database
docker-compose -f docker-compose.test.yml up -d postgres

# Verify connection
psql -h localhost -U pronto -d pronto_test
```

#### Tests Flaky
```bash
# Increase retries
# playwright.config.ts
retries: 3

# Run tests in serial
npx playwright test --workers=1
```

## Best Practices

### Test Writing
- Write descriptive test names
- Use page object model for E2E tests
- Mock external dependencies in unit tests
- Use fixtures for test data
- Keep tests independent

### E2E Testing
- Use data-testid attributes for selectors
- Wait for elements to be visible
- Handle loading states
- Test across multiple browsers
- Use realistic test data

### Integration Testing
- Test happy path and edge cases
- Test error handling
- Verify database state
- Test API contracts
- Mock external services

### Unit Testing
- Test in isolation
- Mock dependencies
- Use descriptive assertions
- Test boundary conditions
- Test error cases

## Maintenance

### Regular Tasks

#### Daily
- Monitor test results
- Review test failures
- Update test data as needed

#### Weekly
- Review test coverage
- Update flaky tests
- Refactor test utilities

#### Monthly
- Review and update test cases
- Update Playwright version
- Review test data freshness
- Audit test documentation

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [QA Test Guide](../QA_TEST_GUIDE.md)
- [Pronto-Client](../pronto-clients/)
- [Pronto-Employees](../pronto-employees/)
- [Pronto-API](../pronto-api/)

## Contact

For questions or issues related to pronto-tests, please refer to main project documentation or contact development team.
