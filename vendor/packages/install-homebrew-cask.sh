#!/usr/bin/env zsh

casks=(
  alfred                    # Power-user spotlight.
  atom                      # Open source hackable text editor from GitHub.
  beardedspice              # More control over keyboard media keys.
  bettertouchtool           # Advanced system touch gesture control.
  beyond-compare            # Advanced diff and compare tool.
  bit-slicer                # Universal game trainer.
  caprine                   # Unofficial Facebook Messenger client.
  cheatsheet                # Hold the ⌘-key to get a list of all active shortcuts for the current application.
  firefox                   # Web browser from Mozilla.
  gas-mask                  # Manage and switch between multiple hosts files.
  gitify                    # GitHub desktop notifications.
  google-chrome             # Web browser from Google.
  google-drive              # File sync / backup from Google.
  handbrake                 # Video conversion utility.
  handbrakecli              # CLI for Handbrake.
  keka                      # Archive extraction and creation.
  sketch                    # Professional Digital Design for Mac
  slack                     # Chat client for teams.
  telegram                  # Telegram messaging client.
  vagrant                   # Development environment virtual machines.
  vagrant-manager           # Manage vagrant machines from native Mac UI.
  virtualbox                # Open source virtual machines.
  virtualbox-extension-pack # Extensions for Virtual Box.
  visual-studio-code        # Electron-based text editor from Microsoft.
  vlc                       # Open source media player.
)

brew cask install "${casks[@]///}"
