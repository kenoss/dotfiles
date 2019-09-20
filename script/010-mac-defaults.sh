###
### Keyboard
###

defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1


###
### Dock
###

# Clear default persistent apps.
defaults write com.apple.dock persistent-apps -array
# Small icon size.
defaults write com.apple.dock tilesize -int 25
