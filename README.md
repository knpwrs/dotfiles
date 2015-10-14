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

```sh
./vendor/packages/install.sh
```

### [Homebrew]

Run the command above, or to just install [Homebrew] ([Cask]) packages:

```sh
./vendor/packages/install-homebrew.sh
```

Note: this also installs [Homebrew] (if necessary).

* `ack`
* `caskroom/cask/brew-cask`
* `cowsay`
* `ctags`
* `git`
* `git-lfs`
* `ranger`
* `ssh-copy-id`
* `tmux`
* `tree`
* `vim`
* `zsh`

#### [Cask][Cask]

##### Applications

* `atom`
* `alfred`
* `beyond-compare`
* `bit-slicer`
* `firefox`
* `google-chrome`
* `handbrake`
* `keka`
* `reaper`
* `vlc`

##### Quicklook Plugins ([More][qlplugins])

* `qlcolorcode`
* `qlstephen`
* `qlmarkdown`
* `quicklook-json`
* `qlprettypatch`
* `quicklook-csv`
* `betterzipql`
* `qlimagesize`
* `webpquicklook`
* `suspicious-package`
* `provisionql`

### NPM

Run the command above, or to just install NPM packages:

```sh
./vendor/packages/install-homebrew.sh
```

Note: this also installs `nvm`, `node`, and `npm` (if necessary).

* `jshint`
* `nd`
* `nws`

### Gems

```sh
./vendor/packages/install.sh
```

Note: this uses the system `ruby` and `sudo gem` to install packages.

* `bropages`

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
