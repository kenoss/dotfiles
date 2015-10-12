# -*- mode: shell-script -*-

###
### kill and yank
###

if which xclip >/dev/null 2>&1 ; then # UNIX
    # 何故かエラーに. 仕方ないので文字化けするが xclip を使う.
    # print -rn $CUTBUFFER | xsel --copy  --selection CLIPBOARD
    MYKILLCMD="xclip -i"
    MYYANKCMD="xsel --paste"
elif which pbcopy >/dev/null 2>&1 ; then # Mac
    MYKILLCMD="pbcopy"
    MYYANKCMD="pbpaste"
elif which putclip >/dev/null 2>&1 ; then # Cygwin
    MYKILLCMD="putclip"
    MYYANKCMD="getclip"
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
