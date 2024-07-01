#!/usr/bin/env zsh

if [ $(uname) = "Linux" ]
then
  dir=~/.dotfiles/local/share/fonts
elif [ $(uname) = "Darwin" ]
then
  dir="~/Library/Fonts"
else
  echo "Unable to setup fonts for $(uname)"
  exit
fi

if [ ! -d $dir ]
then
  mkdir -p $dir
fi

pushd $dir
  curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
popd
