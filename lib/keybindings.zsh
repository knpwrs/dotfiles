# Emacs key bindings
bindkey -e

# History key bindings
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
