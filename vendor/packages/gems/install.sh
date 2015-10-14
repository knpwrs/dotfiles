#!/usr/bin/env zsh

echo "---"
echo "!!! sudo required to install gems using system ruby."
echo "---"

<$DOTPACKAGES/gems/packages xargs sudo gem install
