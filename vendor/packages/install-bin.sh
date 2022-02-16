#!/usr/bin/env zsh

mkdir -p $HOME/bin

# Requires rlwrap
curl https://cht.sh/:cht.sh -o $HOME/bin/cht.sh && chmod +x $HOME/bin/cht.sh
