# dotfiles

I have almost everything configured to use some variant of the gruvbox theme.

The keyboard repo contains code for using the event interface through
python-evdev to contruct arbitrary keyboard layouts. Its undocumented right now.

## Installation

This repo should be cloned into the home directory.
Stow is used for installation, so existing files will never be deleted.
To install everything run `./install.sh`. See `./install.sh -h` for options.

### Notes

It is possible to install nvim without root using
[this approach](https://github.com/neovim/neovim/wiki/Installing-Neovim#Linux).

I am not making these parts into a script because it should probably be run at
most several lines at a time. Some lines require user input.

### Arch

See arch_install.md

```
yay -Syu
yay -S python-wheel
# note, includes many language specific installs, reduce as needed
yay -S i3 xorg xorg-xinit nvidia nvidia-utils qutebrowser python3 rustup fd \
  ripgrep bat zathura compton xdotool picom aur/nerd-fonts-hack unclutter \
  aur/twmn-git hsetroot xsel curl sqlite xcalib cmake flameshot mpv stow \
  openvpn pandoc inotify-tools bpython youtube-dl py3status python-pip \
  neovim-remote python-pynvim python-evdev aur/python-bidict \
  community/python-watchdog aur/openpyn-nordvpn aur/flashfocus-git aur/nvm \
  bash-language-server community/yarn aur/ruby-neovim \
  aur/nodejs-neovim sd exa vimiv boost watchman ccls aur/bear \
  boost eigen gdb ttf-roboto zathura-pdf-poppler pulseaudio pulseaudio-alsa \
  alsa-utils pavucontrol aur/cmake-format aur/cmake-lint opam xfce4-terminal

# consider also aur/cmake-lint
# Currently failing (and not important): aur/insect and aur/dbg-macro

# consider ocaml installs
opam init && opam install ocaml-lsp-server && opam install utop

# consider also toml format
yarn global add --dev prettier prettier-plugin-toml --dev --exact &&
  yarn global upgrade

pip3 install recordclass

# slow install packages to install later
yay -S aur/cling clang texlive-most

# swapfile
sudo dd if=/dev/zero of=/swapfile bs=1M count=16384 status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# add '/swapfile none swap defaults 0 0'
se /etc/fstab
```

Note: install watchman potentially.

After running general installs:
```
npm i -g tldr bash-language-server neovim
```


### General

```
./change_directory_names.sh
ln -sfn "$PWD/user-dirs.dirs" ~/.config
sudo cp "root_configs/etc/udev/rules.d/85-input.rules" \
  /etc/udev/rules.d/
sudo cp "root_configs/etc/modules-load.d/uinput.conf" \
  /etc/modules-load.d/
sudo usermod -aG input $USER
curl -L -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
./install.sh main
source ~/.profile
nvm install --lts
source ~/.profile
nvim +PlugInstall +qa
cd ~/.fzf && ./install --all && cd -
bat cache --build
sudo cp root_configs/usr/local/bin/env_editor /usr/local/bin/env_editor &&
  sudo ln -sf /usr/local/bin/env_editor /usr/bin/editor
cd ~/.local/share/nvim/plugged/sneak-quick-scope/src && ./build.sh &&
  cp sneak_quick_scope ~/.local/bin && cd -
```

Consider changing to

```
GRUB_CMDLINE_LINUX_DEFAULT="text mitigations=off"
```

in `/etc/default/grub`.
Additional language servers and watchmen for coc may also be desirable.
Consider running:

```
echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_watches &&
  echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_queued_events &&
  echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_instances &&
  watchman shutdown-server && sudo sysctl -p
```

The following can speed up boot time

```
sudo systemctl disable NetworkManager-wait-online.service
```

Not sure how needed these are...
```
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
# just improves multiuser times?
sudo systemctl enable nvidia-persistenced.service
```


Considering installing
[cling](https://github.com/root-project/cling#installation).
Consider installing lld (the LLVM Linker) and setting it as default
by symlinking to ~/.local/bin.
