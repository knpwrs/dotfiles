# Ken Powers' Dotfiles

These are my configuration files. Take a look at how I configure my shell and
feel free to use ideas or suggest improvements.

## Installation

1. Clone this repository to `$HOME/.dotfiles`.
1. Follow the instructions in the `etc` directory to set up system
   settings.
1. Run `./install.sh`.
1. Optionally follow the instructions in [`vendor/packages`] to install
   packages I use on a regular basis.

## Structure

Everything in `home` is linked to `$HOME/.$file`. Old links are overridden /
updated and dead links are deleted. `lib` contains any files which should not
necessarily be linked to in `$HOME`. `etc` contains configuration for various
terminal emulators. `vendor` contains subtrees for external repositories.

## Other Tips

If you need to accept the xcode license at any point for some reason:

```sh
sudo xcodebuild -license
```

[Homebrew]: http://brew.sh/ "Homebrew"
[`./vendor/packages`]: vendor/packages "./vendor/packages"
