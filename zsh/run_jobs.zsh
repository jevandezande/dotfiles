add_job()
{
    read
    number=${REPLY}
    label=${1-${$(pwd):t}}
    echo "$number - $label - $(pwd)" >> ~/.jobs
}


########
# Orca #
########
orca_run()
{
    label=${$(pwd):t}
    orca=~/progs/orca/orca_4_2_1/run_orca.zsh
    inp=${1:-input.dat}

    nprocs=1
    if [[ -f $inp ]]
    then
        pal=`head -1 $inp | cut -d " " -f 1`
        if [[ $pal == "%pal" ]]
        then
            nprocs=`head -1 $inp | cut -d " " -f 3`
        fi
    fi

    tsp zsh -c "$orca $@" -N $nprocs -L $label | add_job $label
}
alias killorca='killall orca{,_scf,_scfgrad,_casscf,_cipsi}{,_mpi}'
alias clean_orca="find input.{cis,engrad,ges,hostnames,opt,prop,qro,uno,unso,xyz} input{,_atom{45,77}}{,_property}.txt -type f 2> /dev/null | xargs rm 2> /dev/null"

#alias orca_2mkl='$HOME/progs/orca/x86_exe/orca_2mkl'

function molden ()
{
    # Strip the file extenstion
    file=${1:r}
    # If no argument
    if [[ ! -n $file ]]
    then
        file='input'
    fi

    if [[ ! -f $file".gbw" ]]
    then
        echo "No gbw file found"
        return 1
    else
        orca_2mkl $file -molden
        mv $file.molden.input $file.molden
    fi
}


########
# PSI4 #
########
psi4_run()
{
    label=${$(pwd):t}

    tsp zsh -c "conda run -n cc psi4 -n ${1-'1'}" -N ${1-'1'} -L $label | add_job $label
}

#######
# XTB #
#######
xtb_opt()
{
    label=${$(pwd):t}

    tsp zsh -c "conda run -n cc xtb ${1-'geom.xyz'} --opt -c ${2-0} > output.dat" -L $label | add_job $label
}

xtb_md()
{
    label=${$(pwd):t}

    tsp zsh -c "conda run -n cc xtb ${1-'geom.xyz'} --omd -c ${2-0} > output.dat" -L $label | add_job $label
}
stda()
{
    label=${$(pwd):t}

    cords=${1-'geom.xyz'}
    charge=${2-0}

    tsp zsh -c "xtb4stda $coords -chrg $charge > xtb.out" -L $label | add_job $label
    tsp -d zsh -c "~/progs/bin/stda_v1_6_2 coords -xtb -e 10" -L $label | add_job $label
}
crest_run()
{
    label=${$(pwd):t}

    inp=${1-'geom.xyz'}
    out=${2-'output.dat'}
    charge=${3-0}

    tsp zsh -c "crest $inp -c $charge -niceprint > $out" -L $label | add_job $label
}
