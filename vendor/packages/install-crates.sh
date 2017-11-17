#!/usr/bin/env zsh
curl https://sh.rustup.rs -sSf | sh -s -- -y

CARGO="$HOME/.cargo/bin/cargo"
RUSTUP="$HOME/.cargo/bin/rustup"

crates=(
  racer # Code completion for Rust
)

$CARGO add component rust-src
$CARGO install "${crates[@]///}"
