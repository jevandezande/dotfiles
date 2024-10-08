#!/usr/bin/env zsh

##################################
# Install Mamba and environments #
##################################

mamba_dir=~/progs/mamba
mamba=$mamba_dir/bin/mamba

if [ ! -d $mamba_dir ]
then
    mkdir -p $mamba_dir
    pushd $mamba_dir
        pwd
        curl -L -o mamba_install.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
        bash mamba_install.sh -b -f -p $mamba_dir
        rm mamba_install.sh
    popd
fi


$mamba update --all --yes

for env in ../mamba/*.yml
do
    echo "Installing ${${env:t}:r}"
    $mamba env create -f $env
done
