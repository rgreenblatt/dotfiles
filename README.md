# dotfiles

I am using the Hack font (patched for devicons), exa, bat, thefuck, feh, tldr, and ripgrep. 

I have almost everything configured to use some variant of the gruvbox theme.

The keyboard repo contains code for using the event interface through python-evdev to contruct arbitrary 
keyboard layouts. Its undocumented right now.

Submodules in this repo may not be on latest.

I am using an install script instead of stow because I want to have this directory structure and submodules.

### Installation

To install everything run `./install.sh`. To install everything for a headless install run `./install.sh -c`
