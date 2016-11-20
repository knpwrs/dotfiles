#!/usr/bin/env zsh

taps=(
  caskroom/fonts # Official caskroom fonts tap
)

casks=(
  font-dosis
  font-fira-sans
  font-inconsolata
  font-lato
  font-league-gothic
  font-montserrat
  font-pacifico
  font-pt-sans
  font-quicksand
  font-raleway
  font-roboto
  font-source-code-pro-for-powerline
  font-source-sans-pro
)

brew tap "${taps[@]///}"
brew cask install "${casks[@]///}"
