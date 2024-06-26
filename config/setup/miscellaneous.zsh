#!/usr/bin/env zsh

git init --initial-branch=master

# Install rust
if  ! type rustup > /dev/null
then
    echo "Installing rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi


activate-global-python-argcomplete


# Install NvChad
if [ ! -d ~/.config/nvim/lua ]
then
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
fi


if [ ! -d ~/.hidden ]
then
	# For default folder paths. See ~/.config/user-dirs.dirs
	mkdir ~/.hidden
fi
