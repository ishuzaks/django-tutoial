#!/usr/bin/env bash
set -u

# Generate Secret Key.
if ! grep -q "SECRET_KEY" ${PROJECT_DIR}/local_settings.py; then
    python ${PROJECT_DIR}/get_random_secret_key.py > ${PROJECT_DIR}/local_settings.py
fi 

# Wait for MySQL to start.
echo "Waiting for MySQL..."

while ! nc -z ${DB_HOST} ${DB_PORT}; do
    sleep 0.1
done

echo "MySQL started"

exec "$@"