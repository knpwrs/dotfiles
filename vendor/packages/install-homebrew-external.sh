#!/usr/bin/env zsh

formulae=(
  keith/formulae/reminders-cli # CLI for MacOS Reminders App
)

brew install "${formulae[@]///}"
