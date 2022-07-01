#!/usr/bin/env zsh

if ! type gh > /dev/null
then
    echo "gh is not installed"
    return
elif ! gh auth status 2> /dev/null
then
    gh auth login
fi

github_progs=(
    pipenv-cookiecutter
    qgrep
    reaction_web
    spectra
)

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
