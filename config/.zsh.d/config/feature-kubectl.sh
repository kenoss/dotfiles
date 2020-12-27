if type -p kubectl 2>&1 >/dev/null; then
    alias k='kubectl'
    source <(kubectl completion $(basename $SHELL))
    complete -F __start_kubectl k
fi
