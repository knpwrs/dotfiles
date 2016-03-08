#!/usr/bin/env zsh

if  [[ "$OSTYPE" = darwin* ]]; then
  HBPACKAGES=$DOTPACKAGES/homebrew
  hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo "Please agree to the Xcode license." && sudo xcodebuild -license }
  <$HBPACKAGES/packages-homebrew cut -d' ' -f1 | xargs brew install
  <$HBPACKAGES/packages-dupes cut -d' ' -f1 | xargs brew install
  <$HBPACKAGES/packages-cask cut -d' ' -f1 | xargs brew cask install
  <$HBPACKAGES/packages-cask-ql cut -d' ' -f1 | xargs brew cask install
  brew tap caskroom/fonts
  <$HBPACKAGES/packages-cask-fonts cut -d' ' -f1 | xargs brew cask install
else
  echo "Not on OSX. Skipping Homebrew."
fi
