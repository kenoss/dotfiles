#
###
### peco tmux
###

function peco-tmux-select-window () {
    local current=$(tmux list-windows | grep active | cut -d: -f 1)
    local n=$(tmux list-window | peco --initial-index $current | cut -d: -f 1)
    if [ -n "$n" ]; then
        tmux select-window -t $n
    fi
}

zle -N peco-tmux-select-window
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
