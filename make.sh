#!/bin/bash
# vim: foldmethod=marker
sudo -v

# OSX ----------------------------------------------------- {{{
# Install available updates
sudo softwareupdate -iva
xcode-select --install

# Apply custom user settings
./bin/configure-osx.sh
#}}}

# Homebrew ------------------------------------------------ {{{
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade
#}}}

# Developer Tools ----------------------------------------- {{{
# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

brew cask install java
$(brew --prefix)/opt/fzf/install
brew install hub
brew install jq
brew install nvim
brew install ranger
brew install tree
brew install tty-clock
brew install zsh-completions
brew install fasd             # easily jump to commonly-used directories
brew install fzf              # general purpose fuzzy-finder
brew install htop             # better `top`
brew install tldr             # better `man`
brew install ripgrep          # better `grep`
brew install fd               # better `find`
brew install bat              # better `less` or `cat`
brew install tig              # better `git`
brew install diff-so-fancy    # better `git diff`

# gopass
brew install gopass
brew install pinentry-mac   # browserpass (browser extension) dependency

# tmux
brew install tmux
brew install reattach-to-user-namespace
#}}}

# Programming --------------------------------------------- {{{
brew install sbcl
brew install lumo
brew install python3
brew install yarn --without-node
#}}}

# Applications -------------------------------------------- {{{
brew cask install docker
brew cask install dropbox
brew cask install google-chrome
brew cask install brave
brew cask install slack
brew cask install flux
brew cask install gpg-suite
#}}}

# Fonts --------------------------------------------------- {{{
brew tap caskroom/fonts && brew cask install font-source-code-pro
#}}}

# Misc ------------------------------------------------ {{{
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Enable python3 support for nvim
pip3 install neovim

# Intall custom terminfo that enables italics support
tic ./config/xterm/xterm-256color-italic.terminfo
#}}}

# Dotfiles ------------------------------------------------ {{{
./bin/install-dotfiles.sh
#}}}
