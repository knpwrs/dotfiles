#!/usr/bin/env zsh
curl https://sh.rustup.rs -sSf | sh -s -- -y

CARGO="$HOME/.cargo/bin/cargo"
RUSTUP="$HOME/.cargo/bin/rustup"

crates=(
  cargo-watch # Watch for file changes and run cargo commands
  racer     # Code completion for rust
  hyperfine # A command-line benchmarking tool
)

$CARGO add component rust-src
$CARGO install "${crates[@]///}"
