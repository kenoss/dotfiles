#
###
### peco ghq
###

function peco-ghq () {
    local selected_dir=$(ghq list -p | peco)

    if [ -n "$selected_dir" ]; then
        BUFFER=" cd ${selected_dir}"
        zle accept-line
    fi
}

zle -N peco-ghq
