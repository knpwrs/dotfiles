# Ken Powers' Dotfiles

These are my configuration files. Take a look at how I configure my shell and
feel free to use ideas or suggest improvements.

## Installation

1. Recursively clone this repository to `$HOME/.dotfiles`.
1. Run `./install.sh`.

## Structure

Everything in `home` is linked to `$HOME/.$file`. Old links are overridden /
updated. The install script does not delete dead links. `lib` contains any
files which should not necessarily be linked to in `$HOME`. `settings`
contains configuration for various terminal emulators. `vendor` contains
external submodules.

## Inspiration / Influence

Ideas have been borrowed / stolen from [oh-my-zsh][omz] and [prezto][p].

[omz]: https://github.com/robbyrussell/oh-my-zsh "oh-my-zsh"
[p]: https://github.com/sorin-ionescu/prezto "prezto"
