#!/usr/bin/env zsh

function installhb() {
  <$DOTPACKAGES/homebrew/packages-$1 cut -d' ' -f1 | xargs brew $2 install
}

function installhbc() {
  installhb $1 cask
}

if  [[ "$OSTYPE" = darwin* ]]; then
  HBPACKAGES=$DOTPACKAGES/homebrew
  hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo "Please agree to the Xcode license." && sudo xcodebuild -license }
  installhb homebrew
  installhb dupes
  installhb games
  installhbc cask
  installhbc cask-ql
  brew tap caskroom/fonts
  installhbc cask-fonts
else
  echo "Not on OSX. Skipping Homebrew."
fi
