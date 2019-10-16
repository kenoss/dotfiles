# -*- coding: utf-8 -*-


if type -p powerline > /dev/null && ps aux | grep '[p]owerline-daemon' > /dev/null; then
    source $(pip show powerline-status | pcregrep -o '(?<=^Location: ).*$')/powerline/bindings/zsh/powerline.zsh
    PS1=$(printf '%s\n%s' "$PS1" '$ ')
fi

eval "$(starship init zsh)"


function paste-clipboard {
    local str=$(xsel -o --clipboard)

    if [ -n "$str" ]; then
        LBUFFER="$LBUFFER$str"
    fi
}

zle -N paste-clipboard



bindkey "^y" paste-clipboard



if sed --version | head -n 1 | grep GNU > /dev/null; then
    alias gsed="sed"
fi
