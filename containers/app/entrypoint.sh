#!/usr/bin/env bash
set -u

echo "Waiting for MySQL..."

while ! nc -z db 3306; do
    sleep 0.1
done

echo "MySQL started"

exec "$@"