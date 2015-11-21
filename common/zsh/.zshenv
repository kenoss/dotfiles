# -*- coding: utf-8 -*-

ZDOTDIR=$HOME/.zsh.d
ZCONFDIR=$ZDOTDIR/config
# export SHELL=/opt/local/bin/zsh
if type which > /dev/null 2>&1; then
    export SHELL=$(which zsh)
else
    export SHELL=/opt/local/bin/zsh
fi

function load-zsh-config () {
    local file="$ZDOTDIR/$1"

    if [ ! -f "$file" ]; then
        echo "Config file not found: $file"
    else
        source "$file"
    fi
}
