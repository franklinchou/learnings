# Vertica Commands

Commands unique to the Vertica analytic database platform

## Get certain type of table name

Table information is stored in `ALL_TABLES`.

```sql
SELECT *
FROM ALL_TABLES
WHERE table_name
LIKE '%processedtu%';
```
