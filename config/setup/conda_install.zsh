#!/usr/bin/env zsh
##################################
# Install Conda and environments #
##################################

conda_dir=~/progs/anaconda3
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
        echo "Failed to determine OS: $(uname)"
        exit 0
    fi
    # Miniconda: "https://repo.anaconda.com/miniconda/Miniconda3-latest-$OS-x86_64.sh"
    curl -o anaconda_install.sh "https://repo.anaconda.com/archive/Anaconda3-2021.11-$OS-x86_64.sh"
    bash anaconda_install.sh -b -p $conda_dir
    rm anaconda_install.sh
fi

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
