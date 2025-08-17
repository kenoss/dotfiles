case node[:platform]
when 'fedora' then
  # The package 'xmonad' includes 'ghc-xmonad' and 'ghc-xmonad-contrib'
  package 'xmonad'
else
  package 'xmonad'
  package 'xmonad-contrib'
end
