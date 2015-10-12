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

function lsEU() { ls $@ | iconv -f EUC-JP -t UTF-8 }


alias man=" man"
alias iconvEU="iconv -f EUC-JP -t UTF-8"
alias lse="lsEU -G"
#alias ls="lsEU -G"
alias ls="ls -G"
alias ll='ls -l'
alias la='ls -A'
alias lla="ls -l -A"
alias gls="gls --color"
alias mkdir="mkdir -p"
alias tarx="tar xvzf"
alias tarc="tar cvzf"
alias top=" top -P"

#alias less=' less'
#alias lv=' lv'
alias history=' history'
#alias cat=' cat'
alias mplayer=' mplayer'
alias gmplayer=' gmplayer'
alias xdvi=' xdvi -expert'
alias urxvt='LC_ALL=ja_JP.UTF-8 urxvt'
alias tmux='tmux -u'
alias ssh='TERM=xterm ssh'
alias ssh256='ssh'

alias cd=' cd'
alias ps=' ps'
alias vimhist=' vim ~/.zsh.d/.zsh_history'
alias jqless="jq -C '.' | less "


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





if type lv > /dev/null 2>&1; then
    ## lvを優先する。
    export PAGER="lv"
else
    ## lvがなかったらlessを使う。
    export PAGER="less"
fi

#if [ "$PAGER" = "lv" ]; then
#    ## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
#    ## -l: 1行が長くと折り返されていても1行として扱う。
#    ##     （コピーしたときに余計な改行を入れない。）
#    export LV="-c -l"
#fi

## GNU grepがあったら優先して使う。
if type ggrep > /dev/null 2>&1; then
    alias grep=ggrep
fi
## デフォルトオプションの設定
export MY_GREP_OPTIONS
### バイナリファイルにはマッチさせない。
MY_GREP_OPTIONS="--binary-files=without-match"
### grep対象としてディレクトリを指定したらディレクトリ内を再帰的にgrepする。
#MY_GREP_OPTIONS="--directories=recurse $MY_GREP_OPTIONS"
### 拡張子が.tmpのファイルは無視する。
MY_GREP_OPTIONS="--exclude=\*.tmp $MY_GREP_OPTIONS"
## 管理用ディレクトリを無視する。
if grep --help | grep -q -- --exclude-dir; then
    MY_GREP_OPTIONS="--exclude-dir=.svn $MY_GREP_OPTIONS"
    MY_GREP_OPTIONS="--exclude-dir=.git $MY_GREP_OPTIONS"
    MY_GREP_OPTIONS="--exclude-dir=.deps $MY_GREP_OPTIONS"
    MY_GREP_OPTIONS="--exclude-dir=.libs $MY_GREP_OPTIONS"
fi
### 可能なら色を付ける。
if grep --help | grep -q -- --color; then
    MY_GREP_OPTIONS="--color=auto $MY_GREP_OPTIONS"
fi

alias grep="grep $MY_GREP_OPTIONS"



export LESS="--no-init --LONG-PROMPT --ignore-case -RF"



## --prefix=~/localというように「=」の後でも
## 「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst

## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

## 「/」も単語区切りとみなす。
WORDCHARS=${WORDCHARS:s,/,,}

## pushd/popdのショートカット。
alias pd=" pushd"
alias po=" popd"



# abbrev
typeset -A myabbrev
myabbrev=(
    "DN"  "&> /dev/null"
    "L"   "| $PAGER "
    "G"   "| grep "
    "S"   "| sed '_|_'"
    "R"   " rm "
    "M"   " mkdir "
    "C"   " cat "
    "TX"  " tar -xvzf "
    "TC"  " tar -cvzf "
    "RS"  "rsync -av --exclude '\#*' --exclude '*~' "
    "FX"  "find _|_ -print0 | xargs -0 "
    "PWD" ""
)

my-expand-abbrev() {
    if [ -z "$RBUFFER" ] ; then
        my-expand-abbrev-aux
    else
        zle end-of-line
    fi
}

# my-expand-abbrev-aux() {
#     local left prefix value addleft addright
#     left=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
#     prefix=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
#     value=${myabbrev[$prefix]}
#     if [[ $value = *_\|_* ]] ; then
#         addleft=${value%%_\|_*}
#         addright=${value#*_\|_}
#     else
#         addleft=$value
#         addright=""
#     fi
#     if [ -z "$left" ] ; then
#         LBUFFER=$left${addleft:-$prefix }
#         RBUFFER=$addright$RBUFFER
#     else
#         LBUFFER=$left$prefix" "
#     fi
#     if [ "$prefix" = "PWD" ] ; then
#         LBUFFER=""
#         RBUFFER="$PWD"
#     fi
# }
my-expand-abbrev-aux() {
    local init last value addleft addright
    init=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
    last=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
    value=${myabbrev[$last]}
    if [[ $value = *_\|_* ]] ; then
        addleft=${value%%_\|_*}
        addright=${value#*_\|_}
    else
        addleft=$value
        addright=""
    fi
    if [ "$last" = "PWD" ] ; then
        LBUFFER=""
        RBUFFER="$PWD"
    else
        LBUFFER=$init${addleft:-$last }
        RBUFFER=$addright$RBUFFER
    fi
}

zle -N my-expand-abbrev
bindkey "^e" my-expand-abbrev




alias nicovdl='nicovideo-dl -u aoeui666@gmail.com -p am0nI0ptmcosntdt -x'





alias histgrep='history 1 | grep'

function histgrepuniq() {
    histgrep $1 | sed 's/^ *[0-9]* */  /' | sort -u
}

alias hisg='histgrep'
alias hisgu='histgrepuniq'

function hisgl() {
    histgrep $1 | $PAGER
}



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





#function copy-line-as-kill() {
#    zle kill-line
#    if which xclip >/dev/null 2>&1 ; then # UNIX
#        # 何故かエラーに. 仕方ないので文字化けするが xclip を使う.
#        #    print -rn $CUTBUFFER | xsel --copy  --selection CLIPBOARD
#        print -rn $CUTBUFFER | xclip -i
#    elif which pbcopy >/dev/null 2>&1 ; then # Mac
#        print -rn $CUTBUFFER | pbcopy
#    elif which putclip >/dev/null 2>&1 ; then # Cygwin
#        print -rn $CUTBUFFER | putclip
#    fi
#}
#zle -N copy-line-as-kill
#
#function paste-as-yank() {
#    if which xsel >/dev/null 2>&1 ; then # UNIX
#        LBUFFER=$LBUFFER"`xsel --paste`"
#    elif which pbpaste >/dev/null 2>&1 ; then # Mac
#        LBUFFER=$LBUFFER"`pbpaste`"
#    elif which getclip >/dev/null 2>&1 ; then # Cygwin
#        LBUFFER=$LBUFFER"`getclip`"
#    fi
#}
#zle -N paste-as-yank
#

### kill and yank

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

bindkey "^k" copy-line-as-kill
bindkey "^y" paste-as-yank






#alias decolorize="sed -e 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g'"
#alias decolorize="sed -e 's/\x1B\[\([0-9]{1,2}\(;[0-9]{1,2}\)?\)?[m|K]//g'"





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



# TeX
export BSTINPUT=$HOME/texmf/bibtex/bst
export BIBINPUT=$HOME/texmf/bibtex/bib
alias eplatex="/usr/local/texlive/2012/bin/amd64-freebsd/platex"


function findgrep () {
    find $2 -type f -exec grep --with-filename $1 {} \;
}


# bugs here
alias akill="ps -x | canything | awk '{print \$1}' | xargs kill -9"
# alias akillhoge="ps -x | grep gmplayer | awk -F' ' '{print $1}'"
# alias akillfoo="cat hoge | awk '{print $1}'"
# alias akillhoge="ps -x | canything | tee tea | awk '{print $1}' | xargs kill -9"
# alias akillhoge="ps -x | canything | sed 's/ .*$//' | cat | xargs kill -9"
# alias akill="ps -x | canything | sed 's/ .*$//' | xargs kill -9"
# alias akill="ps -x | canything | cut -d' ' -f1 | xargs kill -9"
alias mkill="xprop | grep _NET_WM_PID | cut -d = -f 2 | xargs kill -9"
alias g="git"
alias vag="vagrant"
alias v="vim"
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


alias lingr="vim --cmd 'let g:lingr = 1' -c LingrLaunch"


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
