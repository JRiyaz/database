#!/bin/bash
set -e

# pg_restore -d postgresql://[user]:[password]@[neon_hostname]/employees -Fc employees.sql.gz -c -v --no-owner --no-privileges
# docker-entrypoint-initdb.d will only work when your data dictionary is empty. So if you have volumes, be sure to delete them docker-compose down --volumes

EMPLOYEE_TABLE="employees"

# psql -U "$POSTGRES_USER" -tc "SELECT 1 FROM pg_database WHERE datname = $EMPLOYEE_TABLE" | grep -q 1 || psql -U "$POSTGRES_USER" -c "CREATE DATABASE $EMPLOYEE_TABLE"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- CREATE USER docker;

    -- Database is a collection of schemas and schema is a collection of tables. 
    -- But in MySQL they use it the same way.

    CREATE DATABASE $EMPLOYEE_TABLE;
    CREATE SCHEMA IF NOT EXISTS $EMPLOYEE_TABLE;
    -- GRANT ALL PRIVILEGES ON DATABASE my_project_development TO docker;
    -- CREATE DATABASE my_project_test;
    -- GRANT ALL PRIVILEGES ON DATABASE my_project_test TO docker;
EOSQL

# pg_restore -d postgresql://"$POSTGRES_USER":"$POSTGRES_PASSWORD"@localhost:5432/"$EMPLOYEE_TABLE" -Fc /var/lib/postgresql/employees.sql.gz -c -v --no-owner --no-privileges

# pg_restore -d postgresql://admin:admin@127.0.0.1:5432/employees -Fc "/var/lib/postgresql/employees.sql.gz" -c -v --no-owner --no-privileges
