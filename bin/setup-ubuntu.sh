#!/bin/bash
# Provisions a fresh Ubuntu installation

# Ensure package manager is up to date
sudo apt-get update && apt-get -y upgrade

# The Basics
sudo apt-get -y install build-essential git zsh tmux curl

# Install Neovim
sudo apt-get -y install python-neovim python3-neovim neovim

# Install Node
curl -L https://git.io/n-install | bash

# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

# Install Nginx
sudo apt-get -y install nginx
