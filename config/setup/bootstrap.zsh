#!/usr/bin/env zsh

git clone https://github.com/jevandezande/dotfiles ~/.dotfiles

if [ $(uname) = "Linux" ]
then
    zsh ~/.dotfiles/config/setup/ubuntu_install.zsh
else
    echo "Unable to setup $(uname)"
fi
