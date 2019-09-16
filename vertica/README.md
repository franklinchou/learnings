# Vertica Commands

Commands unique to the Vertica analytical database platform

## Get table names

Table information is stored in `ALL_TABLES`.

```sql
-- Search for all `processedtu` tables with `monthly` granularity
SELECT *
FROM ALL_TABLES
WHERE table_name
LIKE '%processedtu%_%monthly%';
```
