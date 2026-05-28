#!/bin/bash

echo "Updating all containers"

cd ~/homelab-git || exit

docker compose --env-file .env -f compose/docker-compose.yml pull

docker compose --env-file .env -f compose/docker-compose.yml up -d

docker image prune -f

echo "Update complete"

