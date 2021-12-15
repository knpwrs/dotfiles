#!/usr/bin/env zsh

nvim +PackerSync +qall
nvim -e -c 'redir>>/dev/stdout | TSInstallSync all | redir END' -scq
