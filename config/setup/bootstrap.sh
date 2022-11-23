#!/usr/bin/env sh

# Run script as root if not already.
if [ $EUID -ne 0 ];
then
    exec sudo REAL_USER=${LOCAL_USER} /usr/bin/env bash "$0" "$@"
fi

if [ $(uname) = "Linux" ]
then
    sudo apt update
    sudo apt install git zsh -y

    git clone https://github.com/jevandezande/dotfiles ~/.dotfiles
    ln -s ~/.dotfiles/zsh ~/.zsh
    ln -s ~/.dotfiles/zshrc ~/.zshrc

    export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin

    zsh ~/.dotfiles/config/setup/ubuntu_install.zsh
else
    echo "Unable to setup $(uname)"
fi
