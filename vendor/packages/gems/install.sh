#!/usr/bin/env zsh

echo "---"
echo "!!! sudo required to install gems using system ruby."
echo "---"

<$DOTPACKAGES/gems/packages cut -d' ' -f1 | xargs sudo gem install
