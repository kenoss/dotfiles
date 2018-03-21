include_role 'base'

include_cookbook 'git'

include_cookbook 'rbenv'

include_cookbook 'pyenv'
pip 'virtualenv'
pip 'powerline-status'

include_cookbook 'vim'
include_cookbook 'zsh'
include_cookbook 'ghq'
include_cookbook 'peco'

dotfile '.config'
dotfile '.peco'
dotfile '.tmux'
dotfile '.tmux.conf'
dotfile '.tigrc'
