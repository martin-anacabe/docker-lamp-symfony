#!/bin/sh

if [ $# -eq 0 ]; then
    echo "You must enter at least one virtual host (more separated by spaces)";
    exit;
fi

alias sudo='/usr/bin/sudo'

for virtual_host in $@
do
    PATH=/etc/apache2/ssl/${virtual_host}
    sudo mkdir -p ${PATH}

    # 1) Create your private key (any password will do, we remove it below)
    sudo openssl genrsa -des3 -out ${PATH}/apache.orig.key 2048

    # 2) Remove the password
    sudo openssl rsa -in ${PATH}/apache.orig.key -out ${PATH}/apache.key
    sudo rm ${PATH}/apache.orig.key

    # 3) Generate the csr (Certificate signing request) (Details are important!)
    sudo openssl req -new -key ${PATH}/apache.key -out ${PATH}/apache.csr

    # 4) Generate self signed ssl certificate 
    sudo openssl x509 -req -days 365 -in ${PATH}/apache.csr -signkey ${PATH}/apache.key -out ${PATH}/apache.crt
done