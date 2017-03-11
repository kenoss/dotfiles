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

export MY_GREP_OPTIONS=''

MY_GREP_OPTIONS='--binary-files=without-match'
MY_GREP_OPTIONS="--exclude=\*.tmp $MY_GREP_OPTIONS"

if command grep --help | command grep -q -- --exclude-dir; then
    MY_GREP_OPTIONS="--exclude-dir=.svn $MY_GREP_OPTIONS"
    MY_GREP_OPTIONS="--exclude-dir=.git $MY_GREP_OPTIONS"
fi

if command grep --help | command grep -q -- --color; then
    MY_GREP_OPTIONS="--color=auto $MY_GREP_OPTIONS"
fi

export MY_GREP_OPTIONS

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
alias dirs=" dirs | tr ' ' '\n'"

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

alias tg=' tig grep'


#
###
### X Window System
###

# bugs here
alias akill="ps -x | canything | awk '{print \$1}' | xargs kill -9"
alias mkill="xprop | grep _NET_WM_PID | cut -d = -f 2 | xargs kill -9"


#
###
### misc
###

export KEU_CHROME_EXECUTABLE='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias peco-git-merge-commit-url-open="peco-git-merge-commit-url | xargs $KEU_CHROME_EXECUTABLE"


alias js-beautify-replace='js-beautify -rn'

export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
alias symbolicatecrash='/Applications/Xcode.app/Contents/SharedFrameworks/DTDeviceKitBase.framework/Versions/A/Resources/symbolicatecrash'
