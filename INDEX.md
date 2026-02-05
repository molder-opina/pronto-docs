# Pronto Platform Documentation Index

## Overview

This index provides a comprehensive overview of all Pronto platform documentation. Each project has its own dedicated documentation folder with detailed information about architecture, usage, deployment, and maintenance.

## Documentation Structure

```
pronto-docs/
├── ARCHITECTURE_OVERVIEW.md       # Overall system architecture
├── estructura-directorios.md         # Directory structure reference
├── estructura-routes-api.md         # API routes documentation
├── ENVIRONMENT_VARIABLES.md          # Environment variables guide
├── LOGGING_STANDARD.md               # Logging standard
├── pronto-clients/                  # Client application docs
├── pronto-employees/                # Employee application docs
├── pronto-api/                      # API gateway docs
├── pronto-libs/                     # Shared library docs
├── pronto-postgresql/               # Database service docs
├── pronto-redis/                    # Cache service docs
├── pronto-scripts/                  # Utility scripts docs
├── pronto-static/                   # Static assets docs
├── pronto-tests/                    # Testing framework docs
└── pronto-backups/                  # Backup system docs
```

## Project Documentation

### 1. Pronto-Clients

**Port:** 6080
**Purpose:** Customer-facing application for menu browsing, ordering, and checkout

**Documentation:**
- [Full Documentation](pronto-clients/README.md)

**Key Features:**
- Menu browsing and filtering
- Cart management and checkout
- Payment processing (Stripe, Cash)
- Order tracking and status updates
- Feedback system
- Waiter call functionality

**Technologies:**
- Flask (Python)
- TypeScript/Vite (Frontend)
- JWT authentication
- PostgreSQL database

### 2. Pronto-Employees

**Port:** 6081
**Purpose:** Employee dashboard for waiters, chefs, cashiers, and administrators

**Documentation:**
- [Full Documentation](pronto-employees/README.md)

**Key Features:**
- Multi-role console selector
- Order management and processing
- Menu management
- Employee management
- Table assignments
- Analytics and reporting
- Business settings

**Role Consoles:**
- Waiter Console - Table service and order taking
- Chef Console - Kitchen order management
- Cashier Console - Payment processing
- Admin Console - Full system administration
- System Console - System administration and maintenance

**Technologies:**
- Flask (Python)
- TypeScript/Vite (Frontend)
- JWT authentication with RBAC
- PostgreSQL database

### 3. Pronto-API

**Port:** 6082
**Purpose:** Unified API gateway and core service

**Documentation:**
- [Full Documentation](pronto-api/README.md)

**Key Features:**
- Centralized API endpoint
- JWT authentication middleware
- CORS management
- Health checks
- Error handling

**Technologies:**
- Flask (Python)
- pronto-shared library

### 4. Pronto-Shared Library

**Version:** 1.0.0
**Purpose:** Shared components, models, and services for all Pronto applications

**Documentation:**
- [Full Documentation](pronto-libs/README.md)

**Key Components:**
- SQLAlchemy models
- Business logic services
- JWT authentication
- Permissions system
- Database connection management
- Error handling
- Logging configuration

**Services:**
- Order service
- Menu service
- Employee service
- Feedback service
- Payment services
- Analytics service
- Report generation

**Technologies:**
- Python 3.11+
- SQLAlchemy ORM
- PyJWT
- Pydantic

### 5. Pronto-PostgreSQL

**Port:** 5432
**Version:** PostgreSQL 16
**Purpose:** Persistent data storage for the platform

**Documentation:**
- [Full Documentation](pronto-postgresql/README.md)

**Key Features:**
- Relational database schema
- Data persistence
- Transaction support
- Data integrity constraints

**Key Tables:**
- Authentication (employees, roles, permissions)
- Customers & Sessions
- Orders & Items
- Menu (categories, items, modifiers)
- Tables & Areas
- Payments
- Promotions & Discounts
- Feedback
- Business configuration

**Technologies:**
- PostgreSQL 16
- Docker Compose
- Alembic migrations

### 6. Pronto-Redis

**Port:** 6379
**Purpose:** In-memory caching and session management

**Documentation:**
- [Full Documentation](pronto-redis/README.md)

**Key Features:**
- Session caching
- Menu caching
- Real-time data storage
- Performance optimization

**Use Cases:**
- Session storage
- Menu caching
- Rate limiting
- Real-time features
- Temporary data storage

**Technologies:**
- Redis 7.x
- Docker

### 7. Pronto-Scripts

**Purpose:** Utility scripts and deployment tools

**Documentation:**
- [Full Documentation](pronto-scripts/README.md)

**Key Scripts:**
- Service start/stop/rebuild
- Database backup/restore
- Deployment scripts
- Test runners
- Maintenance scripts

**Categories:**
- Development scripts
- Database scripts
- Deployment scripts
- Testing scripts

**Platform:**
- Bash shell scripts
- Linux/macOS compatible

### 8. Pronto-Static

**Port:** 9088
**Purpose:** Static asset hosting and frontend build

**Documentation:**
- [Full Documentation](pronto-static/README.md)

**Key Features:**
- CSS optimization
- JavaScript bundling
- Image optimization
- Asset caching
- Nginx serving

**Build Targets:**
- Employees App (dashboard, base)
- Clients App (base, menu, thank-you)

**Asset Organization:**
- Client-specific CSS modules
- Employee-specific CSS modules
- Component styles
- Utility styles
- JavaScript bundles
- Static images

**Technologies:**
- Nginx
- Vite
- Vue.js
- TypeScript

### 9. Pronto-Tests

**Purpose:** Comprehensive testing framework

**Documentation:**
- [Full Documentation](pronto-tests/README.md)

**Test Types:**
- **Unit Tests** - Individual component tests
- **Integration Tests** - Service interaction tests
- **E2E Tests** - Full user flow tests

**Test Categories:**
- Customer flow tests
- Employee flow tests
- Admin flow tests
- Payment flow tests
- API integration tests
- Performance tests

**Test Frameworks:**
- Playwright (E2E)
- pytest (unit/integration)

**Coverage:**
- Line coverage: 80%+
- Branch coverage: 75%+
- Function coverage: 85%+

### 10. Pronto-Backups

**Purpose:** Automated backup and disaster recovery

**Documentation:**
- [Full Documentation](pronto-backups/README.md)

**Key Features:**
- Full system backups
- Database backups
- Redis data backups
- Static asset backups
- Configuration backups

**Backup Format:**
- Compressed tar.gz archives
- Named with timestamp
- Includes all system data

**Backup Contents:**
- PostgreSQL data
- Redis data
- Static assets
- Application configurations
- Docker volumes

**Backup Strategy:**
- Daily automated backups
- Weekly full backups
- Monthly archival
- Off-site storage support

## General Documentation

### Architecture Overview
- **File:** ARCHITECTURE_OVERVIEW.md
- **Content:** Overall system architecture, component overview, and data flow

### Directory Structure
- **File:** estructura-directorios.md
- **Content:** Detailed directory structure for all Pronto applications

### API Routes
- **File:** estructura-routes-api.md
- **Content:** Complete API endpoint documentation

### Environment Variables
- **File:** ENVIRONMENT_VARIABLES.md
- **Content:** Comprehensive environment variable reference

### Logging Standard
- **File:** LOGGING_STANDARD.md
- **Content:** Standardized logging format and practices

## Getting Started

### Quick Start Guide

1. **Clone the repository:**
```bash
git clone https://github.com/your-org/pronto-docs.git
cd pronto-docs
```

2. **Choose your project:**
```bash
cd pronto-clients/  # For customer application
cd pronto-employees/ # For employee application
# etc.
```

3. **Read the documentation:**
- Each project has its own README.md with detailed information
- Follow installation and setup instructions
- Refer to troubleshooting section if needed

### Development Workflow

1. **Setup:**
   - Install dependencies for your chosen project
   - Configure environment variables
   - Start required services (PostgreSQL, Redis)

2. **Development:**
   - Run the development server
   - Make changes
   - Test your changes

3. **Testing:**
   - Run unit tests
   - Run integration tests
   - Run E2E tests

4. **Deployment:**
   - Follow deployment instructions in project docs
   - Use pronto-scripts for deployment automation

## Architecture Diagram

```
┌─────────────────┐
│  Pronto-Clients │  (Port 6080)
│  Customer App   │
└────────┬────────┘
         │
         ├─────────────────────┐
         │                     │
┌────────▼────────┐   ┌──────▼──────────┐
│ Pronto-API     │   │ Pronto-PostgreSQL│
│ Gateway (6082) │◄──┤ Database (5432) │
└───────┬────────┘   └─────────────────┘
        │
        ├─────────────────────┐
        │                     │
┌───────▼─────────┐   ┌───▼───────────┐
│ Pronto-Employees │   │ Pronto-Redis   │
│ Dashboard (6081)│   │ Cache (6379)  │
└───────┬─────────┘   └────────────────┘
        │
        ├─────────────────────┐
        │                     │
┌───────▼─────────┐   ┌───▼───────────┐
│ Pronto-Static   │   │ Pronto-Backups │
│ Assets (9088)  │   │ Backup System  │
└─────────────────┘   └────────────────┘

┌─────────────────┐
│ Pronto-Shared  │
│  Library       │
└─────────────────┘

┌─────────────────┐
│ Pronto-Scripts │
│  Utilities     │
└─────────────────┘

┌─────────────────┐
│ Pronto-Tests   │
│  Testing       │
└─────────────────┘
```

## Technology Stack

### Backend
- **Python 3.11+** - Primary backend language
- **Flask** - Web framework
- **SQLAlchemy** - ORM
- **Alembic** - Database migrations
- **PyJWT** - JWT authentication
- **Redis** - Caching and sessions

### Frontend
- **TypeScript** - Type-safe JavaScript
- **Vue.js 3.5+** - Frontend framework
- **Vite** - Build tool
- **Nginx** - Static asset serving

### Database
- **PostgreSQL 16** - Primary database
- **Redis 7.x** - Cache and sessions

### Testing
- **Playwright** - E2E testing
- **pytest** - Unit and integration testing
- **Coverage:** pytest-cov

### Deployment
- **Docker** - Containerization
- **Docker Compose** - Orchestration
- **Bash Scripts** - Automation

## Support and Contributing

### Getting Help
- Check project-specific documentation first
- Review troubleshooting sections
- Check common issues and solutions
- Refer to related documentation

### Contributing
- Follow code standards in each project
- Write tests for new features
- Update documentation
- Follow PR guidelines

### Contact
- For questions or issues, refer to the main project documentation
- Contact the development team for platform-level issues
