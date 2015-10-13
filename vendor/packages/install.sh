#!/usr/bin/env zsh

PACKAGES="$DOTFILES/vendor/packages"

$PACKAGES/install-homebrew.sh
$PACKAGES/install-npm.sh
$PACKAGES/install-gems.sh
