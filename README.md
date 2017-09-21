## .zuko

Settings for my personal development environment.

1. [System](#system)
    * [SSH Config](#ssh-config)
    * [Keybindings](#keybindings)
    * [Fonts](#fonts)
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

### Keybindings

Use [Karabiner-Elements](https://pqrs.org/osx/karabiner/).

#### Windows Keyboard Profile for OSX
* `Left Command` -> `Left Option`
* `Left Control` -> `Left Command`
* `Left Option`  -> `Left Control`

#### Apple Keyboard Profile for OSX
* `Left Command` -> `Left Control`
* `Left Control` -> `Left Command`

### Fonts

* [Source Code Pro](https://github.com/adobe-fonts/source-code-pro)
    * Set as font in ITerm2

## Applications

Name      | Website                               | Description                |
----------|---------------------------------------|----------------------------|
Homebrew  | https://brew.sh                       | Package manager            |
ITerm2    | https://www.iterm2.com/               | More feature-full terminal |
Neovim    | https://neovim.io/                    | Modern Vim                 |
Ripgrep   | https://github.com/BurntSushi/ripgrep | Faster grep                |
Ranger    | http://ranger.nongnu.org              | Awesome file system client |
Viscosity | https://www.sparklabs.com/viscosity   | VPN client                 |
Insomnia  | https://insomnia.rest/                | Intuitive REST client      |

VPN provider: https://www.privateinternetaccess.com
Import VPN connection configurations into client from PIA

### ITerm2
* Grab [ITerm Themes](https://github.com/chriskempson/base16-iterm2) for [Base 16](https://github.com/chriskempson/base16)
    * Current Favorite: Base 16 Spacemacs
* Disable `CMD + R` (avoid accidentally resetting the terminal, vim, et al.)

For better Tmux integration...
* Swap left Command and Left Control
* Add action "don't remap modifier keys" for command + shift left/right so I can still navigate between windows
