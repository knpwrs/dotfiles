#!/usr/bin/env zsh

apps=(
  937984704 # Amphetamine
  499233976 # Cathode
  411643860 # DaisyDisk
  847496013 # Deckset
  408981434 # iMovie
  409183694 # Keynote
  634159523 # MainStage 3
  915542151 # Monity
  935250717 # MonthlyCal
  928871589 # Noizio
  411466132 # Novabench
  409201541 # Pages
  407963104 # Pixelmator
  921553264 # Screenium 3
)

echo "${apps[@]///}" | xargs -n1 mas install
