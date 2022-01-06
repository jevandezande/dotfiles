#!/usr/bin/env zsh

echo "Conda!"
conda_dir=~/progs/anaconda3
conda=$conda_dir/bin/conda
mamba=$conda_dir/bin/mamba
if [ ! -d $conda_dir ]
then
    if [ `uname` = "Linux" ]
    then
        OS = "Linux"
    elif [ `uname` = "Darwin" ]
    then
        OS = "MacOSX"
    else
        echo "Failed to determine OS: $(OS)"
        exit 0
    fi
    curl -o conda_install.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-$(OS)-x86_64.sh"
    bash conda_install.sh -b -p $conda_dir
    rm conda_install.sh
fi

$conda update -n base -c defaults conda --yes
$conda update --all --yes

$conda install mamba -c conda-forge --yes
$mamba update -n base -c defaults conda --yes
$mamba update --all --yes

for env in conda/*.yml
do
    $mamba env create -f $env
done

#jupyter-nbextension enable nglview --py --sys-prefix
#jupyter labextension install nglview-js-widgets
