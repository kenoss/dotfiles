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
case node[:platform]
when 'debian' then
  package 'pcregrep'
else
  package 'pcre'
end
package 'rsync'
package 'tig'
package 'tmux'
case node[:platform]
when 'debian' then
else
package 'xorg-xauth'
end
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
cargo 'cargo-update'
cargo 'cargo-watch'

cargo 'alacritty'
cargo 'exa'
cargo 'fd-find'
cargo 'git-delta'
cargo 'ripgrep'
cargo 'starship'
