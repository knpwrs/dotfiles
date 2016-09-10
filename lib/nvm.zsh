#!/usr/bin/env zsh

# Set up NVM
export NVM_DIR="$HOME/.nvm"
export NVM_SH="$NVM_DIR/nvm.sh"
if [ -f "$NVM_SH" ]; then
  # https://github.com/creationix/nvm/issues/860
  declare -a NODE_GLOBALS=(`find $NVM_DIR/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

  NODE_GLOBALS+=("node")
  NODE_GLOBALS+=("nvm")

  load_nvm () {
    [ -s "$NVM_SH" ] && . "$NVM_SH"
  }

  for cmd in "${NODE_GLOBALS[@]}"; do
    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
  done
fi
