#!/usr/bin/env zsh

if ! type pixi > /dev/null
then
    echo "Installing Pixi"
    curl -fsSL https://pixi.sh/install.sh | bash
fi

pixi_progs=(
    act
    cookiecutter
    direnv
    gh
    pre-commit
)

for prog in ${pixi_progs[@]}
do
    pixi global install $prog
done
