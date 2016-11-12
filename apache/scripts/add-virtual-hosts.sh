#!/bin/sh

sudo cp /virtual_hosts/*.conf /etc/apache2/sites-available/

for site in $(ls /etc/apache2/sites-available/*.conf)
do
    site=$(basename $site)
    sudo a2ensite "$site"
done

sudo supervisorctl restart apache2
