include_role 'base'

include_cookbook 'git'

include_cookbook 'vim'
include_cookbook 'zsh'
include_cookbook 'font-ricty'
include_cookbook 'ghq'
include_cookbook 'peco'
include_cookbook 'direnv'

package 'inotify-tools'
package 'jq'
# pcregrep
package 'pcre'
package 'rsync'
package 'tig'
package 'tmux'
package 'xorg-xauth'
package 'xsel'

# Config
dotfile '.config/alacritty'
dotfile '.peco'
dotfile '.tigrc'
dotfile '.tmux'
dotfile '.tmux.conf'
dotfile '.uim.d'

# Rust dev environmnet and tools
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
