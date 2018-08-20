# -*- coding: utf-8 -*-

#
###
### Powerline
###

if type -p powerline > /dev/null; then
    source $(pip show powerline-status | pcregrep -o '(?<=^Location: ).*$')/powerline/bindings/zsh/powerline.zsh
    PS1=$(printf '%s\n%s' "$PS1" '$ ')
fi
