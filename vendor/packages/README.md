# Other Packages

After running the main install script, use these scripts to install additional
packages.

## `install.sh`

Calls all other install scripts in the appropriate order.

## `install-gems.sh`

Uses system `ruby` and `sudo gem` to install a set of useful gems.

## `install-gh.sh`

Installs extensions for [`gh`].

## `install-npm.sh`

Installs global npm packages (cli tools). Requires `node` and `npm` to be
installed.

## `install-pip.sh`

Uses system `python` and `easy_install` to install `pip` to install a set of
useful eggs.

## `install-nvim.sh`

Installs neovim plugins and Treesitter parsers.

## `install-mac.sh`

Installs Homebrew (if necessary) and installs everything listed in `Brewfile`.
Exits if not running on macOS.

### QuickLook Plugins and Quarantine

To see the quarantine status of installed QuickLook plugins:

```sh
xattr -r ~/Library/QuickLook/QL* -d com.apple.quarantine
```

To remove quarantine from QuickLook plugins:

```sh
xattr -r -d com.apple.quarantine ~/Library/QuickLook/QL*
```

[`gh`]: https://github.com/cli/cli "GitHub's official command line tool"
