#!/usr/bin/env zsh
curl https://sh.rustup.rs -sSf | sh -s -- -y

CARGO="$HOME/.cargo/bin/cargo"
RUSTUP="$HOME/.cargo/bin/rustup"

crates=(
  cargo-edit  # Add, remove, and upgrade cargo dependencies from the command line
  cargo-watch # Watch for file changes and run cargo commands
  hyperfine   # A command-line benchmarking tool
  racer       # Code completion for rust
)

$CARGO add component rust-src
$CARGO install "${crates[@]///}"
