#!/bin/sh

echo "UID="$(id -u) > .env
echo "HOME="$HOME >> .env

mkdir -p backup/virtual_hosts
sudo docker-compose -f docker-compose.yml -f docker-compose-override.yml $@
