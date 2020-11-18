#!/usr/bin/env zsh

echo "Conda!"
pip install conda
conda install mamba -c conda-forge --yes
mamba update -n base -c defaults conda --yes
mamba update --all --yes


# Base
base_progs=(
    bibtextparser  # Parses bibtex files
    bump2version   # Python package version bumper
    cython         # Python -> c
    flake8         # Linting
    h5py           # Hdf5 library
    jupyterlab     # iPython notebooks
    matplotlib     # Plotting
    more-itertools # Even more ways to iterate
    natsort        # Natural sorting (e.g. A2 < A11)
    networkx       # Networks, may need -c conda-forge --yes
    numpy          # Scientific computing
    pytest         # Unittesting
    virtualenv     # Virtual environments
    virtualenvwrapper  # Shell integration with virtualenv
    scipy          # Scientific computing
    sympy          # Symbolic python
    tox            # Venv and CLI tool
)
for prog in "${base_progs[@]}"
do
    mamba install $prog
done
mamba install cclib -c cclib --yes
jupyter-nbextension enable nglview --py --sys-prefix
jupyter labextension install nglview-js-widgets


# CC
mamba create -n cc --yes
mamba install -n cc psi4 -c psi4/label/dev --yes
mamba install -n cc gcp -c psi4/label/dev --yes
mamba install -n cc xtb -c conda-forge --yes
mamba install -n cc xtb-python -c conda-forge --yes
mamba install -n cc qcportal -c conda-forge --yes
mamba install -n cc qcfractal -c conda-forge --yes
mamba install -n cc cclib -c cclib --yes
mamba install -n cc nglview -c conda-forge --yes
mamba install -n cc networkx -c conda-forge --yes
mamba install -n cc jupyterlab --yes
mamba install -n cc natsort --yes


# Package specific environments
#Psi4
mamba create -n psi4 --yes
mamba install -n psi4 psi4 -c psi4/label/dev
mamba install -n psi4 gcp -c psi4/label/dev

# XTB
mamba create -n xtb --yes
mamba install -n xtb xtb -c conda-forge
mamba install -n xtb xtb-python -c conda-forge

# PySCF
mamba create -n pyscf --yes
mamba install -n pyscf pyscf -c pyscf


## Conda
#conda_dir=~/progs/miniconda
#conda=$conda_dir/bin/conda
#if [ ! -d $conda_dir ]
#then
#    curl -o Miniconda-latest.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
#    bash Miniconda-latest.sh -b -p $conda_dir
#    rm Miniconda-latest.sh
#fi

#$conda update -n base -c defaults conda --yes
#$conda update --all --yes
#$conda install nglview -c conda-forge
#
#if [ ! -d $conda_dir/envs/p4env ]
#then
#    $conda create -n cc python=3.8
#fi
#$conda activate cc
#$conda install -c psi4/label/dev psi4 --yes
#$conda install -c conda-forge xtb
#$conda install -c cclib cclib
#$conda install -c
#$conda install -c
#$conda install -c
#$conda install nglview -c conda-forge
#
#$conda activate base
