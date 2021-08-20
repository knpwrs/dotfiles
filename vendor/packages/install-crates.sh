#!/usr/bin/env zsh
curl https://sh.rustup.rs -sSf | sh -s -- -y

CARGO="$HOME/.cargo/bin/cargo"
RUSTUP="$HOME/.cargo/bin/rustup"

crates=(
  cargo-edit  # Add, remove, and upgrade cargo dependencies from the command line
  cargo-watch # Watch for file changes and run cargo commands
  hexyl       # A command-line hex viewer
  hyperfine   # A command-line benchmarking tool
  rm-improved # rip, a safer rm
  snm         # smol node manager
  tokei       # A fast cloc alternative
  zoxide      # A cd command that learns your habits
)

components=(
  rls
  rust-analysis
  rust-src
  rustfmt
)

$RUSTUP component add "${components[@]///}"
$CARGO install "${crates[@]///}"
