#!/bin/sh

set -x

rm -rf /app/tmp/pids/server.pid
rm -rf /app/tmp/cache/*

PG_READY="pg_isready -h ${POSTGRES_HOST} -p ${POSTGRES_PORT} -U ${POSTGRES_USERNAME}"

until $PG_READY
do
  sleep 2;
done

BUNDLE_PATH='/gems'
bundle install
yarn install
bundle exec rake assets:precompile

exec "$@"
