#!/usr/bin/env zsh

echo "Conda!"
conda_dir=~/progs/miniconda
conda=$conda_dir/bin/conda
mamba=$conda_dir/bin/mamba
if [ ! -d $conda_dir ]
then
    curl -o Miniconda-latest.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    bash Miniconda-latest.sh -b -p $conda_dir
    rm Miniconda-latest.sh
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

jupyter-nbextension enable nglview --py --sys-prefix
jupyter labextension install nglview-js-widgets
