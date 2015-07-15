# Atom Aliases
# Based on https://github.com/robbyrussell/oh-my-zsh/blob/a207a38d634cc10441636bc4359cd8a18c502dea/plugins/atom/atom.plugin.zsh

local _atom_paths > /dev/null 2>&1
_atom_paths=(
  "$HOME/Applications/Atom.app"
  "/Applications/Atom.app"
)

for _atom_path in $_atom_paths; do
  if [[ -a $_atom_path ]]; then
    alias at="open -a '$_atom_path'"
    break
  fi
done

alias att='at .'
