# Other Packages

After running the main install script, use these scripts to install additional
packages.

## `install.sh`

Calls all other install scripts.

## `./homebrew/install.sh`

Installs Homebrew (if necessary) and installs all packages listed in
`./homebrew/packages-homebrew`, `./homebrew/packages-cask`, and
`./homebrew/packages-cask-ql`.

## `./npm/install.sh`

Installs `nvm`, `node`, and `npm` (if necessary) and installs all packages
listed in `./npm/packages`.

## `install-gems.sh`

Uses system `ruby` and `sudo gem` to install a set of useful gems.
