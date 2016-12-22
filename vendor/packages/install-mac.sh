#!/usr/bin/env zsh

if  [[ "$OSTYPE" = darwin* ]]; then
  hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo "Please agree to the Xcode license." && sudo xcodebuild -license }
  brew update
  brew upgrade
  brew bundle
  brew cleanup
  # Use brew-installed zsh
  if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then
    echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh
  fi
else
  echo "Not on macOS. Skipping mac packages."
fi
