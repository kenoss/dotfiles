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



#export ANDROID_HOME=~/Library/Android/sdk/tools




# Added by cpan
PERL_MB_OPT="--install_base \"/Users/takeshi.okada/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/takeshi.okada/perl5"; export PERL_MM_OPT;





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
