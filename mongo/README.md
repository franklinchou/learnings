# Mongo

## Finding dates in string format "yyy-mm-dd"

Find all the items in `collection` where the date field is greater than or equal to 2018-11-26:

```
db['collection'].find({'date-field': {$gte: "2018-11-26"}});
```
