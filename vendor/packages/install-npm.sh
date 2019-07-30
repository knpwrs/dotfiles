#!/usr/bin/env zsh

hash npm 2>/dev/null || { echo "Please install node and npm before installing global npm packages." && exit 0; }

packages=(
  browser-run                      # Runs JavaScript in a browser and sends the console logs to stdout.
  bundle-size                      # Show bundle size of npm packages.
  dev-time-cli                     # Get the current local time of a GitHub user.
  empty-trash-cli                  # Empty trash.
  internal-ip                      # Show internal IP address.
  is-online-cli                    # Check if the Internet connection is up.
  is-up-cli                        # Check if a website is up or down using ititup.org.
  javascript-typescript-langserver # Language server for JavaScript and TypeScript.
  jay-repl                         # Supercharged JavaScript REPL.
  lice                             # License generator.
  license-checker                  # Checks licenses for node app dependencies.
  live-server                      # Live-reloading static dev server.
  localtunnel                      # Simple tool to expose a local port over public dns.
  matrix-rain                      # Fill your terminal with falling green text.
  modhelp                          # Display README for any NPM module in terminal.
  nd                               # CLI markdown viewer.
  neovim                           # Neovim Node provider.
  np                               # Better npm publish.
  npm-merge-driver                 # git merge driver for resolving conflicts in npm-related files
  npm-name-cli                     # Check if a package name is available on npm.
  npm-quick-run                    # Quickly run npm scripts by prefix without typing the full name.
  nws                              # Node web server.
  oji                              # Text emoticons maker.
  pageres-cli                      # Capture screenshots of websites at various resolutions.
  pen.md                           # Hot-loading markdown preview server.
  public-ip-cli                    # Show public IP address.
  recursive-blame                  # Recursively blame a file in git.
  replem                           # Quickly try nodejs modules in a repl.
  rocky-cli                        # HTTP(S) proxy with websocket and replay support.
  serve                            # Static web server with directory listings.
  speed-test                       # CLI speed test client.
  tfa                              # CLI two-factor authentication client.
  trash-cli                        # Move files to trash.
  ttystudio                        # Record terminal to GIF.
)

npm i -g "${packages[@]///}"
