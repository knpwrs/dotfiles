#!/usr/bin/env zsh

if [ ! -f $NVM_SH ]; then
  git clone https://github.com/creationix/nvm.git $HOME/.nvm && pushd $HOME/.nvm && git checkout `git describe --abbrev=0 --tags` && popd
  source $NVM_SH
  nvm install stable && nvm alias default stable
  echo "---"
  echo "!!! Please restart zsh or source $NVM_SH to start using node."
  echo "---"
fi
<$DOTPACKAGES/npm/packages cut -d' ' -f1 | xargs npm i -g
