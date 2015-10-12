function p () {
    local cmd="$1"

    case "$cmd" in
        '' )     peco-command ;;
        'ssh' )  peco-ssh ;;
    esac
}

function peco-ssh () {
    ssh $(grep -E '^Host[[:space:]]+[^*]' ~/.ssh/config | peco | awk '{print $2}')
}
