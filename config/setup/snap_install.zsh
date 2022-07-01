#!/usr/bin/env zsh

#########################
# Install snap programs #
#########################

snap_progs=(
    gimp                # Raster graphic editor
    inkscape            # Vector graphics editor
    keepassxc           # Password storage
    spotify             # Music player
)

for prog in "${snap_progs[@]}"
do
    echo $prog
    snap install $prog
done
