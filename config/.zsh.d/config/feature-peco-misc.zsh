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


#
###
### peco history
###

function peco-history-select () {
    local tac
    if which tac > /dev/null; then
        tac=tac
    else
        tac='tail -r'
    fi
    local cmd=$(fc -l 1 | eval $tac | peco --query "$BUFFER" | gsed -r -e 's/^ *[0-9]+\*?  //')
    if [ -n "$cmd" ]; then
        BUFFER="$cmd"
        CURSOR=$#BUFFER
    fi
}

zle -N peco-history-select



function peco-git-select-files {
    local files=$(git status --porcelain | awk '{print $2}' | peco | tr \\n ' ')

    if [ -n "$files" ]; then
        LBUFFER="${LBUFFER}${files}"
    fi
}

zle -N peco-git-select-files
bindkey "^u^a" peco-git-select-files
