#!/usr/bin/env zsh

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.dotfiles/home/^README.md(.N); do
  ln -fsv "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

