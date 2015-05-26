#!/usr/bin/env zsh

# Use extended globbing
setopt EXTENDED_GLOB

# Remove all dead links in home directory.
rm "${ZDOTDIR:-$HOME}"/*(-@D)

# Link all dotfiles to those in this repo.
for rcfile in "${ZDOTDIR:-$HOME}"/.dotfiles/home/.*; do
  ln -fsv "$rcfile" "${ZDOTDIR:-$HOME}/${rcfile:t}"
done

