include_role 'base'

include_cookbook 'mac_homebrew'

include_cookbook 'git'

include_cookbook 'rbenv'

include_cookbook 'pyenv'
pip 'virtualenv'
pip 'powerline-status'

include_cookbook 'ndenv'

include_cookbook 'rust'
cargo 'racer'
cargo 'cargo-edit'
cargo 'cargo-script'
cargo 'cargo-update'

include_cookbook 'roswell'

include_cookbook 'vim'
include_cookbook 'zsh'
include_cookbook 'ghq'
include_cookbook 'peco'

include_cookbook 'font-ricty'

dotfile '.config'
dotfile '.peco'
dotfile '.tmux'
dotfile '.tmux.conf'
dotfile '.tigrc'
