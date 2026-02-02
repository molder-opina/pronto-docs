# Pronto-Backups Documentation

## Overview

Pronto-Backups provides automated backup and recovery solutions for the entire Pronto platform. It creates compressed backups of all application data, databases, and static assets.

**Purpose:** Data backup and disaster recovery
**Backup Type:** Full system backups
**Format:** Compressed tar.gz archives

## Architecture

### Core Components

```
pronto-backups/
├── .git/                           # Git repository
├── archive/                         # Archived backups
└── pronto-app-backup-YYYYMMDD/    # Latest backup directory
```

## Backup Structure

### Backup Contents

Each backup includes:
- **PostgreSQL database** - Complete database dump
- **Redis data** - Redis dump file
- **Static assets** - Images, CSS, JavaScript
- **Application configurations** - Environment files
- **Docker volumes** - Persistent data volumes

### Backup Format

```
pronto-app-backup-YYYYMMDD/
├── postgres_data/          # PostgreSQL data directory
├── redis_data/             # Redis data directory
├── static_content/          # Static assets
├── configs/                # Application configurations
├── docker_volumes/         # Docker volume backups
└── backup_info.txt         # Backup metadata
```

## Backup Operations

### Manual Backup

```bash
# Navigate to backup directory
cd pronto-backups

# Create backup
../pronto-scripts/bin/backup.sh

# Backup to specific location
../pronto-scripts/bin/backup.sh --output /path/to/backups
```

### Automated Backup

Set up cron job for automated backups:

```bash
# Edit crontab
crontab -e

# Add daily backup at 2 AM
0 2 * * * cd /path/to/pronto-backups && /path/to/pronto-scripts/bin/backup.sh

# Add weekly backup on Sunday at 3 AM
0 3 * * 0 cd /path/to/pronto-backups && /path/to/pronto-scripts/bin/backup.sh --full
```

### Backup Naming Convention

```
pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz

Examples:
- pronto-app-backup-20260201-170521.tar.gz
- pronto-app-backup-20260201-170732.tar.gz
- pronto-app-backup-20260201-171609.tar.gz
```

## Restore Operations

### Full Restore

```bash
# Navigate to backup directory
cd pronto-backups

# Extract backup
tar -xzf pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz

# Restore PostgreSQL data
docker-compose down
cp -r pronto-app-backup-YYYYMMDD-HHMMSS/postgres_data/* ../pronto-postgresql/postgres_data/

# Restore Redis data
cp -r pronto-app-backup-YYYYMMDD-HHMMSS/redis_data/* ../pronto-redis/data/

# Restore static assets
cp -r pronto-app-backup-YYYYMMDD-HHMMSS/static_content/* ../pronto-static/src/static_content/

# Start services
docker-compose up -d
```

### Database Restore Only

```bash
# Extract backup
tar -xzf pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz

# Restore database
docker-compose exec postgres psql -U pronto -d pronto < backup.sql
```

## Backup Management

### List Backups

```bash
# List all backups
ls -lh pronto-app-backup-*.tar.gz

# List backups with date
ls -lht pronto-app-backup-*.tar.gz
```

### Backup Size Information

```bash
# Check backup size
du -sh pronto-app-backup-*.tar.gz

# Check backup contents
du -sh pronto-app-backup-YYYYMMDD-HHMMSS/
```

### Archive Old Backups

```bash
# Move backups older than 7 days to archive
find . -name "pronto-app-backup-*.tar.gz" -mtime +7 -exec mv {} archive/ \;

# Archive monthly
find . -name "pronto-app-backup-*.tar.gz" -mtime +30 -exec mv {} archive/monthly/ \;
```

### Delete Old Backups

```bash
# Delete backups older than 30 days
find . -name "pronto-app-backup-*.tar.gz" -mtime +30 -delete

# Delete backups in archive older than 1 year
find archive/ -name "pronto-app-backup-*.tar.gz" -mtime +365 -delete
```

## Backup Verification

### Verify Backup Integrity

```bash
# Check tar.gz integrity
gunzip -t pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz

# Verify contents
tar -tzf pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz
```

### Verify Backup Contents

```bash
# Extract and verify
mkdir test_restore
tar -xzf pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz -C test_restore

# Check directory structure
ls -la test_restore/pronto-app-backup-YYYYMMDD-HHMMSS/

# Clean up
rm -rf test_restore
```

### Test Restore

```bash
# Test restore on development environment
docker-compose -f docker-compose.dev.yml down
# Extract and restore backup
docker-compose -f docker-compose.dev.yml up -d
# Verify data integrity
```

## Monitoring

### Backup Monitoring

#### Check Backup Completion
```bash
# Check latest backup
ls -lht pronto-app-backup-*.tar.gz | head -1

# Verify backup timestamp
stat pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz
```

#### Monitor Backup Logs

```bash
# View backup logs
tail -f /var/log/pronto-backup.log

# Check for errors
grep ERROR /var/log/pronto-backup.log
```

#### Backup Alerts

Set up email alerts for backup failures:

```bash
# Add to backup script
if [ $? -ne 0 ]; then
    echo "Backup failed at $(date)" | mail -s "Pronto Backup Failed" admin@example.com
fi
```

## Retention Policy

### Recommended Retention

- **Daily backups:** Keep for 7 days
- **Weekly backups:** Keep for 4 weeks
- **Monthly backups:** Keep for 12 months
- **Annual backups:** Keep indefinitely

### Automated Cleanup

```bash
# Create cleanup script
cat > /path/to/cleanup-backups.sh << 'EOF'
#!/bin/bash
BACKUP_DIR="/path/to/pronto-backups"

# Keep daily backups for 7 days
find "$BACKUP_DIR" -name "pronto-app-backup-*.tar.gz" -mtime +7 -exec mv {} "$BACKUP_DIR/archive/weekly/" \;

# Keep weekly backups for 4 weeks
find "$BACKUP_DIR/archive/weekly/" -name "pronto-app-backup-*.tar.gz" -mtime +28 -exec mv {} "$BACKUP_DIR/archive/monthly/" \;

# Keep monthly backups for 12 months
find "$BACKUP_DIR/archive/monthly/" -name "pronto-app-backup-*.tar.gz" -mtime +365 -exec mv {} "$BACKUP_DIR/archive/yearly/" \;
EOF

chmod +x /path/to/cleanup-backups.sh
```

## Storage Requirements

### Backup Size Estimation

Based on current backups:
- **Daily backup:** ~300-400 MB (compressed)
- **Weekly backup:** ~350-450 MB (compressed)
- **Monthly backup:** ~400-500 MB (compressed)

### Storage Planning

For 1-year retention:
- **Daily backups (7 days):** 2.8 GB
- **Weekly backups (4 weeks):** 1.8 GB
- **Monthly backups (12 months):** 5.4 GB
- **Total:** ~10 GB

## Off-site Backup

### Cloud Storage Backup

#### AWS S3
```bash
# Install AWS CLI
pip install awscli

# Configure AWS
aws configure

# Upload backup
aws s3 cp pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz s3://pronto-backups/

# Sync backups to S3
aws s3 sync . s3://pronto-backups/ --exclude "*" --include "pronto-app-backup-*.tar.gz"
```

#### Google Cloud Storage
```bash
# Install gsutil
curl https://sdk.cloud.google.com | bash

# Upload backup
gsutil cp pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz gs://pronto-backups/

# Sync backups to GCS
gsutil -m rsync -r . gs://pronto-backups/
```

### Rsync to Remote Server

```bash
# Sync to remote server
rsync -avz --progress \
  --exclude="node_modules" \
  --exclude=".git" \
  /path/to/pronto-backups/ \
  user@remote-server:/backups/pronto/

# Archive and delete older backups
rsync -avz --progress --delete \
  /path/to/pronto-backups/ \
  user@remote-server:/backups/pronto/
```

## Disaster Recovery

### Recovery Procedures

#### Step 1: Assess Damage
```bash
# Check which services are affected
docker-compose ps

# Check logs for errors
docker-compose logs --tail=100 postgres
docker-compose logs --tail=100 redis
```

#### Step 2: Prepare for Restore
```bash
# Stop all services
docker-compose down

# Backup current state (if possible)
docker-compose down -v  # Remove volumes
mkdir emergency-backup
cp -r /var/lib/postgresql/* emergency-backup/
cp -r /var/lib/redis/* emergency-backup/
```

#### Step 3: Restore from Backup
```bash
# Extract backup
tar -xzf pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz

# Restore data
cp -r pronto-app-backup-YYYYMMDD-HHMMSS/postgres_data/* ../pronto-postgresql/postgres_data/
cp -r pronto-app-backup-YYYYMMDD-HHMMSS/redis_data/* ../pronto-redis/data/
cp -r pronto-app-backup-YYYYMMDD-HHMMSS/static_content/* ../pronto-static/src/static_content/

# Start services
docker-compose up -d
```

#### Step 4: Verify Recovery
```bash
# Check service health
docker-compose ps
curl http://localhost:6080/health
curl http://localhost:6081/health
curl http://localhost:6082/health

# Verify data integrity
docker-compose exec postgres psql -U pronto -d pronto -c "SELECT COUNT(*) FROM orders;"
```

## Troubleshooting

### Common Issues

#### Backup Fails
```bash
# Check disk space
df -h

# Check permissions
ls -la pronto-backups/

# Check available memory
free -m
```

#### Restore Fails
```bash
# Check backup integrity
gunzip -t pronto-app-backup-YYYYMMDD-HHMMSS.tar.gz

# Check disk space
df -h

# Check Docker volumes
docker volume ls
```

#### Backup Too Large
```bash
# Compress backup
gzip pronto-app-backup-YYYYMMDD-HHMMSS.tar

# Remove unnecessary files
rm pronto-app-backup-YYYYMMDD-HHMMSS/node_modules/
rm pronto-app-backup-YYYYMMDD-HHMMSS/.git/
```

## Best Practices

### Backup Strategy
- Perform daily automated backups
- Test restore procedures regularly
- Keep multiple backup versions
- Store backups off-site
- Monitor backup completion
- Verify backup integrity

### Security
- Encrypt backups at rest
- Use secure transfer protocols
- Restrict backup access
- Monitor backup access logs
- Use strong encryption keys

### Documentation
- Document backup procedures
- Document restore procedures
- Keep backup logs
- Update documentation regularly
- Train team on recovery procedures

### Testing
- Test backup regularly
- Test restore on development
- Verify data integrity
- Document test results
- Update procedures based on testing

## Maintenance

### Regular Tasks

#### Daily
- Monitor backup completion
- Check backup integrity
- Review backup logs

#### Weekly
- Review backup sizes
- Test restore procedure
- Review retention policy

#### Monthly
- Update backup procedures
- Review off-site backups
- Update documentation
- Train team on recovery

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [Deployment Steps](../DEPLOYMENT_STEPS.md)
- [Pronto-PostgreSQL](../pronto-postgresql/)
- [Pronto-Scripts](../pronto-scripts/)

## Contact

For questions or issues related to pronto-backups, please refer to main project documentation or contact development team.
