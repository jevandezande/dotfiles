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


repo="https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts"
pushd $dir
  # Droid Sans Mono
  curl -fLO $repo/DroidSansMono/DroidSansMNerdFont-Regular.otf

  # Meslo
  font_family="Meslo/"
  something="S"
  for emphasis in Bold Italic Regular Bold-Italic
  do
    curl -fLO $repo/$font_family/$something/$emphasis/MesloLG${something}NerdFontMono-$emphasis.ttf
  done
popd
