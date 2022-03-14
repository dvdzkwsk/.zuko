#!/bin/bash
# Provisions a fresh Ubuntu installation

# Ensure package manager is up to date
sudo apt-get update
sudo apt-get upgrade

# Change shell to zsh
chsh -s /usr/bin/zsh

# The Basics
sudo apt-get -y install build-essential git zsh tmux curl

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core utilities
brew install fasd bat hub neovim

# Install go
brew install go

# Install node
curl -L https://git.io/n-install | bash

# Install pnpm
sudo apt-get install build-essential
sudo snap install curl
curl -L https://git.io/n-install | bash
curl -fsSL https://get.pnpm.io/install.sh | sh

# Install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

# Install nginx
sudo apt-get -y install nginx

# Notes
#
# Map caps lock to escape
# $ gnome-tweaks
# Keyboard and Mouse → Additional Layout Options -> Caps Lock Behavior -> Make Caps Lock an additional Esc
#
# Change keyboard repeat rate
# Settings → Universal Access → Typing → Repeat Keys