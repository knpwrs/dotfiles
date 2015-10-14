# Other Packages

After running the main install script, use these scripts to install additional
packages.

## `install.sh`

Simply calls `./homebrew/install.sh`, `./npm/install.sh`, and
`./gems/install.sh`.

## `./homebrew/install.sh`

Installs Homebrew (if necessary) and installs all packages listed in
`./homebrew/packages-homebrew`, `./homebrew/packages-cask`, and
`./homebrew/packages-cask-ql`.

## `./npm/install.sh`

Installs `nvm`, `node`, and `npm` (if necessary) and installs all packages
listed in `./npm/packages`.

## `./gems/install.sh`

Uses system `ruby` and `sudo gem` to install packages listed `gems/packages`.
