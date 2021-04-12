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
    label="orca_${$(pwd):t}"
    orca=~/progs/orca/orca_4_2_1/run_orca.zsh
    inp=${1:-input.dat}

    nprocs=1
    if [[ -f $inp ]]
    then
        pal=`head -1 $inp | cut -d " " -f 1`
        pal2=`head -1 $inp | cut -d " " -f 2`
        if [[ $pal == "%pal" ]]
        then
            nprocs=`head -1 $inp | cut -d " " -f 3`
        elif [[ $pal == "pal" ]]
        then
            nprocs=`head -1 $inp | cut -d " " -f 4`
        fi
    fi

    tsp -N $procs -L $label zsh -c "$orca $@" | add_job $label
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
    label="psi4_${$(pwd):t}"
    nprocs=${1-1}

    tsp -N $nprocs -L $label zsh -c "conda run -n cc psi4 -n $nprocs" | add_job $label
}

#######
# XTB #
#######
xtb_opt()
{
    label="xtb_${$(pwd):t}"

    tsp -L $label zsh -c "conda run -n cc xtb ${1-'geom.xyz'} --opt -c ${2-0} > output.dat" | add_job $label
}

xtb_md()
{
    label="xtbmd_${$(pwd):t}"

    tsp -L $label zsh -c "conda run -n cc xtb ${1-'geom.xyz'} --omd -c ${2-0} > output.dat" | add_job $label
}
stda()
{
    label="stda_${$(pwd):t}"

    cords=${1-'geom.xyz'}
    charge=${2-0}


    tsp -L $label zsh -c "xtb4stda $coords -chrg $charge > xtb.out" | add_job $label
    tsp -d -L $label zsh -c "~/progs/bin/stda_v1_6_2 coords -xtb -e 10"| add_job $label
}
crest_run()
{
    label="conformers_${$(pwd):t}"

    inp=${1-'geom.xyz'}
    out=${2-'output.dat'}
    charge=${3-0}

    tsp -L $label zsh -c "crest $inp -c $charge -niceprint > $out" | add_job $label
}
crest_cluster()
{
    label="cluster_${$(pwd):t}"

    nclusters=${1-5}
    inp=${2-'crest_rotamers.xyz'}
    out=${3-'output.dat'}
    charge=${4-0}

    tsp -L $label zsh -c "crest -cregen $inp -cluster $nclusters -c $charge -niceprint > $out" | add_job $label
}
