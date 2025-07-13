#!/usr/bin/env zsh
curl https://sh.rustup.rs -sSf | sh -s -- -y

CARGO="$HOME/.cargo/bin/cargo"
RUSTUP="$HOME/.cargo/bin/rustup"

crates=(
  cargo-edit  # Add, remove, and upgrade cargo dependencies from the command line
  cargo-watch # Watch for file changes and run cargo commands
  difftastic  # Syntax-aware diff tool
  eza         # A modern replacement for ls
  hexyl       # A command-line hex viewer
  hyperfine   # A command-line benchmarking tool
  pik         # An interactive TUI for killing processes
  rm-improved # rip, a safer rm
  toipe       # Terminal-based typing test
  tokei       # A fast cloc alternative
  zoxide      # A cd command that learns your habits
)

components=(
  rust-analysis
  rust-src
  rustfmt
)

$RUSTUP component add "${components[@]///}"
$CARGO install "${crates[@]///}"
