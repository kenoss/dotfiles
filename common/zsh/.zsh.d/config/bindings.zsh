# -*- mode: shell-script -*-

# Kill and yank
load-zsh-config config/feature-kill-yank.zsh
bindkey "^k" copy-line-as-kill
bindkey "^y" paste-as-yank


# Expand abbrev
load-zsh-config config/feature-expand-abbrev.zsh
bindkey "^e" expand-abbrev
