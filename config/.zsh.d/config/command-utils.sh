function use-git-config () {
    local conf_path="$XDG_CONFIG_HOME/git/config.$1"

    if [ ! -f "$conf_path" ]; then
        echo "Config file not found: $conf_path"
    else
        ln -sf "$conf_path" "$XDG_CONFIG_HOME/git/config"
    fi
}
