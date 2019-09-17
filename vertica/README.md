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
## Get column names of a certain table

```sql
SELECT * 
FROM v_catalog.columns -- This gets all the columns of all the tables in the database
WHERE table_name = '{table_name}'
AND column_name LIKE '%{column_query}%'
```
