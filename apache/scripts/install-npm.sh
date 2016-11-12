#!/bin/sh

BASH_RC=$HOME/.bashrc

if [ ! -f $BASH_RC ]; then
    touch $BASH_RC
fi

sh /bin/install-nvm.sh
. $BASH_RC

nvm install 6
npm install -g gulp bower less
