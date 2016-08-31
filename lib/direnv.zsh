#!/usr/bin/env zsh

# Load direnv
if hash direnv 2>/dev/null; then
  eval "$(direnv hook zsh)"
fi
