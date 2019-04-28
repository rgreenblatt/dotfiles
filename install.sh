#!/bin/bash

headless="false"

echo "$@" > target

# Parse options
while getopts ":hc" opt; do
  case ${opt} in
    h )
      echo "Usage:"
      echo "    ./install.sh [target]"
      echo ""
      echo "    ./install.sh -h           Display this help message."
      echo "    ./install.sh -c           Install for a headless system."
      exit 0
      ;;
    c )
      echo "Installing headless"
      headless="true"
      ;; 
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

shopt -s dotglob nullglob

git submodule init > /dev/null
git submodule update --recursive --remote > /dev/null
mkdir -p ~/.config/

target=$1; shift  # Remove 'install.sh' from the argument list
case "$target" in
  main)
    ln -sfn $PWD/additional/main/* ~/
    ;;
  brown_cs)
    ln -sfn $PWD/additional/brown_cs/* ~/
    ;;
  brown_ccv)
    ln -sfn $PWD/additional/brown_ccv/* ~/
    ;;
  devbox)
    ln -sfn $PWD/additional/devbox/* ~/
    ;;
  "")
    ;;
  *)
    echo "Invalid target."
    exit 1
    ;;
esac

ln -sfn $PWD/nvim ~/.config/
ln -sfn $PWD/bat ~/.config/
ln -sfn $PWD/scripts ~/
ln -sfn $PWD/.profile ~/
ln -sfn $PWD/.cvsignore ~/
ln -sfn $PWD/.gitconfig_base ~/

if [[ "$headless" == "false" ]]; then
  echo "Installing headed"
    ln -sfn $PWD/i3 ~/.config/
    ln -sfn $PWD/i3status ~/.config/
    ln -sfn $PWD/keyboard ~/
    ln -sfn $PWD/qutebrowser ~/.config/
    ln -sfn $PWD/compton ~/.config/
    mkdir -p ~/.local/etc/
    ln -sfn $PWD/st ~/.local/etc/
    ln -sfn $PWD/zathura ~/.config/
    mkdir -p ~/.local/share/
    ln -sfn $PWD/applications ~/.local/share/
fi 

mail="MAILTO=ryan_greenblatt@brown.edu\n"
install_job="0 2 * * * cd $PWD && ./check_git_install.sh"

(crontab -l 2>/dev/null; echo "$mail$install_job") | crontab -

if hash zsh 2> /dev/null; then
  echo "zsh is installed"
    if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then 
        echo ".zshrc must be deleted or moved before install"
        exit 1
    fi
    if [ -f "$HOME/.zimrc" ] && [ ! -L "$HOME/.zimrc" ]; then 
        echo ".zimrc must be deleted or moved before install"
        exit 1
    fi
    ./zimfw/install.sh > /dev/null
    rm -f ~/.zshrc ~/.zimrc
    ln -sfn $PWD/.zshrc ~/
    ln -sfn $PWD/.zimrc ~/
fi
