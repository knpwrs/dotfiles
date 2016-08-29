# Other Packages

After running the main install script, use these scripts to install additional
packages.

## `install.sh`

Calls all other install scripts.

## `install-npm.sh`

Installs `nvm`, `node`, and `npm` (if necessary) and then installs a set of
useful packages.

## `install-gems.sh`

Uses system `ruby` and `sudo gem` to install a set of useful gems.

## `install-pip.sh`

Uses system `python` and `easy_install` to install `pip` to install a set of
useful eggs.

## `install-homebrew.sh`

Installs Homebrew (if necessary) and calls all of the `install-homebrew-*.sh`
scripts. Exits if not running on macOS.

### `install-homebrew-main.sh`

Packages from [`homebrew/homebrew-core`][hbc].

### `install-homebrew-dupes.sh`

Packages from [`homebrew/homebrew-dupes`][hbd].

### `install-homebrew-cask.sh`

Packages from [`caskroom/homebrew-cask`][caskroom]

### `install-homebrew-cask-ql.sh`

Quicklook plugins [`caskroom/homebrew-cask`][caskroom].

### `install-homebrew-cask-fonts.sh`

Fonts from [`caskroom/homebrew-fonts`][hbf].

### `install-homebrew-games.sh`

Games from [`homebrew/homebrew-games`][hbg].

### `install-homebrew-external.sh`

Other various packages from the homebrew ecosystem.


[hbc]: https://github.com/homebrew/homebrew-core "homebrew/homebrew-core"
[hbd]: https://github.com/homebrew/homebrew-dupes "homebrew/homebrew-dupes"
[caskroom]: https://github.com/caskroom/homebrew-cask "caskroom/homebrew-cask"
[hbf]: https://github.com/caskroom/homebrew-fonts "caskroom/homebrew-fonts"
[hbg]: https://github.com/homebrew/homebrew-games "homebrew/homebrew-games"
