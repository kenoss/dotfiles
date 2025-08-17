include_role 'standard'

# Use Wayland compositor or X Window manager what you want.
# include_cookbook 'xmonad'

include_cookbook 'font-ricty'

cargo 'alacritty'
dotfile '.config/alacritty'

dotfile '.uim.d'

case node[:platform]
when 'debian' then
when 'fedora' then
  package 'xorg-x11-xauth'
else
  package 'xorg-xauth'
end

package 'xsel'

package 'rofi'
