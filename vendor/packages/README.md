# Other Packages

After running the main install script, use these scripts to install additional
packages.

## `install.sh`

Calls all other install scripts.

## `install-gems.sh`

Uses system `ruby` and `sudo gem` to install a set of useful gems.

## `install-npm.sh`

Installs `nvm`, `node`, and `npm` (if necessary) and then installs a set of
useful packages.

## `install-pip.sh`

Uses system `python` and `easy_install` to install `pip` to install a set of
useful eggs.

## `install-mac.sh`

Installs Homebrew (if necessary) and installs everything listed in `Brewfile`.
Exits if not running on macOS.
