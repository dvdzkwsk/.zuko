## .zuko

Settings for my personal development environment.

## Steps
1. [System](#system)
1. [Bash](#bash)
1. [Homebrew](#homebrew)
1. [Git](#git)
1. [Node](#node)
1. [Iterm2](#iterm)
1. [NeoVim](#neovim)
1. [Visual Studio Code](#visual-studio-code)
1. [Update System Keybindings](#system-keybindings)
1. [SSH Config](http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/)
1. [VPN](#vpn)

## System

```shell
# Show hidden files in Finder
$ defaults write com.apple.finder AppleShowAllFiles -bool true

# Enable global key repeat
$ defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```
## Bash

## Homebrew

## Git

## NeoVim

## System Keybindings

Use [Karabiner-Elements](https://pqrs.org/osx/karabiner/).

### Windows Keyboard Profile for OSX
* Left Command -> Left Option
* Left Control -> Left Command
* Left Option -> Left Control

### Apple Keyboard Profile for OSX
* Left Command -> Left Control
* Left Control -> Left Command

## Iterm
* Swap left Command and Left Control (Better Tmux)
* Add action "don't remap modifier keys" for command + shift left/right so I can still navigate between windows

## VPN

* VPN provider: https://www.privateinternetaccess.com
* VPN client: https://www.sparklabs.com/viscosity/

Import VPN connection configurations into client from PIA.
