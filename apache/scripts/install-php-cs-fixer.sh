#!/bin/sh

SHELL_BIN="${SHELL##*/}"  # get filename

SHELLRC="$HOME/.${SHELL_BIN}rc"

composer global require friendsofphp/php-cs-fixer

if grep ".composer/vendor/bin" $SHELLRC; then
    echo "Composer vendors installed"
else
    echo "" >> $SHELLRC
    echo "export PATH=$PATH:$HOME/.composer/vendor/bin" >> $SHELLRC
fi
