include_role 'base'

include_cookbook 'git'

# Minimal
include_cookbook 'vim'
include_cookbook 'zsh'
include_cookbook 'ghq'
include_cookbook 'peco'
include_cookbook 'direnv'

package 'inotify-tools'
package 'jq'
# pcregrep
package 'pcre'
package 'tig'
package 'tmux'
package 'xsel'

# Config
dotfile '.config/alacritty'
dotfile '.peco'
dotfile '.tmux'
dotfile '.tmux.conf'
dotfile '.tigrc'
dotfile '.uim.d'

include_cookbook 'rust'

cargo 'cargo-edit'
cargo 'cargo-script'
cargo 'cargo-update'
cargo 'cargo-watch'

cargo 'alacritty'
cargo 'exa'
cargo 'fd-find'
cargo 'git-delta'
cargo 'ripgrep'
cargo 'starship'

# package 'xmonad'
# package 'xmonad-contrib'
package 'rofi'

include_cookbook 'font-ricty'

# include_cookbook 'rbenv'
# include_cookbook 'pyenv'
# include_cookbook 'ndenv'
