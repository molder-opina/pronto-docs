# Pronto-Scripts Documentation

## Overview

Pronto-Scripts provides utility scripts and deployment tools for the Pronto platform. It includes shell scripts for development, deployment, database management, and maintenance tasks.

**Purpose:** Automation and utility scripts
**Platform:** Linux/macOS
**Shell:** Bash

## Architecture

### Core Components

```
pronto-scripts/
├── .git/                     # Git repository
├── bin/                      # Binary/executable scripts
├── postgresql/               # PostgreSQL management scripts
├── pronto-api/               # API service scripts
└── scripts/                  # General utility scripts
```

## Usage

### Development Scripts

#### Start Services
```bash
# Start all services
bin/start.sh

# Start specific service
bin/start.sh --service postgres
bin/start.sh --service api
```

#### Stop Services
```bash
# Stop all services
bin/stop.sh

# Stop specific service
bin/stop.sh --service postgres
```

#### Rebuild Services
```bash
# Rebuild all services
bin/rebuild.sh

# Rebuild specific service
bin/rebuild.sh --service clients
```

### Database Scripts

#### Database Backup
```bash
# Backup database
postgresql/backup.sh

# Backup with compression
postgresql/backup.sh --compress

# Backup to specific location
postgresql/backup.sh --output /path/to/backup
```

#### Database Restore
```bash
# Restore database
postgresql/restore.sh --input /path/to/backup.sql

# Restore from compressed backup
postgresql/restore.sh --input /path/to/backup.sql.gz
```

#### Database Maintenance
```bash
# Vacuum database
postgresql/vacuum.sh

# Reindex database
postgresql/reindex.sh

# Check database integrity
postgresql/check.sh
```

### Deployment Scripts

#### Deploy to Production
```bash
# Deploy all services
scripts/deploy.sh --environment production

# Deploy specific service
scripts/deploy.sh --service clients --environment production
```

#### Deploy to Staging
```bash
# Deploy to staging
scripts/deploy.sh --environment staging
```

### Testing Scripts

#### Run Tests
```bash
# Run all tests
scripts/test.sh

# Run specific test suite
scripts/test.sh --suite unit
scripts/test.sh --suite integration
scripts/test.sh --suite e2e
```

#### Run Tests with Coverage
```bash
# Run tests with coverage report
scripts/test.sh --coverage
```

## Available Scripts

### General Utilities

#### `bin/start.sh`
Starts services in development mode.

**Options:**
- `--service <name>` - Start specific service (all, postgres, redis, api, clients, employees)

**Example:**
```bash
bin/start.sh --service postgres
```

#### `bin/stop.sh`
Stops running services.

**Options:**
- `--service <name>` - Stop specific service

**Example:**
```bash
bin/stop.sh --service clients
```

#### `bin/rebuild.sh`
Rebuilds Docker containers.

**Options:**
- `--service <name>` - Rebuild specific service
- `--no-cache` - Rebuild without cache

**Example:**
```bash
bin/rebuild.sh --service clients --no-cache
```

### PostgreSQL Scripts

#### `postgresql/backup.sh`
Creates database backup.

**Options:**
- `--output <path>` - Output directory
- `--compress` - Compress backup

**Example:**
```bash
postgresql/backup.sh --output ./backups --compress
```

#### `postgresql/restore.sh`
Restores database from backup.

**Options:**
- `--input <path>` - Input backup file

**Example:**
```bash
postgresql/restore.sh --input ./backups/backup.sql.gz
```

#### `postgresql/migrate.sh`
Runs database migrations.

**Options:**
- `--target <version>` - Target migration version
- `--downgrade` - Rollback migration

**Example:**
```bash
postgresql/migrate.sh --target head
```

### API Scripts

#### `pronto-api/deploy.sh`
Deploys API service.

**Options:**
- `--environment <env>` - Target environment

**Example:**
```bash
pronto-api/deploy.sh --environment production
```

#### `pronto-api/health-check.sh`
Checks API health status.

**Example:**
```bash
pronto-api/health-check.sh
```

### Testing Scripts

#### `scripts/test.sh`
Runs test suites.

**Options:**
- `--suite <name>` - Test suite (unit, integration, e2e)
- `--coverage` - Generate coverage report
- `--verbose` - Verbose output

**Example:**
```bash
scripts/test.sh --suite unit --coverage
```

#### `scripts/lint.sh`
Runs code linters.

**Example:**
```bash
scripts/lint.sh
```

#### `scripts/format.sh`
Formats code.

**Example:**
```bash
scripts/format.sh
```

## Configuration

### Environment Variables

Scripts use environment variables for configuration. Create a `.env` file:

```bash
# PostgreSQL
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=pronto
POSTGRES_PASSWORD=pronto123
POSTGRES_DB=pronto

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379

# API
API_HOST=localhost
API_PORT=6082

# Applications
CLIENTS_PORT=6080
EMPLOYEES_PORT=6081

# Deployment
DEPLOYMENT_ENV=development
DEPLOYMENT_USER=deploy
DEPLOYMENT_HOST=server.example.com
DEPLOYMENT_PATH=/var/www/pronto
```

## Troubleshooting

### Common Issues

#### Script Permission Denied
```bash
# Fix permissions
chmod +x bin/*.sh
chmod +x postgresql/*.sh
chmod +x pronto-api/*.sh
```

#### Docker Not Running
```bash
# Start Docker
docker start

# Check Docker status
docker ps
```

#### Database Connection Failed
```bash
# Check PostgreSQL is running
docker ps | grep postgres

# Check database logs
docker logs pronto-postgres

# Test database connection
psql -h localhost -U pronto -d pronto
```

#### Service Won't Start
```bash
# Check service logs
docker logs pronto-clients
docker logs pronto-employees
docker logs pronto-api

# Check for port conflicts
lsof -i :6080
lsof -i :6081
lsof -i :6082
```

## Best Practices

### Script Development
- Use proper exit codes (0 for success, non-zero for failure)
- Add error handling and logging
- Make scripts idempotent where possible
- Include usage documentation
- Test scripts before deployment

### Usage
- Read script documentation before running
- Use appropriate environment variables
- Test scripts in development first
- Keep backups before destructive operations
- Monitor script execution logs

### Security
- Never hardcode credentials in scripts
- Use environment variables for sensitive data
- Restrict script permissions
- Validate inputs before processing
- Use secure file permissions

## Maintenance

### Regular Tasks

#### Daily
- Review script execution logs
- Monitor backup success/failure
- Check service health status

#### Weekly
- Review script performance
- Update scripts as needed
- Test backup/restore procedures

#### Monthly
- Review and update documentation
- Audit script permissions
- Update dependencies

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [Directory Structure](../estructura-directorios.md)
- [Deployment Steps](../DEPLOYMENT_STEPS.md)
- [Pronto-Clients](../pronto-clients/)
- [Pronto-Employees](../pronto-employees/)
- [Pronto-API](../pronto-api/)

## Contact

For questions or issues related to pronto-scripts, please refer to main project documentation or contact development team.
