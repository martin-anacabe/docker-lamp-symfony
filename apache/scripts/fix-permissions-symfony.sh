#!/bin/bash

echo "Setting up or Fixing File Permissions"
HTTPDUSER=`ps aux | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1`

if [ -f "app/console" ];
then
    setfacl -R -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX app/cache app/logs
    setfacl -dR -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX app/cache app/logs
else
    setfacl -R -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX var
    setfacl -dR -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX var

fi

