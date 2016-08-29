#!/usr/bin/env zsh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

$DOTPACKAGES/homebrew/install.sh
$DOTPACKAGES/npm/install.sh
$DOTPACKAGES/install-gems.sh
$DOTPACKAGES/pip/install.sh
