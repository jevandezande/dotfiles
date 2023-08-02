#!/usr/bin/env zsh

if [ $(uname) = "Linux" ]
then
  dir="~/.dotfiles/local/share/fonts"
elif [ $(uname) = "Darwin" ]
  dir="~/Library/Fonts"
else
  echo "Unable to setup fonts for $(uname)"
  exit
fi

pushd $dir
  curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
popd
