#!/bin/sh

echo "uid="$(id -u) > .env
echo "home="$HOME >> .env

mkdir -p backup/virtual_hosts
sudo docker-compose -f docker-compose-with_params.yml $@