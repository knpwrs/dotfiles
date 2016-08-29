#!/usr/bin/env zsh

if  [[ "$OSTYPE" = darwin* ]]; then
  HBPACKAGES=$DOTPACKAGES/homebrew
  hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo "Please agree to the Xcode license." && sudo xcodebuild -license }
  $DOTPACKAGES/install-homebrew-main.sh
  $DOTPACKAGES/install-homebrew-dupes.sh
  $DOTPACKAGES/install-homebrew-cask.sh
  $DOTPACKAGES/install-homebrew-cask-ql.sh
  $DOTPACKAGES/install-homebrew-cask-fonts.sh
  $DOTPACKAGES/install-homebrew-games.sh
  $DOTPACKAGES/install-homebrew-external.sh
else
  echo "Not on macOS. Skipping Homebrew."
fi
