include_role 'base'

# stage 1
include_cookbook 'git'
include_cookbook 'vim'
include_cookbook 'zsh'
include_cookbook 'ghq'
include_cookbook 'peco'
include_cookbook 'pcregrep'

package 'jq'
package 'rsync'
package 'tig'
package 'tmux'

dotfile '.peco'
dotfile '.tigrc'
dotfile '.tmux'
dotfile '.tmux.conf'

# stage 2
include_cookbook 'direnv'

package 'inotify-tools'

# Rust dev environmnet and tools
include_cookbook 'rust'

cargo 'cargo-edit'
cargo 'cargo-update'
cargo 'cargo-watch'
cargo 'exa'
cargo 'fd-find'
cargo 'git-delta'
cargo 'ripgrep'
cargo 'starship'
