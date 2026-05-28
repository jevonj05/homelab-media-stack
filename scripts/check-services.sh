#!/bin/bash

echo "Checking container status..."
echo

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo
echo "Disk Usage:"
df -h /mnt/storage

echo
echo "Docker Disk Usage:"
docker system df
