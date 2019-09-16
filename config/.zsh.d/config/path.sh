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
### Programming Languages
###

# rbenv
if [ -d "${HOME}/.rbenv" ] ; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init --no-rehash -)"
fi

# pyenv
if [ -d "${HOME}/.pyenv" ] ; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --no-rehash -)"
fi

# ndenv
if [ -d "${HOME}/.ndenv" ] ; then
    export PATH="$HOME/.ndenv/bin:$PATH"
    eval "$(ndenv init --no-rehash -)"
fi

# For powerline
add-path-if-exists after-tail "$HOME/.local/bin"

# Emacs Cask
add-path-if-exists after-tail  "$HOME/.cask/bin"

# Golang
export GOPATH="$HOME"
add-path-if-exists before-tail "$GOPATH/bin"

# Rust
add-path-if-exists before-tail "$HOME/.cargo/bin"

# Haskell
add-path-if-exists before-tail "$HOME/.cabal/bin"

# Scala
add-path-if-exists before-tail "$HOME/bin.local/activator"

add-path-if-exists before-tail "$HOME/.lein"


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
