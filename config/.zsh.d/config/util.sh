function source-if-exist () {
    if [ ! -f "$1" ]; then
        if [ ! -z "$DEBUG" ]; then
            echo "tried to source, but file not found: $1"
        fi
    else
        source "$1"
    fi
}
