## LANG

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8



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


# Expand path after '=' like `--prefix=~/local`
setopt magic_equal_subst

# Print statistics of process if command takes more than 3 seconds.
REPORTTIME=3

## Regard '/' as word separator.
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



#
###
### prompt
###

HOSTNAME=$(hostname)

setopt prompt_subst
export PROMPT='%F{red}%D{%H:%M:%S} ${USER}@${HOSTNAME} %! %(!.#.$)%k%f '
export PROMPT2='%F{red}         ${USER}@${HOSTNAME} %! >%k%f '



#
###
### ls
###

export LSCOLORS=gxdxxxxxcxxAxAcAcAgAgA
zstyle ':completion:*' list-colors 'di=;36' 'ln=;33' 'ex=32'



###
### direnv
###

eval "$(direnv hook zsh)"
