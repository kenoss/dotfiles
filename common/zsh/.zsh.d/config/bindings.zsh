# -*- mode: shell-script -*-

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
