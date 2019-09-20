# Java
if [ -x /usr/libexec/java_home ] && /usr/libexec/java_home > /dev/null 2>&1; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi


###
### Auxiliary functions
###

KEU_PATH_BEFORE=''
KEU_PATH_AFTER=''

function add-path-if-exists () {
    local pos=$1
    local newpath=$2
    if [ -d "$newpath" ]; then
        if [ "$pos" = 'before-head' ]; then
            export KEU_PATH_BEFORE="$newpath:$KEU_PATH_BEFORE"
        elif [ "$pos" = 'before-tail' ]; then
            export KEU_PATH_BEFORE="$KEU_PATH_BEFORE:$newpath"
        elif [ "$pos" = 'after-head' ]; then
            export KEU_PATH_AFTER="$newpath:$KEU_PATH_AFTER"
        elif [ "$pos" = 'after-tail' ]; then
            export KEU_PATH_AFTER="$KEU_PATH_AFTER:$newpath"
        else
            echo 'add-path-if-exists:Error'
        fi
    fi
}


###
### System commands
###

add-path-if-exists before-tail "$HOME/bin"
add-path-if-exists before-tail "$HOME/local/bin"

# mac
if [ "$(uname)" = 'Darwin' ]; then
    add-path-if-exists before-tail '/opt/local/bin'
    add-path-if-exists before-tail '/opt/local/sbin'
    export MANPATH=/opt/local/man:$MANPAHH
fi


###
### anyenv
###

CACHE_DIR="$HOME/.zsh.d/cache/$(basename $SHELL)"


function keu-anyenv-clear-cache {
    rm -rf "$CACHE_DIR"
}

function _keu-anyenv-make-cache {
    local target=$1
    local cache_path="$CACHE_DIR/$target.sh"

    mkdir -p $(dirname "$cache_path")
    $target init --no-rehash - > $cache_path
}

function _keu-anyenv-init {
    local target=$1
    local cache_path="$CACHE_DIR/$target.sh"

    if [ -d "${HOME}/.$target" ] ; then
        if [ ! -f "$cache_path" ]; then
            _keu-anyenv-make-cache $target
        fi

        source "$cache_path"
    fi
}


_keu-anyenv-init pyenv
_keu-anyenv-init rbenv
_keu-anyenv-init ndenv


###
### Programming Languages
###

# Golang
export GOPATH="$HOME"
add-path-if-exists before-tail "$GOPATH/bin"

# Rust
add-path-if-exists before-tail "$HOME/.cargo/bin"

# Common Lisp
add-path-if-exists before-tail "$GOPATH/.roswell/bin"

# Haskell
add-path-if-exists before-tail "$HOME/.cabal/bin"


###
### Utilities
###

add-path-if-exists before-tail '/usr/local/share/git-core/contrib/diff-highlight'
add-path-if-exists after-tail "$HOME/bin/google-cloud-sdk/bin"


###
### Finalize
###

export PATH=$(echo "$KEU_PATH_BEFORE:$PATH:$KEU_PATH_AFTER" |\
              sed -E -e 's/:+/:/g' -e 's/(^:|:$)//g')
unset KEU_PATH_BEFORE
unset KEU_PATH_AFTER
