# Postgres

## Getting started

Getting a postgres prompt running usually involves first switching to the `postgres` user by issuing: `su - postgres`. 
(Neglecting to do this usually results in the following error: `FATAL: role "root" does not exist`.)

After switching users, just issue `psql` to get a postgres shell up.

## At the postgres shell

- `\l` list all databases
- `\d` list all relations
