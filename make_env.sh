#!/usr/bin/env bash
set -u

cd $(dirname $0)

touch .env
grep -q "UID=" .env || echo "UID=$(id -u $USER)" >> .env
grep -q "GID=" .env || echo "GID=$(id -g $USER)" >> .env
grep -q "UNAME=" .env || echo "UNAME=$USER"  >> .env
