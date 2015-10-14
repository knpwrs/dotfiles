#!/usr/bin/env zsh

hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" }
brew install ack caskroom/cask/brew-cask cowsay ctags git git-lfs ranger ssh-copy-id tmux tree vim zsh
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package provisionql
brew cask install atom alfred beyond-compare bit-slicer firefox google-chrome handbrake keka reaper vlc
