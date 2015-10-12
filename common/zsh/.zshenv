# -*- coding: utf-8 -*-

ZDOTDIR=$HOME/.zsh.d
ZCONFDIR=$ZDOTDIR/config

function load-zsh-config () {
    local file="$ZDOTDIR/$1"

    if [ ! -f "$file" ]; then
        echo "Config file not found: $file"
    else
        source "$file"
    fi
}
