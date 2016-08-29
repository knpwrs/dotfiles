#!/usr/bin/env zsh

formulae=(
  homebrew/dupes/rsync # Utility that provides fast incremental file transfer
)

brew install "${formulae[@]///}"
