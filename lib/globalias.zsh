# Based on https://github.com/robbyrussell/oh-my-zsh/blob/7ed82b4df6d381ef26a4dbdf253bf414497adcd1/plugins/globalias/globalias.plugin.zsh

globalias() {
   zle _expand_alias
   zle expand-word
   zle self-insert
}
zle -N globalias

# space expands all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space
