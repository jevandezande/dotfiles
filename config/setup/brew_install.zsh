#!/usr/bin/env zsh

brew_progs=(
    anaconda
    cmake
    htop
    inkscape
    imagemagick
    node
    openfortivpn
    openjpeg
    openssl
    rcm
    sqlite
    wget
    zplug
)

for prog in ${brew_progs[@]}
do
    brew install $prog
done
