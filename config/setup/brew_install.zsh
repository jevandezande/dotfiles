#!/usr/bin/env zsh

brew_progs=(
    htop
    imagemagick
    node
    openjpeg
    openssl
    rcm
    wget
    zplug
)

brew tap homebrew/cask-fonts

casks=(
    gimp
    inkscape
    font-UbuntuMono-nerd-font
)

for prog in ${brew_progs[@]}
do
    brew install $prog
done

# Casks only work on MacOS
if [ $(uname) = "Darwin" ]
then
    for prog in ${casks[@]}
    do
        brew install --cask $prog
    done
fi
