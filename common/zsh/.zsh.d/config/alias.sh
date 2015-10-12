# PAGER
if type lv > /dev/null 2>&1; then
    export PAGER="lv"
else
    export PAGER="less"
fi


#
###
### less
###

export LESS="--no-init --LONG-PROMPT --ignore-case -RF"


#
###
### grep
###

if type ggrep > /dev/null 2>&1; then
    alias grep=ggrep
fi

export MY_GREP_OPTIONS

MY_GREP_OPTIONS="--binary-files=without-match"

# Recursive grep on directories
MY_GREP_OPTIONS="--directories=recurse $MY_GREP_OPTIONS"

MY_GREP_OPTIONS="--exclude=\*.tmp $MY_GREP_OPTIONS"

if grep --help | grep -q -- --exclude-dir; then
    MY_GREP_OPTIONS="--exclude-dir=.svn $MY_GREP_OPTIONS"
    MY_GREP_OPTIONS="--exclude-dir=.git $MY_GREP_OPTIONS"
    MY_GREP_OPTIONS="--exclude-dir=.deps $MY_GREP_OPTIONS"
    MY_GREP_OPTIONS="--exclude-dir=.libs $MY_GREP_OPTIONS"
fi

if grep --help | grep -q -- --color; then
    MY_GREP_OPTIONS="--color=auto $MY_GREP_OPTIONS"
fi

alias grep="grep $MY_GREP_OPTIONS"


#
###
### Miscellaneous
###


alias man=" man"
alias ls="ls -G"
alias ll='ls -l'
alias la='ls -A'
alias lla="ls -l -A"
alias gls="gls --color"
alias mkdir="mkdir -p"
#alias top=" top -P"

alias urxvt='LC_ALL=ja_JP.UTF-8 urxvt'
alias tmux='tmux -u'
alias ssh='TERM=xterm ssh'
alias ssh256='ssh'

alias cd=' cd'
alias ps=' ps'
alias pd=" pushd"
alias po=" popd"

alias g="git"
alias v="vim"
alias vag="vagrant"

alias vimhist=' vim $HISTFILE'
alias lingr="vim --cmd 'let g:lingr = 1' -c LingrLaunch"
alias jqless="jq -C '.' | less "

alias tarx="tar xvzf"
alias tarc="tar cvzf"

alias iconvEU="iconv -f EUC-JP -t UTF-8"
function lsEU() { ls $@ | iconv -f EUC-JP -t UTF-8 }
alias lse="lsEU -G"

alias history=' history'
alias mplayer=' mplayer'
alias gmplayer=' gmplayer'

alias xdvi=' xdvi -expert'


#
###
### X Window System
###

# bugs here
alias akill="ps -x | canything | awk '{print \$1}' | xargs kill -9"
alias mkill="xprop | grep _NET_WM_PID | cut -d = -f 2 | xargs kill -9"
