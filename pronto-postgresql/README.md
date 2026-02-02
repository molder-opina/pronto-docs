# Pronto-PostgreSQL Documentation

## Overview

Pronto-PostgreSQL is PostgreSQL 13 database service for the Pronto platform. It provides persistent data storage for all applications (pronto-clients, pronto-employees, pronto-api).

**Port:** 5432
**Version:** PostgreSQL 13
**Deployment:** Docker Compose

## Architecture

### Core Components

```
pronto-postgresql/
├── .env.example               # Environment variables template
├── .env                       # Environment variables (not committed)
├── .gitignore                 # Git ignore file
├── postgres_data/             # PostgreSQL data volume
├── README.md                  # This file
└── .git/                     # Git repository
```

## Configuration

### Environment Variables

Copy `.env.example` to `.env` and customize:

```bash
cp .env.example .env
```

#### PostgreSQL Configuration
```bash
# For local development (Docker Compose network):
POSTGRES_HOST=pronto-postgres
POSTGRES_PORT=5432
POSTGRES_USER=pronto
POSTGRES_PASSWORD=pronto123
POSTGRES_DB=pronto
POSTGRES_SSLMODE=disable

# For local macOS/Linux (localhost with trust auth):
POSTGRES_HOST=127.0.0.1
POSTGRES_PORT=5432
POSTGRES_USER=pronto
POSTGRES_PASSWORD=
POSTGRES_DB=pronto
POSTGRES_SSLMODE=disable
```

#### Application Settings
```bash
DEBUG_MODE=true
LOG_LEVEL=INFO
```

#### Security Configuration
```bash
# Required for seed script (development only)
SECRET_KEY=lhlJHWqUOdYUveqkzz6nClgGpzheVFuxd5bRWJBNVEA
HANDOFF_PEPPER=YW5vdGhlci1zZWN1cmUtcGVwcGVyLWZvci1oYW5kb2ZmLXRva2Vu
PASSWORD_HASH_SALT=AUILydszwFkPNU0s6NlNFKvDB0DcA0dlp3Kan99q2ZY
CUSTOMER_DATA_KEY=c3VwcGxlLW1vcmUtZGF0YS1lbmNyeXB0aW9uLWtleS1mb3ItY3VzdG9tZXI
```

#### Restaurant Settings
```bash
RESTAURANT_NAME="Cafetería de Prueba"
TAX_RATE=0.16
```

#### Seed Password
```bash
SEED_EMPLOYEE_PASSWORD=ChangeMe!123
```

## Quick Start

### Using Docker Compose

1. **Copy environment file:**
```bash
cp .env.example .env
```

2. **Edit .env** with your configuration

3. **Start PostgreSQL:**
```bash
cd pronto-postgresql
docker-compose up -d
```

4. **Verify database is running:**
```bash
docker-compose ps
docker-compose logs postgres
```

5. **Connect to database:**
```bash
docker-compose exec postgres psql -U pronto -d pronto
```

## Database Schema

### Core Tables

#### Authentication & Authorization
- `employees` - Employee accounts and credentials
- `roles` - Role definitions
- `permissions` - Permission definitions
- `role_permissions` - Role-permission mapping

#### Customers & Sessions
- `customers` - Customer information
- `dining_sessions` - Dining session management

#### Orders
- `orders` - Order data
- `order_items` - Order items
- `order_item_modifiers` - Order item modifiers

#### Menu
- `menu_categories` - Menu categories
- `menu_items` - Menu items
- `modifiers` - Item modifiers

#### Table & Area Management
- `tables` - Table information
- `areas` - Area/zone definitions
- `day_periods` - Day period configuration

#### Payments
- `payments` - Payment transactions

#### Promotions & Discounts
- `promotions` - Promotions
- `discount_codes` - Discount codes

#### Feedback
- `feedback` - Customer feedback

#### Business Configuration
- `business_info` - Business information
- `settings` - Application settings

#### Other
- `waiter_calls` - Waiter call requests
- `table_assignments` - Table-employee assignments
- `notifications` - Notification logs

## Database Operations

### Connect to Database

#### From Docker Compose
```bash
docker-compose exec postgres psql -U pronto -d pronto
```

#### From Local Machine
```bash
psql -h 127.0.0.1 -p 5432 -U pronto -d pronto
```

### Common Queries

#### List Tables
```sql
\dt
```

#### Describe Table
```sql
\d orders
```

#### Query Data
```sql
SELECT * FROM orders LIMIT 10;
```

#### Count Records
```sql
SELECT COUNT(*) FROM orders;
```

### Backup & Restore

#### Backup Database
```bash
# Backup to SQL file
docker-compose exec postgres pg_dump -U pronto pronto > backup.sql

# Backup with compression
docker-compose exec postgres pg_dump -U pronto pronto | gzip > backup.sql.gz
```

#### Restore Database
```bash
# Restore from SQL file
cat backup.sql | docker-compose exec -T postgres psql -U pronto pronto

# Restore from compressed file
gunzip -c backup.sql.gz | docker-compose exec -T postgres psql -U pronto pronto
```

### Database Maintenance

#### Vacuum Database
```bash
docker-compose exec postgres psql -U pronto -d pronto -c "VACUUM ANALYZE;"
```

#### Reindex Database
```bash
docker-compose exec postgres psql -U pronto -d pronto -c "REINDEX DATABASE pronto;"
```

#### Check Database Size
```sql
SELECT pg_size_pretty(pg_database_size('pronto'));
```

## Data Management

### Seed Data

Seed data is loaded by applications (pronto-clients, pronto-employees) on startup when `LOAD_SEED_DATA=true`:

```bash
LOAD_SEED_DATA=true
```

Seed data includes:
- Default roles (waiter, chef, cashier, admin, system)
- Default permissions
- Default business settings
- Default menu categories
- Default day periods
- Default areas
- Default business information

### Migrations

Database migrations are managed by Alembic through applications:

```bash
# Create new migration
alembic revision --autogenerate -m "description"

# Apply migrations
alembic upgrade head

# Rollback migration
alembic downgrade -1

# View migration history
alembic history
```

## Performance Tuning

### Connection Pooling

Applications use SQLAlchemy connection pooling. Adjust pool size in application configuration:

```python
SQLALCHEMY_POOL_SIZE=20
SQLALCHEMY_MAX_OVERFLOW=10
SQLALCHEMY_POOL_TIMEOUT=30
SQLALCHEMY_POOL_RECYCLE=3600
```

### Indexing

Important indexes:
- Primary keys on all tables
- Foreign key indexes
- Unique indexes on email, phone, session_id
- Composite indexes on frequently queried columns

### Query Optimization

#### Use EXPLAIN ANALYZE
```sql
EXPLAIN ANALYZE SELECT * FROM orders WHERE status = 'pending';
```

#### Check Slow Queries
```sql
SELECT * FROM pg_stat_statements ORDER BY mean_exec_time DESC LIMIT 10;
```

## Monitoring

### Health Checks

#### Check Database Connection
```bash
docker-compose exec postgres pg_isready -U pronto
```

#### Check Database Size
```sql
SELECT pg_size_pretty(pg_database_size('pronto'));
```

#### Check Table Sizes
```sql
SELECT 
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

### Logging

#### View PostgreSQL Logs
```bash
docker-compose logs postgres
```

#### View Recent Logs
```bash
docker-compose logs --tail=100 postgres
```

## Security

### Authentication

#### Change Default Password
```sql
ALTER USER pronto WITH PASSWORD 'new_secure_password';
```

#### Create Read-Only User
```sql
CREATE USER pronto_readonly WITH PASSWORD 'password';
GRANT CONNECT ON DATABASE pronto TO pronto_readonly;
GRANT USAGE ON SCHEMA public TO pronto_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO pronto_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO pronto_readonly;
```

### Network Security

#### Restrict Access
By default, PostgreSQL is accessible only within Docker network. To restrict further:

```yaml
# docker-compose.yml
services:
  postgres:
    ports:
      - "127.0.0.1:5432:5432"  # Bind to localhost only
```

### SSL/TLS

#### Enable SSL
```bash
POSTGRES_SSLMODE=require
```

## Backup Strategy

### Automated Backups

Set up automated backups using cron:

```bash
# Daily backup at 2 AM
0 2 * * * cd /path/to/pronto-postgresql && docker-compose exec postgres pg_dump -U pronto pronto | gzip > backups/backup_$(date +\%Y\%m\%d).sql.gz
```

### Backup Rotation

Keep backups for 7 days, 4 weeks, and 12 months:

```bash
# Daily backups (last 7 days)
# Weekly backups (last 4 weeks)
# Monthly backups (last 12 months)
```

## Troubleshooting

### Common Issues

#### Database Won't Start
```bash
# Check logs
docker-compose logs postgres

# Check disk space
df -h

# Restart database
docker-compose restart postgres
```

#### Connection Refused
```bash
# Check if database is running
docker-compose ps

# Check port is accessible
telnet 127.0.0.1 5432

# Check PostgreSQL logs
docker-compose logs postgres
```

#### Database Locked
```bash
# Check for locks
docker-compose exec postgres psql -U pronto -d pronto -c "SELECT * FROM pg_stat_activity WHERE datname = 'pronto';"

# Kill long-running queries
docker-compose exec postgres psql -U pronto -d pronto -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'pronto' AND state = 'active' AND query_start < now() - interval '5 minutes';"
```

#### Out of Disk Space
```bash
# Check disk usage
df -h

# Clean up old backups
find backups/ -name "*.sql.gz" -mtime +30 -delete

# Vacuum database
docker-compose exec postgres psql -U pronto -d pronto -c "VACUUM FULL;"
```

## Best Practices

### Development
- Use Docker Compose for local development
- Keep .env file out of version control
- Use strong passwords
- Regularly backup database
- Test restore procedures

### Production
- Enable SSL/TLS
- Restrict network access
- Monitor database performance
- Set up automated backups
- Regularly test backup restores
- Use read replicas for read-heavy workloads

### Security
- Never use default passwords in production
- Use environment variables for credentials
- Restrict database access to trusted networks
- Enable query logging for audit
- Regularly update PostgreSQL version
- Use connection pooling

## Maintenance

### Daily Tasks
- Monitor database performance
- Check available disk space
- Review slow query logs

### Weekly Tasks
- Review database size growth
- Check for table bloat
- Review connection pool utilization
- Test backup restore procedure

### Monthly Tasks
- Review and optimize indexes
- Update PostgreSQL if needed
- Review security settings
- Audit database access logs

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [Environment Variables](../ENVIRONMENT_VARIABLES.md)
- [Pronto-Clients](../pronto-clients/)
- [Pronto-Employees](../pronto-employees/)
- [Pronto-API](../pronto-api/)
- [Pronto-Shared](../pronto-libs/)

## Contact

For questions or issues related to pronto-postgresql, please refer to main project documentation or contact development team.
