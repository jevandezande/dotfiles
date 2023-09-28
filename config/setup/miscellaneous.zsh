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
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
