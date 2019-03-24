function use-git-config () {
    local conf_path="$HOME/.gitconfig.$1"

    if [ ! -f "$conf_path" ]; then
        echo "Config file not found: $conf_path"
    else
        ln -sf "$conf_path" ~/.gitconfig
    fi
}
