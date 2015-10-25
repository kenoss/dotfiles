# -*- mode: shell-script -*-

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

export LC_ALL=ja_JP.UTF-8


eval `tset -s rxvt-256color` > /dev/null



#
###
### Zsh options
###

setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt nolistbeep
setopt complete_aliases
setopt noautomenu
setopt extended_glob
setopt brace_ccl

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt interactive_comments
setopt noautoremoveslash


## --prefix=~/localというように「=」の後でも
## 「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst

## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

## 「/」も単語区切りとみなす。
WORDCHARS=${WORDCHARS:s,/,,}


#
###
### Completion
###

zstyle :compinstall filename "$HOME/.zshrc"

fpath=(~/.zsh.d/completion $fpath)
autoload -Uz compinit
compinit



#
###
### History
###

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



#function cd() { builtin cd $@ && ls }
function chpwd() { ls }


#
###
### z.sh
###

source ~/local/bin/z-zsh/z.sh

function precmd () {
    z --add "$(pwd -P)"
}


#
###
### prompt
###

setopt prompt_subst
export PROMPT='%F{red}%D{%H:%M:%S} ${USER}@${HOSTNAME} %! %(!.#.$)%k%f '
export PROMPT2='%F{red}         ${USER}@${HOSTNAME} %! >%k%f '
#export RPROMPT='%F{red}[%f`rprompt-git-current-branch`%~%F{red}]%f'


#
###
### ls
###

export LSCOLORS=gxdxcxdxfxegedabagacad
export LSCOLORS=gxdxxxxxcxxAxAcAcAgAgA
#export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;36' 'ln=;33' 'ex=32'
