# Docker LAMP-SYMFONY
This package features an image precompiled of phusion/baseimage:0.9.22 with apache 2.4 and php5.6, and two extra containers with *mysql* and *phpmyadmin*.

## Contents of the package
This package contains a couple of scripts and support binaries to improve your container management.

### Binaries
- composer
- phpunit
- symfony installer

### Scripts
- **docker-compose.sh**: it saves two variables into an .env file to be used inside the `docker-compose-override.yml` file to use with `docker-compose`. This script is made to be used just as the `docker-compose` binary, making easier its use.
- **add-virtual-hosts.sh**: copies and activates `*.conf` files mapped in `/virtual_hosts` inside apache, and restarts apache service.
- **install-nvm.sh**: installs Node Virtual Manager `nvm`
- **install-php-cs-fixer.sh**: Install PHP Coding Standards Fixer.
- **update-nvm.sh**: updates `nvm`.
- **fix-permissions-symfony.sh**: sets `cache` and `logs` permissions of `symfony2` or `symfony3`
