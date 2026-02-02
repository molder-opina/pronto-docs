# Pronto-Redis Documentation

## Overview

Pronto-Redis provides Redis caching service for the Pronto platform. It offers high-performance in-memory data storage for session management, caching, and real-time features.

**Port:** 6379
**Version:** Redis 7.x
**Deployment:** Docker

## Architecture

### Core Components

```
pronto-redis/
├── .git/                     # Git repository
└── Makefile                  # Build and deployment commands
```

## Quick Start

### Using Makefile

```bash
cd pronto-redis
make help           # List all available commands
make start          # Start Redis container
make stop           # Stop Redis container
make restart        # Restart Redis container
make logs           # View Redis logs
make shell          # Connect to Redis CLI
```

### Using Docker

```bash
# Start Redis
docker run -d --name pronto-redis -p 6379:6379 redis:7-alpine

# Connect to Redis CLI
docker exec -it pronto-redis redis-cli
```

## Configuration

### Environment Variables

```bash
# Redis Configuration
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_DB=0
REDIS_PASSWORD=

# Connection Pool
REDIS_MAX_CONNECTIONS=50
REDIS_SOCKET_TIMEOUT=5
REDIS_SOCKET_CONNECT_TIMEOUT=5
```

## Usage

### Connection Examples

#### Python (redis-py)
```python
import redis

# Connect to Redis
r = redis.Redis(
    host='localhost',
    port=6379,
    db=0,
    decode_responses=True
)

# Set value
r.set('key', 'value')

# Get value
value = r.get('key')

# Delete key
r.delete('key')
```

#### Flask Session Storage
```python
from flask import Flask
from flask_session import Session
import redis

app = Flask(__name__)
app.config['SESSION_TYPE'] = 'redis'
app.config['SESSION_REDIS'] = redis.from_url('redis://localhost:6379')
Session(app)
```

## Data Structures

### String
```bash
SET key value
GET key
DEL key
```

### Hash
```bash
HSET user:1 name "John Doe"
HGET user:1 name
HGETALL user:1
```

### List
```bash
LPUSH orders "order:123"
LRANGE orders 0 -1
```

### Set
```bash
SADD tags "restaurant" "food"
SMEMBERS tags
```

### Sorted Set
```bash
ZADD leaderboard 100 "player1"
ZRANGE leaderboard 0 -1 WITHSCORES
```

## Caching Patterns

### Simple Cache
```python
def get_with_cache(key, fetch_func, ttl=3600):
    cached = r.get(key)
    if cached:
        return cached
    value = fetch_func()
    r.setex(key, ttl, value)
    return value
```

### Session Cache
```python
# Store session data
r.setex(f'session:{session_id}', 3600, json.dumps(session_data))

# Retrieve session
session_data = json.loads(r.get(f'session:{session_id}'))
```

### Menu Cache
```python
# Cache menu for 5 minutes
menu_key = 'menu:full'
if not r.exists(menu_key):
    menu = fetch_menu_from_db()
    r.setex(menu_key, 300, json.dumps(menu))
menu = json.loads(r.get(menu_key))
```

## Performance Tuning

### Memory Management
```bash
# Set maximum memory
CONFIG SET maxmemory 256mb

# Set eviction policy
CONFIG SET maxmemory-policy allkeys-lru
```

### Persistence
```bash
# Enable AOF persistence
CONFIG SET appendonly yes

# Set AOF rewrite policy
CONFIG SET auto-aof-rewrite-percentage 100
```

## Monitoring

### Redis Info
```bash
# Get server information
INFO

# Get memory usage
INFO memory

# Get statistics
INFO stats
```

### Slow Query Log
```bash
# Enable slow query log
CONFIG SET slowlog-log-slower-than 10000

# View slow queries
SLOWLOG GET
```

### Monitor Commands
```bash
# Monitor all commands in real-time
MONITOR
```

## Data Management

### Backup
```bash
# Create RDB snapshot
BGSAVE

# Save to file
SAVE
```

### Restore
```bash
# Restore from RDB file
# Copy RDB file to Redis data directory and restart container
```

### Flush Database
```bash
# Flush current database
FLUSHDB

# Flush all databases
FLUSHALL
```

## Security

### Authentication
```bash
# Set password in redis.conf
requirepass your_strong_password

# Authenticate in CLI
AUTH your_strong_password
```

### Network Security
```bash
# Bind to specific interface
bind 127.0.0.1

# Disable dangerous commands
CONFIG SET rename-command FLUSHDB ""
CONFIG SET rename-command FLUSHALL ""
```

## Troubleshooting

### Common Issues

#### Out of Memory
```bash
# Check memory usage
INFO memory

# Check eviction stats
INFO stats | grep evicted

# Increase maxmemory
CONFIG SET maxmemory 512mb
```

#### Connection Refused
```bash
# Check if Redis is running
docker ps | grep redis

# Check Redis logs
docker logs pronto-redis

# Test connection
redis-cli ping
```

#### Slow Performance
```bash
# Check slow query log
SLOWLOG GET

# Check memory usage
INFO memory

# Optimize queries
# - Use appropriate data structures
# - Implement caching
# - Use pipelining for batch operations
```

## Best Practices

### Caching
- Set appropriate TTL values
- Use meaningful key names with prefixes
- Cache frequently accessed data
- Implement cache invalidation strategy
- Monitor cache hit/miss ratio

### Data Modeling
- Choose appropriate data structures
- Use hashes for related fields
- Use sorted sets for rankings
- Use lists for queues
- Use sets for unique collections

### Performance
- Use connection pooling
- Enable pipelining for batch operations
- Monitor memory usage
- Set appropriate maxmemory and eviction policy
- Use compression for large values

### Security
- Enable authentication in production
- Disable dangerous commands
- Restrict network access
- Use TLS for network communication
- Regularly backup data

## Maintenance

### Daily Tasks
- Monitor memory usage
- Check slow query log
- Review connection statistics

### Weekly Tasks
- Review cache hit/miss ratio
- Check eviction statistics
- Review memory fragmentation

### Monthly Tasks
- Update Redis version if needed
- Review and update security settings
- Test backup and restore procedures

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [Environment Variables](../ENVIRONMENT_VARIABLES.md)
- [Pronto-Clients](../pronto-clients/)
- [Pronto-Employees](../pronto-employees/)
- [Pronto-API](../pronto-api/)

## Contact

For questions or issues related to pronto-redis, please refer to main project documentation or contact development team.
