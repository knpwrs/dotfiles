#!/usr/bin/env zsh

hash npm 2>/dev/null || { echo "Please install node and npm before installing global npm packages." && exit 0; }

mkdir -p $WHALEBREW_INSTALL_PATH

packages=(
  tsub/graph-easy    # Convert or render graphs (as ASCII, HTML, SVG or via Graphviz)
  whalebrew/whalesay # Like cowsay but with a whale
)

echo "${packages[@]///}" | xargs -n1 whalebrew install
