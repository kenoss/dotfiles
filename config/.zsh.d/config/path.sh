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

# anyenv
if [ -d "${HOME}/.anyenv" ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi

# For powerline
add-path-if-exists after-tail "$HOME/.local/bin"

# Emacs Cask
add-path-if-exists after-tail  "$HOME/.cask/bin"

# Golang
export GOPATH="$HOME/bin/go"
add-path-if-exists before-tail "$GOPATH/bin"

# Common Lisp
export CIM_HOME="$HOME/.cim"; [ -s "$CIM_HOME/init.sh" ] && source "$CIM_HOME/init.sh"
add-path-if-exists before-tail "$HOME/.shelly/bin"

# Haskell
add-path-if-exists before-tail "$HOME/.cabal/bin"

# Scala
add-path-if-exists before-tail "$HOME/bin.local/activator"

# Java
if type java > /dev/null; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

add-path-if-exists before-tail "$HOME/.lein"


###
### Utilities
###

add-path-if-exists before-tail '/usr/local/share/git-core/contrib/diff-highlight'


###
### Finalize
###

export PATH=$(echo "$KEU_PATH_BEFORE:$PATH:$KEU_PATH_AFTER" |\
              sed -E -e 's/:+/:/g' -e 's/(^:|:$)//g')
unset KEU_PATH_BEFORE
unset KEU_PATH_AFTER
