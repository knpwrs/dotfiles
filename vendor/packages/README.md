# Other Packages

After running the main install script, use these scripts to install additional
packages.

## `install.sh`

Simply calls `install-homebrew.sh`, `install-npm.sh`, and `install-gems.sh`.

## `install-homebrew.sh`

Installs Homebrew (if necessary) and installs all homebrew packages listed in
the root `README.md`.

## `install-npm.sh`

Installs `nvm`, `node`, and `npm` (if necessary) and installs all `npm` packages
listed in the root `README.md`.

## `install-gems.sh`

Uses system `ruby` and `sudo gem` to install packages listed in the root
`README.md`.
