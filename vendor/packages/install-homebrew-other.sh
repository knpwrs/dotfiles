#!/usr/bin/env zsh

formulae=(
  keith/formulae/reminders-cli # CLI for macOS Reminders App
  reattach-to-user-namespace   # Utility for tighter macOS and tmux integration
)

brew install "${formulae[@]///}"
