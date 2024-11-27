#!/bin/bash
set -xe
cd "$(dirname "$0")"

if docker compose version &>/dev/null; then
  DOCKER_COMPOSE_CMD="docker compose"
else
  DOCKER_COMPOSE_CMD="docker-compose"
fi

$DOCKER_COMPOSE_CMD down --remove-orphans
sudo rm -rf ./out

$DOCKER_COMPOSE_CMD run vault
$DOCKER_COMPOSE_CMD down --remove-orphans
sudo chown -R "$(id -u):$(id -g)" ./out
sudo chmod -R 755 ./out