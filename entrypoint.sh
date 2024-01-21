#!/bin/bash
database_exists() {
    psql -U $POSTGRES_USER -h $POSTGRES_HOST -p $POSTGRES_PORT -tAl | grep -qw $DATABASE_NAME
}

export PGPASSWORD=$POSTGRES_PASSWORD

# Wait until Postgres is ready
echo "Testing if Postgres service at host:$POSTGRES_HOST is accepting connections."
while ! pg_isready -q -U $POSTGRES_USER -h $POSTGRES_HOST -p $POSTGRES_PORT 
do
    echo "$(date) - waiting for database to start"
    sleep 2
done 

echo "Connection to  host:{$POSTGRES_HOST} accepted!"

if database_exists; then
    echo "Database '$DATABASE_NAME' already exists."
else
    echo "Database '$DATABASE_NAME' doesn't exist. Creating..."
    psql -U $POSTGRES_USER -h $POSTGRES_HOST -p $POSTGRES_PORT -c "CREATE DATABASE \"$DATABASE_NAME\""
    echo "Database '$DATABASE_NAME' created."
fi

exec "$@"