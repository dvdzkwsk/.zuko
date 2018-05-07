<div align="center">
  <h1>.zuko</h1>
  <p>My personal, portable development environment.</p>
</div>

```sh
git clone https://github.com/davezuko/.zuko && cd .zuko && chmod +x ./make.sh && ./make.sh
```

## Table of Contents

1. [System](#system)
    * [SSH Config](#ssh-config)
    * [Keybindings](#keybindings)
2. [Applications](#applications)
    * [ITerm2](#iterm2)
3. [Troubleshooting](#troubleshooting)

## System

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

## Applications

Name      | Website                               | Description                |
----------|---------------------------------------|----------------------------|
Viscosity | https://www.sparklabs.com/viscosity   | VPN client                 |

VPN provider: https://www.privateinternetaccess.com
Import VPN connection configurations into client from PIA

### ITerm2
* Disable `CMD + R` (avoid accidentally resetting the terminal, vim, et al.)
* [Enable Italics Support in Vim](https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/)

For better Tmux integration...
* Swap left Command and Left Control
* Add action "don't remap modifier keys" for command + shift left/right so I can still navigate between windows

To get italics working, see https://github.com/jwilm/alacritty/issues/489. For Fira Mono italics, use the following fork: https://github.com/zwaldowski/Fira/tree/zwaldowski/mod-new/otf.

Issues with True Color? See https://bruinsslot.jp/post/how-to-enable-true-color-for-neovim-tmux-and-gnome-terminal/.g

## Troubleshooting

### Tmux complains about nvm/npm

Make sure `node` is not installed via brew, and delete `/usr/local/bin/npm` if it exists. This often gets re-created after a brew update, it seems.
