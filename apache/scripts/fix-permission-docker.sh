#!/bin/sh

if [ $UID = 0 ]; then
    UID=1000
fi

sed -i "s/\(docker:x:\)[0-9]\+/\1$UID/g" /etc/passwd
chown -R docker /var/www
