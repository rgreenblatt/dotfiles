# dotfiles

I have almost everything configured to use some variant of the gruvbox theme.

The keyboard repo contains code for using the event interface through python-evdev to contruct arbitrary keyboard layouts. Its undocumented right now.

Submodules in this repo may not be on latest.

## Installation

This repo should be cloned into the home directory. 
Stow is used for installation, so existing files will never be deleted. 
To install everything run `./install.sh`.  See `./install.sh -h` for options.

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
yay -S i3 xorg xorg-xinit nvidia nvidia-utils qutebrowser python3 rustup fd \
  ripgrep bat zathura compton xdotool picom aur/nerd-fonts-hack unclutter \
  aur/twmn-git hsetroot xsel curl sqlite xcalib cmake flameshot mpv stow \
  openvpn pandoc inotify-tools bpython youtube-dl py3status python-pip \
  neovim-remote python-pynvim thefuck python-evdev aur/python-bidict \
  community/python-watchdog aur/openpyn-nordvpn aur/flashfocus-git aur/nvm \
  bash-language-server community/yarn aur/ruby-neovim \
  aur/nodejs-neovim sd exa vimiv boost watchman ccls aur/bear \
  boost eigen gdb ttf-roboto zathura-pdf-poppler pulseaudio pulseaudio-alsa \
  alsa-utils pavucontrol

# Currently failing (and not important): aur/insect and aur/dbg-macro

pip3 install cmakelint recordclass

# large packages to install later
yay -S aur/cling clang texlive-most 

# swapfile
sudo dd if=/dev/zero of=/swapfile bs=1M count=16384 status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# add '/swapfile none swap defaults 0 0'
se /etc/fstab
```

### Ubuntu

```
sudo apt update
sudo apt install git build-essential i3 python3-pip python-pip zathura \
  compton xdotool subversion openssh-server ruby-dev curl sqlite3 libx11-dev \
  libxft-dev xsel xcalib cmake flameshot mpv openvpn hsetroot \
  unclutter stow pandoc inotify-tools poppler-utils qtcreater fonts-roboto
sudo add-apt-repository ppa:neovim-ppa/unstable && sudo apt install neovim
mkdir install
cd install
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh
mkdir patched-fonts
cd patched-fonts
svn export https://github.com/ryanoasis/nerd-fonts/trunk/patched-fonts/Hack
cd ..
chmod +x install.sh
./install.sh
pip3 install pynvim neovim-remote thefuck evdev bidict watchdog recordclass \
  rtv cmakelint py3status youtube-dl tox bpython
sudo python3 -m pip install --upgrade openpyn
sudo openpyn --init
pip2 install pynvim
sudo apt-get install libxcb-render0-dev libffi-dev python-dev python-cffi && \
  pip3 install flashfocus
sudo gem install neovim
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh \
  | bash
curl -o- -L https://yarnpkg.com/install.sh | bash
curl https://sh.rustup.rs -sSf | sh -s -- -y
~/.cargo/bin/cargo install bat exa ripgrep fd-find sd
sudo apt install -y  git-core gcc make autoconf yodl libncursesw5-dev texinfo \
  man-db
git clone https://github.com/zsh-users/zsh && cd zsh && ./Util/preconfig && \
  ./configure --prefix=/usr \
    --mandir=/usr/share/man \
    --bindir=/bin \
    --infodir=/usr/share/info \
    --enable-maildir-support \
    --enable-max-jobtable-size=256 \
    --enable-etcdir=/etc/zsh \
    --enable-function-subdirs \
    --enable-site-fndir=/usr/local/share/zsh/site-functions \
    --enable-fndir=/usr/share/zsh/functions \
    --with-tcsetpgrp \
    --with-term-lib="ncursesw" \
    --enable-cap \
    --enable-pcre \
    --enable-readnullcmd=pager \
    --enable-custom-patchlevel=Debian \
    LDFLAGS="-Wl,--as-needed -g" && \
    make && make check && sudo make install && \
    command -v zsh | sudo tee -a /etc/shells && chsh -s $(command -v zsh) &&
    cd ..
git clone https://github.com/universal-ctags/ctags.git && cd ctags \
  && ./autogen.sh && ./configure && make && sudo make install && cd ..
git clone https://github.com/karlch/vimiv && cd vimiv && make && \
  sudo make install && cd ..
cd ..
cd ~/.local/etc/ && git clone https://github.com/qutebrowser/qutebrowser &&
  cd qutebrowser && python3 scripts/mkvenv.py && 
  { cat << 'EOF' > ~/.local/bin/qutebrowser_cmd
#!/usr/bin/env bash

~/.local/etc/qutebrowser/.venv/bin/python3 -m qutebrowser "$@"
EOF
  } && chmod +x ~/.local/bin/qutebrowser_cmd
sudo update-alternatives --config x-www-browser
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin && 
  ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/ && 
  cp ~/.local/kitty.app/share/applications/kitty.desktop \
  ~/.local/share/applications && (cd ~/.local/bin/ && 
  ln -s kitty x-terminal-emulator) && rm -rf ~/.config/kitty/
git clone https://github.com/sboli/twmn && cd twmn && qmake && make && \
  sudo make install && cd ..
```
Note: install watchman potentially.

After running general installs:
```
npm i -g tldr bash-language-server neovim
sudo update-alternatives --install /usr/bin/x-terminal-emulator \
  x-terminal-emulator /usr/local/bin/st 300
```

Consider running the following to remove ubuntu bloat:
```
sudo apt purge gnome*
sudo apt purge snapd ubuntu-core-launcher squashfs-tools
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
cd ~/.local/etc/st/ && make && sudo make install && cd -
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
Consider changing the contents of `/etc/sysctl.d/10-ptrace.conf` from `... = 1`
to `... = 0` (ubuntu).
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
Considering installing [cling](https://github.com/root-project/cling#installation).
Consider installing lld (the LLVM Linker) and setting it as default using
`update-alternatives`.
