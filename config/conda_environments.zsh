eval "$(conda shell.bash hook)"

mamba create --name cc python=3.7 -y
conda activate cc
echo `conda env list`
echo `mamba env list`
mamba install -y -c pyscf pyscf
mamba install -y -c psi4 psi4 gcp
#mamba install -y -c conda-forge xtb  # xtb and psi4 don't play nice
#mamba install -y -c iwatobipen psikit  # does not want to install
pip install matplotlib more-itertools pandas

eval "$(conda shell.bash hook)"
mamba create --name xtb python=3.8 -y
conda activate xtb
echo `conda env list`
echo `mamba env list`
mamba install -y -c pyscf pyscf
#mamba install -y -c psi4 psi4 gcp
mamba install -y -c conda-forge xtb  # xtb and psi4 don't play nice
pip install matplotlib more-itertools pandas
