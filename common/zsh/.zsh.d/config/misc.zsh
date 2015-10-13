# -*- mode: shell-script -*-

###
### z.sh
###

source ~/local/bin/z-zsh/z.sh

function precmd () {
    z --add "$(pwd -P)"
}


