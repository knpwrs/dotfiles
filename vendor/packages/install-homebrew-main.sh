#!/usr/bin/env zsh

taps=(
  neovim/neovim # Neovim tap
)

formulae=(
  ack           # Grep for source code.
  archey        # "About this Mac" CLI.
  aria2         # Multi-protocol download client.
  ccat          # cat with syntax highlighting.
  cloc          # Count lines of code in a directory.
  coreutils     # GNU core utilities (Mac is BSD).
  cowsay        # Configurable talking characters in ASCII art.
  ctags         # Reimplementation of ctags(1).
  curl          # HTTP client.
  diff-so-fancy # Fancy diff for git.
  direnv        # Shell environment switcher.
  duck          # Cyberduck CLI.
  exiftool      # Image exif manipulation.
  ffmpeg        # Play, record, convert, and stream audio and video.
  figlet        # Make large letters out of ordinary text.
  fzf           # Fuzzy finder.
  git           # Distributed revision control system.
  git-cal       # Visual commits calendar for git.
  git-extras    # Extra git commands.
  git-imerge    # Incremental merge helper for git.
  git-lfs       # Git extension for versioning large files.
  git-open      # Open the GitHub page or website for the current repository.
  gnu-sed       # GNU version of the sed utility.
  gnu-tar       # GNU version of the tar utility.
  gnupg         # GNU Pretty Good Privacy (PGP) package.
  graphviz      # Rich set of graph drawing tools.
  httpie        # cURL-like tool for humans.
  imagemagick   # CLI image manipulation utilities.
  jq            # SED for JSON.
  mas           # Mac App Store CLI
  mitmproxy     # Intercept, modify, replay, save HTTP/S traffic.
  mpg123        # MP3 player for Linux and UNIX.
  mycli         # MySQL CLI with autocomplete and syntax highlighting.
  neovim        # Neovim
  netcat        # Utility for managing network connections.
  ngrep         # Network grep.
  nyancat       # Nyancat in your terminal, rendered through ANSI escape sequences.
  pgcli         # PostgreSQL CLI with autocomplete and syntax highlighting.
  python3       # Python 3
  ranger        # File browser.
  siege         # HTTP regression testing and benchmarking utility
  sift          # Fast and powerful alternative to grep.
  ssh-copy-id   # Add a public key to a remote machine's authorized_keys file.
  sshuttle      # Proxy server that works as a poor man's VPN.
  tig           # Text-mode interface for git.
  tmux          # Terminal multiplexer.
  tree          # Display directories as trees (with optional color/HTML output).
  vim           # Vi \"workalike\" with many additional features.
  wget          # Internet file retriever.
  woof          # Simple one-off HTTP file sharing.
  youtube-dl    # Download youtube videos.
  zsh           # UNIX shell (command interpreter).
)

brew tap "${taps[@]///}"
brew install "${formulae[@]///}"
