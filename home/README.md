# Linked Dotfiles

## zsh

Files are `source`d in the following order:

1. `/etc/zshenv`
1. `~/.zshenv`
1. `/etc/zprofile`
1. `~/.zprofile`
1. `/etc/zshrc`
1. `~/.zshrc`
1. `/etc/zlogin`
1. `~/.zlogin`
1. `~/.zlogout`
1. `/etc/zlogout`

### `.zshenv`

This file is sourced by all instances of `zsh`. It should be kept as small as
possible, preferrably only defining environment variables.

### `.zprofile`

This file is similar to zlogin, but it is sourced before zshrc. See the
description of zlogin below for what it may contain.

### `.zshrc`

This file is sourced by interactive shells. It should define aliases,
functions, shell options, and key bindings.

### `.zlogin`

This file is sourced by login shells after zshrc, and thus, it should contain
commands that need to execute at login. It is usually used for messages or for
the creation of files.

This is not the file to define aliases, functions, shell options, and key
bindings. It should not change the shell environment.
