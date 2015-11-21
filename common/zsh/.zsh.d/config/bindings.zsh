# -*- mode: shell-script -*-


# Emacs like key bindings
bindkey -e


# Search and move
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


# Kill and yank
load-zsh-config config/feature-kill-yank.zsh
bindkey "^k" copy-line-as-kill
bindkey "^y" paste-as-yank


# Expand abbrev
load-zsh-config config/feature-expand-abbrev.zsh
bindkey "^e" expand-abbrev


# peco git
load-zsh-config config/feature-peco-git.zsh
bindkey "^u^a" peco-select-gitadd
bindkey '^u^b' peco-git-branch-checkout
bindkey '^u^n' peco-git-new-branch-with-base
bindkey '^u^u' peco-git-select-branch


# peco ghq
bindkey '^u^o' peco-ghq
