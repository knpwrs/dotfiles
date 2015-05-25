#!/usr/bin/env zsh

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.dotfiles/home/.*; do
  ln -fsv "$rcfile" "${ZDOTDIR:-$HOME}/${rcfile:t}"
done

