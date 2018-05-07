#!/bin/bash
CLONE_DIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
git clone https://github.com/jwilm/alacritty.git $CLONE_DIR
cd $CLONE_DIR
rustup override set stable
rustup update stable
cargo build --release
make app
cp -r target/release/osx/Alacritty.app /Applications/Alacritty.app
