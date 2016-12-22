#!/usr/bin/env zsh

if  [[ "$OSTYPE" = darwin* ]]; then
  hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo "Please agree to the Xcode license." && sudo xcodebuild -license }
  brew update
  brew upgrade
  brew bundle
  brew cleanup
else
  echo "Not on macOS. Skipping mac packages."
fi
