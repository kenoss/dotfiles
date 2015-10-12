# -*- coding: utf-8 -*-

source $ZDOTDIR/256colorlib.zsh
# [ -f $ZDOTDIR/.zshrc.$(uname) ] && source $ZDOTDIR/.zshrc.$(uname)

HOSTNAME=$(hostname)

## LANG
if [ "$TERM" = "cons25" ]; then
  export LANG=C
#  export LC_ALL=C
else
#  export LANG=ja_JP.eucJP
#  export LC_ALL=ja_JP.eucJP
#  export LANG=ja_JP.UTF-8
#  export LC_ALL=C
  export LANG="ja_JP.UTF-8"
  export LC_ALL="C"
  # export LC_ALL="ja_JP.UTF-8"
  # export LC_CTYPE="ja_JP.UTF-8"
  # export LC_NUMERIC="ja_JP.UTF-8"
  # export LC_TIME="ja_JP.UTF-8"
  # export LC_COLLATE="ja_JP.UTF-8"
  # export LC_MONETARY="ja_JP.UTF-8"
  # export LC_MESSAGES="ja_JP.UTF-8"
  # export LC_PAPER="ja_JP.UTF-8"
  # export LC_NAME="ja_JP.UTF-8"
  # export LC_ADDRESS="ja_JP.UTF-8"
  # export LC_TELEPHONE="ja_JP.UTF-8"
  # export LC_MEASUREMENT="ja_JP.UTF-8"
  # export LC_IDENTIFICATION="ja_JP.UTF-8"
fi

bindkey -e
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt nolistbeep
setopt complete_aliases
setopt noautomenu
setopt extended_glob

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt interactive_comments
setopt noautoremoveslash



eval `tset -s rxvt-256color` > /dev/null





# history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history
setopt hist_verify
setopt hist_ignore_space
setopt hist_reduce_blanks

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 5
        && ${cmd} != l
        && ${cmd} != c
        && ${cmd} != m
        && ${line} != cd*\;xdvi\ -sourceposition*\& # for xdvi-jump-to-line in emacs
    ]]
}



# compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit


### prompt
setopt prompt_subst
export PROMPT='%F{red}%D{%H:%M:%S} ${USER}@${HOSTNAME} %! %(!.#.$)%k%f '
export PROMPT2='%F{red}         ${USER}@${HOSTNAME} %! >%k%f '
#export RPROMPT='%F{red}[%f`rprompt-git-current-branch`%~%F{red}]%f'



### ls
#unset LANG
export LSCOLORS=gxdxcxdxfxegedabagacad
export LSCOLORS=gxdxxxxxcxxAxAcAcAgAgA
#export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;36' 'ln=;33' 'ex=32'




#
#bindkey "^P" history-beginning-search-backward-end
#bindkey '^s' history-beginning-search-forward
#bindkey '^S' history-beginning-search-forward
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward



#function cd() { builtin cd $@ && ls }
function chpwd() { ls }



function cdup() {
    if [ -z "$BUFFER" ]; then
        echo
        cd ..
        zle reset-prompt
    else
        LBUFFER=$LBUFFER"^"
    fi
}
zle -N cdup
bindkey '\^' cdup








## --prefix=~/localというように「=」の後でも
## 「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst

## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

## 「/」も単語区切りとみなす。
WORDCHARS=${WORDCHARS:s,/,,}
















function install-firefox-pref() {
    local FIREFOXDIR=$HOME/.mozilla/firefox
    local RELSORCEDIR=prefscheme
#    local RELDESTDIRS=copyofaddontmp hoge

    cd $FIREFOXDIR
#    for destdir in tmp sns bank shopping math prog game eg0
    for destdir in $1
    do
        {
            local file=prefs.js
            if [ -e $destdir/$file ]
            then
                mv -v $destdir/$file $destdir/$file.old.$(date "+%F-%H%M%S")
            fi
#            sed "/extensions.xmarks.clientName/ { s/$RELSORCEDIR/$destdir/; }" $RELSORCEDIR/prefs.js > $destdir/prefs.js
        }
        for file in extensions{,.ini,.sqlite} firegestures.sqlite # jetpack
        do
            if [ -e $destdir/$file ]
            then
                mv -v $destdir/$file $destdir/$file.old.$(date +%F)
            fi
            cp -pa -v $RELSORCEDIR/$file $destdir
        done
    done
}


function portsearch() {
    function chpwd() { }
    (cd /usr/ports/ ; make search name="$1" | less)
    function chpwd() { ls }
}












function upload-ical () {
    local DIR=~/org/calendars
    emacs -batch -l ~/.emacs.d/init.d/50-org-mode.el -eval '(my-org-export-icalendar)'
    for file in workshop seminor
    do
        local code=$(nkf -g $DIR/$file.ics)
        if [ $code = "UTF-8" ] ; then
            mv $DIR/$file.ics $DIR/out/
        elif [ $code = "EUCJP-MS" ] ; then
            iconv -f EUC-JP -t UTF-8 $DIR/$file.ics > $DIR/out/$file.ics
            rm $DIR/$file.ics
        else
            iconv -f $code -t UTF-8 $DIR/$file.ics > $DIR/out/$file.ics
            rm $DIR/$file.ics
        fi
        cp -ap $DIR/$file.org $DIR/out/
    done
    chmod 644 $DIR/out/*
    scp $DIR/out/* $DIR/out/.* keno@irissanguinea.no-ip.org:/usr/home/www/ics/
}





function findgrep () {
    find $2 -type f -exec grep --with-filename $1 {} \;
}


setopt brace_ccl


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

function refrect-vbox-win () {
    local VBOXHOME=~/VirtualBox/sharedirs/WHSallread/home
    rsync -avL ~/.vimperator $VBOXHOME/
    mv $VBOXHOME/{.,}vimperator
    cp -a ~/.vimperatorrc ~/VirtualBox/sharedirs/WHSallread/home/vimperator/
}

UPLATEX=/usr/local/texlive/2012/bin/amd64-freebsd/uplatex
EPLATEX=/usr/local/texlive/2012/bin/amd64-freebsd/platex
DVIPDFMX=/usr/local/texlive/2012/bin/amd64-freebsd/dvipdfmx
function uplatex-pdf(){
    local filesans="${1%.*}"
    $UPLATEX "$filesans.tex" && $UPLATEX "$filesans.tex" && $DVIPDFMX "$filesans"
}
function uplatex-pdf-view(){
    local filesans="${1%.*}"
    uplatex-pdf "$filesans" && evince "$filesans.pdf"
}
function eplatex-pdf(){
    local filesans="${1%.*}"
    $EPLATEX "$filesans.tex" && $EPLATEX "$filesans.tex" && $DVIPDFMX "$filesans"
}
function eplatex-pdf-view(){
    local filesans="${1%.*}"
    eplatex-pdf "$filesans" && evince "$filesans.pdf"
}

# temporary definition
function exchange-mv () {
    mv $1 $1.exchangemv
    mv $2 $1
    mv $1.exchangemv $2
}


#export ANDROID_HOME=~/Library/Android/sdk/tools




# Added by cpan
PERL_MB_OPT="--install_base \"/Users/takeshi.okada/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/takeshi.okada/perl5"; export PERL_MM_OPT;


# From http://petitviolet.hatenablog.com/entry/20140722/1406034439
function peco-select-gitadd() {
    local SELECTED_FILE_TO_ADD="$(git status --porcelain | \
                                  peco --query "$LBUFFER" | \
                                  awk -F ' ' '{print $NF}')"
    if [ -n "$SELECTED_FILE_TO_ADD" ]; then
      BUFFER="git add $(echo "$SELECTED_FILE_TO_ADD" | tr '\n' ' ')"
      CURSOR=$#BUFFER
    fi
    zle accept-line
    # zle clear-screen
}
zle -N peco-select-gitadd
bindkey "^u^a" peco-select-gitadd



function peco-git-branch-checkout () {
    local selected_branch_name="$(git branch -a | peco | sed 's/^\*/ /' | tr -d ' ')"
    case "$selected_branch_name" in
        *-\>* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*->(.*?)\/(.*)$/\2/;print')";;
        remotes* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*?remotes\/(.*?)\/(.*)$/\2/;print')";;
    esac
    if [ -n "$selected_branch_name" ]; then
        BUFFER=" git checkout ${selected_branch_name}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-branch-checkout

bindkey '^u^b' peco-git-branch-checkout


function peco-git-new-branch-with-base () {
    local selected_branch_name="$(git branch -a | peco | sed 's/^\*/ /' | tr -d ' ')"
    case "$selected_branch_name" in
        *-\>* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's|^.*-> *?(.*)$|\1|;print')";;
        remotes* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's|^.*?remotes/(.*)$|\1|;print')";;
    esac
    if [ -n "$selected_branch_name" ]; then
        LBUFFER=" git checkout -b "
        RBUFFER=" ${selected_branch_name}"
    fi
    zle clear-screen
}
zle -N peco-git-new-branch-with-base

bindkey '^u^n' peco-git-new-branch-with-base


function peco-git-select-branch () {
    local selected_branch_name="$(git branch -a | peco | sed 's/^\*/ /' | tr -d ' ')"
    case "$selected_branch_name" in
        *-\>* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's|^.*-> *?(.*)$|\1|;print')";;
        remotes* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's|^.*?remotes/(.*)$|\1|;print')";;
    esac
    if [ -n "$selected_branch_name" ]; then
        LBUFFER="$(echo ${LBUFFER} | sed -e 's/ *$//') ${selected_branch_name}"
        RBUFFER="${RBUFFER}"
    fi
    zle clear-screen
}
zle -N peco-git-select-branch

bindkey '^u^u' peco-git-select-branch



PATH=$PATH:"$HOME/bin.local/activator"

export LC_ALL=ja_JP.UTF-8



source ~/local/bin/z-zsh/z.sh

function precmd () {
    z --add "$(pwd -P)"
}



function p () {
    local cmd="$1"

    case "$cmd" in
        '' )     peco-command ;;
        'ssh' )  peco-ssh ;;
    esac
}

function peco-ssh () {
    ssh $(grep -E '^Host[[:space:]]+[^*]' ~/.ssh/config | peco | awk '{print $2}')
}



function normalize-json () {
    local str="$1"

    node -e 'var str = process.argv[1]; var obj = (new Function("return " + str))(); console.log(JSON.stringify(obj));' $str
}

function curl-jsonrpc-request () {
    local url="$1"
    local method="\"$2\""
    local params="$3"
    local raw_json="{ jsonrpc: '2.0', 'id': 1, 'method': $method, 'params': $params }"
    local json="$(normalize-json $raw_json)"

    curl -s $url \
         -H "Accept: application/json" -H 'Content-Type: application/json' \
         -d $json \
         ${@:4} \
}


function install-git-config () {
    local conf_dir=~/git.keno/dotfiles/common/git
    local conf_path_common="$conf_dir/.gitconfig.common"
    local conf_path_name="$conf_dir/.gitconfig.$1"

    if [ ! -f "$conf_path_name" ]; then
        echo "Config file not found: $conf_path_name"
    else
        (cd ~/ > /dev/null ; ln -sf "$conf_path_common" ; ln -sf "$conf_path_name" ~/.gitconfig)
    fi
}
