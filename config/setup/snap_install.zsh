#!/usr/bin/env zsh
#########################
# Install snap programs #
#########################
snap_progs=(
    firefox             # Browser
    gimp                # Raster graphic editor
    inkscape            # Vector graphics editor
    keepassxc           # Password storage
    pycharm-community   # Python IDE
    spotify             # Music player
    valgrind            # Code checker
)

for prog in "${snap_progs[@]}"
do
    echo $prog
    snap install $prog
done
