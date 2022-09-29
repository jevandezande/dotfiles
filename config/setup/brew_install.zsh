#!/usr/bin/env zsh

if ! type brew > /dev/null
then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew_progs=(
    act
    gh
    htop
    node
    openjpeg
    openssl
)

brew tap homebrew/cask-fonts

casks=(
    gimp
    inkscape
    font-UbuntuMono-nerd-font
)

mac_only=(
    imagemagick
    rcm
    wget
    zplug
)

for prog in ${brew_progs[@]}
do
    brew install $prog
done

if [ $(uname) = "Darwin" ]
then
    for prog in ${mac_only[@]}
    do
        brew install $prog
    done

    # Casks only work on MacOS
    for prog in ${casks[@]}
    do
        brew install --cask $prog
    done
fi
