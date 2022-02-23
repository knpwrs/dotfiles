#!/usr/bin/env zsh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

$DOTPACKAGES/install-mac.sh
$DOTPACKAGES/install-zsh.sh
$DOTPACKAGES/install-crates.sh
$DOTPACKAGES/install-npm.sh
$DOTPACKAGES/install-gems.sh
$DOTPACKAGES/install-pip.sh
$DOTPACKAGES/install-gh.sh
$DOTPACKAGES/install-bin.sh
