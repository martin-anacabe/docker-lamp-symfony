#!/bin/sh

BASH_RC=$HOME/.bashrc

composer global require friendsofphp/php-cs-fixer

if grep ".composer/vendor/bin" $BASH_RC; then
    echo "Composer vendors installed"
else
    echo "" >> $BASH_RC
    echo "export PATH=$PATH:$HOME/.composer/vendor/bin" >> $BASH_RC
fi
