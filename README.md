# Docker LAMP-SYMFONY
This package features an image of a precompiled apache ubuntu and php5.6, and two extra containers with *mysql* and *phpmyadmin*.

## Overview
- By default, the databases are saved `/backup` directory
- Map a directory where you can add different VirtualHosts for Apache. This integration is possible because apache is running under supervisor, which makes it special to restart or reload when necessary.

## Contents of the package
This package contains a couple of scripts and support binaries to improve your container management.

### Binaries
- composer
- phpunit
- symfony installer

### Scripts
- **docker-compose.sh**: it saves two variables into an .env file to be used inside the `docker-compose-with-parameters.yml` file to use with `docker-compose`. This script is made to be used just as the `docker-compose` binary, making easier its use.
- **add-virtual-hosts.sh**: copies and activates `*.conf` files mapped in `/virtual_hosts` inside apache, and restarts apache service.
- **install-npm.sh**: installs `npm`, `node 6.*`, `gulp`, `bower` and `less`.
- **update-nvm.sh**: updates `nvm`.
- **fix-permissions-symfony.sh**: sets `cache` and `logs` permissions of `symfony2` or `symfony3`
