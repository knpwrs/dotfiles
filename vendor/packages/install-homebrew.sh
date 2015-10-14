#!/usr/bin/env zsh

if  [[ "$OSTYPE" = darwin* ]]; then
  hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" }
  brew install ack caskroom/cask/brew-cask cowsay ctags git git-lfs ranger ssh-copy-id tmux tree vim zsh
  brew cask install betterzipql provisionql qlcolorcode qlimagesize qlmarkdown qlprettypatch qlstephen quicklook-csv quicklook-json suspicious-package webpquicklook
  brew cask install atom alfred beyond-compare bit-slicer firefox google-chrome handbrake keka reaper vlc
else
  echo "Not on OSX. Skipping Homebrew."
fi
