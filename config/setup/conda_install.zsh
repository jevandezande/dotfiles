#!/usr/bin/env zsh

echo "Conda!"
conda_dir=~/progs/test/anaconda3
conda=$conda_dir/bin/conda
mamba=$conda_dir/bin/mamba
if [ ! -d $conda_dir ]
then
    OS=""
    if [ $(uname) = "Linux" ]
    then
        OS="Linux"
    elif [ $(uname) = "Darwin" ]
    then
        OS="MacOSX"
    else
        echo "Failed to determine OS: $OS"
        exit 0
    fi
    curl -o anaconda_install.sh "https://repo.anaconda.com/archive/Anaconda3-2021.05-$OS-x86_64.sh"
    bash anaconda_install.sh -b -p $conda_dir
    rm anaconda_install.sh

    #    curl -o Miniconda3-latest.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    #    bash Miniconda3-latest.sh -b -p $conda_dir
    #    rm Miniconda3-latest.sh
fi

echo 2

$conda update -n base -c defaults conda --yes
$conda update --all --yes

$conda install mamba -c conda-forge --yes
$mamba update -n base -c defaults conda --yes
$mamba update --all --yes

for env in ../conda/*.yml
do
    echo $env
    $mamba env create -f $env
done

#jupyter-nbextension enable nglview --py --sys-prefix
#jupyter labextension install nglview-js-widgets
