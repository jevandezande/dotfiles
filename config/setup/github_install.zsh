conda install gh

github_progs=(
    pipenv-cookiecutter
    qgrep
    reaction_web
    spectra
)

pushd ~/progs/
    for prog in $git_progs
    do
        if [ ! -d $prog ]
        then
            gh repo clone $prog
        else
            echo "$prog is already installed"
        fi
    done
popd
