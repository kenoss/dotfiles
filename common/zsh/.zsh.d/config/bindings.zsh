# -*- mode: shell-script -*-


# Disable exit with C-d
setopt IGNORE_EOF

# Emacs like key bindings
bindkey -e


# Search and move
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# Kill and yank
load-zsh-config config/feature-kill-yank.zsh
bindkey "^k" copy-line-as-kill
bindkey "^y" paste-as-yank


# Expand abbrev
load-zsh-config config/feature-expand-abbrev.zsh
bindkey "^e" expand-abbrev


# peco git
load-zsh-config config/feature-peco-git.zsh
bindkey '^u^b' peco-git-insert-branch-to-buffer
bindkey '^u^m' peco-git-insert-modified-files-to-buffer


# peco tmux
bindkey '^u^l' peco-tmux-select-window


# peco ghq
bindkey '^u^?' peco-ghq


# peco history
bindkey '^R' peco-history-select
