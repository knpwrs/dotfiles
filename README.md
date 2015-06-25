# Ken Powers' Dotfiles

These are my configuration files. Take a look at how I configure my shell and
feel free to use ideas or suggest improvements.

## Installation

1. Clone this repository to `$HOME/.dotfiles`.
1. Install necessary system fonts / themes in the `settings` directory.
1. Run `./install.sh`.

## Structure

Everything in `home` is linked to `$HOME/.$file`. Old links are overridden /
updated and dead links are deleted. `lib` contains any files which should not
necessarily be linked to in `$HOME`. `settings` contains configuration for
various terminal emulators. `vendor` contains subtrees for external
repositories.

## Other Packages to Install

### Homebrew

* `cowsay`
* `ctags`
* `ranger`
* `ssh-copy-id`
* `tmux`
* `tree`
* `vim`
* `zsh`

### NPM

* `jshint`
* `nd`

## Inspiration / Influence

Ideas have been borrowed / stolen from:

* [ivim][ivim]
* [oh-my-zsh][omz]
* [prezto][p]

[ivim]: https://github.com/kepbod/ivim "ivim"
[omz]: https://github.com/robbyrussell/oh-my-zsh "oh-my-zsh"
[p]: https://github.com/sorin-ionescu/prezto "prezto"
