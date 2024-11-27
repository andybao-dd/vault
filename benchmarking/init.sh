#!/bin/bash
set -xe
cd "$(dirname "$0")"

echo "GIT_REV=$(git rev-parse --short HEAD)" > .env

if docker compose version &>/dev/null; then
  DOCKER_COMPOSE_CMD="docker compose"
else
  DOCKER_COMPOSE_CMD="docker-compose"
fi

$DOCKER_COMPOSE_CMD --progress=plain build
