#!/bin/bash

useradd -g users -G sudo -u 1000 -s /bin/bash -d $PWD docker
echo "docker:docker" | chpasswd

if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi

echo "alias bower='bower --allow-root'" > /root/.bash_aliases
source /root/.bash_aliases

exec supervisord -n
