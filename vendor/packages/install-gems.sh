#!/usr/bin/env zsh

echo "---"
echo "!!! sudo required to install gems using system ruby."
echo "---"

gems=(
  bropages           # Highly readable supplement to man pages.
  cocoapods          # Package manager for XCode projects.
  jekyll             # A static site generator.
  jekyll-paginate    # Pagination plugin for jekyll.
  lolcat             # (lol)cat
  octopress-debugger # A debugger for jeykll.
)

sudo gem install "${gems[@]///}"
