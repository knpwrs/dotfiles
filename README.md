# Ken Powers' Dotfiles

These are my configuration files. Take a look at how I configure my shell and
feel free to use ideas or suggest improvements.

## Installation

1. Clone this repository to `$HOME/.dotfiles`.
1. Follow the instructions in the `settings` directory to set up system
   settings.
1. Run `./install.sh`.
1. Optionally follow the instructions in `vendor/packages/` to install packages
   I use on a regular basis.

## Structure

Everything in `home` is linked to `$HOME/.$file`. Old links are overridden /
updated and dead links are deleted. `lib` contains any files which should not
necessarily be linked to in `$HOME`. `settings` contains configuration for
various terminal emulators. `vendor` contains subtrees for external
repositories.

## Other Packages to Install

See [`./vendor/packages`].

## Inspiration / Influence

Ideas have been borrowed / stolen from:

* [ivim]
* [oh-my-zsh]
* [prezto]

## Other Tips

If you need to accept the xcode license at any point for some reason:

```sh
sudo xcodebuild -license
```

[Homebrew]: http://brew.sh/ "Homebrew"
[Cask]: https://github.com/caskroom/homebrew-cask "Homebrew Cask"
[ivim]: https://github.com/kepbod/ivim "ivim"
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh "oh-my-zsh"
[prezto]: https://github.com/sorin-ionescu/prezto "prezto"
[qlplugins]: https://github.com/sindresorhus/quick-look-plugins "quick-look-plugins"
[`./vendor/packages`]: vendor/packages "./vendor/packages"
