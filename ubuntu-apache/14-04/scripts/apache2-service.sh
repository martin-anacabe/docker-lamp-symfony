#!/bin/bash

[ -d /var/lock/apache2 ] || mkdir -p /var/lock/apache2
[ -d /var/run/apache2 ]  || mkdir -p /var/run/apache2

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
