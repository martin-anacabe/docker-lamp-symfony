#!/bin/sh

BASH_RC=$HOME/.bashrc

if [ ! -f $BASH_RC ]; then
    touch $BASH_RC
fi

if ! grep -q NVM_DIR "$BASH_RC"; then
    echo '' >> $BASH_RC
    echo 'export NVM_DIR="$HOME/.nvm"' >> $BASH_RC
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> $BASH_RC
fi

sh /bin/install-nvm.sh
. $BASH_RC