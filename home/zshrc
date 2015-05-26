# Load zsh modules
autoload -U colors && colors
autoload -Uz compinit && compinit

# Source everything ending in .zsh in the lib directory.
for rcfile in $DOTFILESLIB/*.zsh; do
  source $rcfile
done

# Set up NVM
source $DOTFILES/vendor/nvm/nvm.sh

# Load syntax highlighting
source $DOTFILES/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
