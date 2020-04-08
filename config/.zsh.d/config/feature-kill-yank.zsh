# -*- mode: shell-script -*-

###
### kill and yank
###

if which xsel >/dev/null 2>&1 ; then # UNIX
    MYKILLCMD="xsel -i --clipboard"
    MYYANKCMD="xsel -o --clipboard"
elif which pbcopy >/dev/null 2>&1 ; then # Mac
    MYKILLCMD="pbcopy"
    MYYANKCMD="pbpaste"
fi

function copy-line-as-kill() {
    zle kill-line
    print -rn $CUTBUFFER | ${=MYKILLCMD}
}
zle -N copy-line-as-kill
function paste-as-yank() {
    LBUFFER=$LBUFFER"$(${=MYYANKCMD})"
}
zle -N paste-as-yank
