#!/usr/bin/env zsh

if [ ! -d $HOME/.nvm ]; then
  git clone https://github.com/creationix/nvm.git $HOME/.nvm && pushd $HOME/.nvm && git checkout `git describe --abbrev=0 --tags` && popd
  source $HOME/.nvm/nvm.sh
  # nvm install stable && nvm alias default stable # Alias default stable slows down shell startup time https://github.com/creationix/nvm/issues/860
  nvm install stable
  echo "---"
  echo "!!! Please restart zsh or source $NVM_SH to start using node."
  echo "---"
else
  source $HOME/.nvm/nvm.sh
fi

packages=(
  browser-run     # Runs JavaScript in a browser and sends the console logs to stdout.
  bugger          # Chrome devtool bindings for node.
  david           # NPM dependency version checker.
  dev-time-cli    # Get the current local time of a GitHub user.
  empty-trash-cli # Empty trash.
  eslint          # JavaScript code linter.
  internal-ip     # Show internal IP address.
  is-online-cli   # Check if the Internet connection is up.
  is-up-cli       # Check if a website is up or down using ititup.org.
  jsome           # Pretty JSON viewer.
  license-checker # Checks licenses for node app dependencies.
  live-server     # Live-reloading static dev server.
  modhelp         # Display README for any NPM module in terminal.
  nd              # CLI markdown viewer.
  np              # Better npm publish.
  npm-name-cli    # Check if a package name is available on npm.
  npm-quick-run   # Quickly run npm scripts by prefix without typing the full name.
  node-inspector  # Node debugger.
  nws             # Node web server.
  pageres-cli     # Capture screenshots of websites at various resolutions.
  pen.md          # Hot-loading markdown preview server.
  pjs             # Pipeable JavaScript.
  public-ip       # Show public IP address.
  recursive-blame # Recursively blame a file in git.
  replem          # Quickly try nodejs modules in a repl.
  rocky-cli       # HTTP(S) proxy with websocket and replay support.
  speed-test      # CLI speed test client.
  tfa             # CLI two-factor authentication client.
  trash-cli       # Move files to trash.
  ttystudio       # Record terminal to GIF.
  vtop            # Visual top command.
)

npm i -g "${packages[@]///}"

