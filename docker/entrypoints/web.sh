#!/bin/sh

set -x

rm -rf /app/tmp/pids/server.pid
rm -rf /app/tmp/cache/*

$(docker/entrypoints/helpers/pg_database_url.rb)
PG_READY="pg_isready -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USERNAME"

until $PG_READY
do
  sleep 2;
done

bundle install

exec "$@"