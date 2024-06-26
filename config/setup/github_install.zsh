#!/usr/bin/env zsh

if ! type gh > /dev/null
then
    echo "gh is not installed"
    echo "Trying to install via brew"
    brew install gh
fi

if ! gh auth status 2> /dev/null
then
    gh auth login
fi

github_progs=(
    basis
    chem_runner
    qgrep
    poetry-cookiecutter
    reaction_web
    spectra
    snippets
)

if [ ! -d progs ]
then
    mkdir ~/progs
fi

pushd ~/progs/
    for prog in $github_progs
    do
        if [ ! -d $prog ]
        then
            gh repo clone $prog
        else
            echo "$prog is already installed"
        fi
    done
popd
