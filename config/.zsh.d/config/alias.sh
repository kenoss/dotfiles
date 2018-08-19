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
### Miscellaneous
###


alias ls="ls -G"
alias ll='ls -l'
alias la='ls -A'
alias lla="ls -l -A"
alias mkdir="mkdir -p"

alias tmux='tmux -u'

alias pd=" pushd"
alias po=" popd"
alias dirs=" dirs | tr ' ' '\n'"

alias vimhist=' vim $HISTFILE'
alias jqless="jq -C '.' | less "

alias tarx="tar xvzf"
alias tarc="tar cvzf"

alias iconvEU="iconv -f EUC-JP -t UTF-8"
function lsEU() { ls $@ | iconv -f EUC-JP -t UTF-8 }
alias lse="lsEU -G"


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
