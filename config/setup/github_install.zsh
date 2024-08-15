#!/usr/bin/env zsh

if ! type gh > /dev/null
then
    echo "gh is not installed"
    echo "Trying to install via pixi"
    if ! type pixi > /dev/null
    then
        echo "Installing Pixi"
        curl -fsSL https://pixi.sh/install.sh | bash
    fi
    pixi global install gh
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


github_extensions=(
    github/gh-copilot     # chat interface for questions about the command line
    dlvhdr/gh-dash        # displays a dashboard with pull requests and issues
    gennaro-tedesco/gh-f  # fuzzy finder for gh-cli
    yusukebe/gh-markdown-preview  # renders markdown documents in your browser
    meiji163/gh-notify    # shows your GitHub notifications
    seachicken/gh-poi     # safely cleans up old local branches
)
for ext in $github_extensions
do
    gh extension install $ext
done
