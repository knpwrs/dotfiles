#!/usr/bin/env zsh

if  [[ "$OSTYPE" = darwin* ]]; then
  sudo xcodebuild -license accept
  hash brew 2>/dev/null || { /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" }
  brew update
  brew upgrade
  brew bundle
  brew cleanup
  # Use brew-installed zsh if we are not in CI and not using it already
  fgrep -q $(brew --prefix)/bin/zsh /etc/shells 2> /dev/null
  if [ $? -ne 0 ] && [ -z ${CI+x} ]; then
    echo $(brew --prefix)/bin/zsh | sudo tee -a /etc/shells
    chsh -s $(brew --prefix)/bin/zsh
  fi
  # Setup fzf
  yes | $(brew --prefix)/opt/fzf/install
  # Set default applications
  duti -s com.qvacua.VimR .txt all
  duti -s org.videolan.vlc .mp4 all
else
  echo "Not on macOS. Skipping mac packages."
fi
