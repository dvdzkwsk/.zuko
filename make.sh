#!/bin/bash
# vim: foldmethod=marker
sudo -v

# OSX ----------------------------------------------------- {{{
# Install available updates
sudo softwareupdate -iva
xcode-select --install
#}}}

# Homebrew ------------------------------------------------ {{{
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade --all
#}}}

# Developer Tools ----------------------------------------- {{{
# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

brew install python3
brew install rg
brew install jq
brew install nvm
brew install tree
brew install yarn
brew install docker
brew install boot2docker
#}}}

# Applications -------------------------------------------- {{{
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" slack
#}}}

# Dotfiles ------------------------------------------------ {{{
./bin/install-dotfiles.sh
#}}}
