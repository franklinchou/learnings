# Redis

- Deleting multiple keys from Redis = `redis-cli KEYS "<pattern>" | xargs redis-cli DEL`
- Getting memory usage of a key = `MEMORY USAGE <key>`
