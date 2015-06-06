# Emacs key bindings
bindkey -e

# History key bindings
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
