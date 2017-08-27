## .zuko

Settings for my personal development environment.

## Steps
1. [System](#system)
    * [SSH Config](#ssh-config)
1. [System Keybindings](#system-keybindings)
1. [Applications](#applications)
    * [ITerm2](#iterm2)

## System

```shell
# Show hidden files in Finder
$ defaults write com.apple.finder AppleShowAllFiles -bool true

# Enable global key repeat
$ defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```

### SSH Config

Easily manage SSH identities.
* http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/

## System Keybindings

Use [Karabiner-Elements](https://pqrs.org/osx/karabiner/).

### Windows Keyboard Profile for OSX
* `Left Command` -> `Left Option`
* `Left Control` -> `Left Command`
* `Left Option`  -> `Left Control`

### Apple Keyboard Profile for OSX
* `Left Command` -> `Left Control`
* `Left Control` -> `Left Command`

## Applications

* [Homebrew](https://brew.sh) - Package manager
* [ITerm2](https://www.iterm2.com/) - More feature-full terminal
* [NeoVim](https://neovim.io/) - Modern Vim
* [ripgrep](https://github.com/BurntSushi/ripgrep) - Faster grep
* [ranger](http://ranger.nongnu.org) - File system navigation
* [viscosity](https://www.sparklabs.com/viscosity) - VPN client
  - VPN provider: https://www.privateinternetaccess.com
  - Import VPN connection configurations into client from PIA
* [insomnia](https://insomnia.rest/) - Intuitive REST client

### ITerm2
* Grab [ITerm Themes](https://github.com/chriskempson/base16-iterm2) for [Base 16](https://github.com/chriskempson/base16)
* Swap left Command and Left Control (Better Tmux)
* Add action "don't remap modifier keys" for command + shift left/right so I can still navigate between windows
