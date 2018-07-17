#!/bin/bash
# Provisions an Ubuntu box

# Enforce sudo
sudo -v

# Ensure package manager is up-to-date
apt-get update && apt-get -y upgrade

# Install Node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source ~/.bashrc
nvm install --lts

# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt-get -y install yarn y --no-install-recommends

# Install Neovim
apt-get -y install python-neovim python3-neovim neovim

# Install Nginx
apt-get -y install nginx
