#!/usr/bin/env zsh

formulae=(
  homebrew/games/gnuski # Open source clone of Skifree
  homebrew/games/ski    # Evade the deadly Yeti on your jet-powered skis.
  homebrew/games/yetris # Terminal Tetris
)

brew install "${formulae[@]///}"
