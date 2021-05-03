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

    tsp -N $nprocs -L $label zsh -c "$orca $@" | add_job $label
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
    label="PSI4_${$(pwd):t}"
    nprocs=${1-1}

    tsp -N $nprocs -L $label zsh -c "conda run -n cc psi4 -n $nprocs" | add_job $label
}

#######
# XTB #
#######
xtb_opt()
{
    label="xTB_${$(pwd):t}"
    coords=${1-'geom.xyz'}
    charge=${2-0}

    tsp -L $label zsh -c "conda run -n cc xtb ${1-'geom.xyz'} --opt -c ${2-0} > output.dat" | add_job $label
}

xtb_md()
{
    label="xTBMD_${$(pwd):t}"
    coords=${1-'geom.xyz'}
    charge=${2-0}

    tsp -L $label zsh -c "conda run -n cc xtb $coords --omd -c $charge > output.dat" | add_job $label
}
stda()
{
    label="sTDA_${$(pwd):t}"

    threads=${1-1}
    coords=${2-'geom.xyz'}
    charge=${3-0}

    tsp -L $label -N $threads zsh -c "xtb4stda $coords -T $threads -chrg $charge > xtb.out" | add_job $label
    tsp -d -L $label -N $threads zsh -c "~/progs/bin/stda_v1_6_2 coords -T $threads -xtb -e 10"| add_job $label
}
crest_run()
{
    label="CREST_${$(pwd):t}"

    threads=${1-1}
    coords=${2-'geom.xyz'}
    charge=${3-0}

    tsp -L $label -N $threads zsh -c "crest $coords -T $threads -c $charge -niceprint -cluster > output.dat" | add_job $label
}
crest_gff()
{
    label="CREST_GFF_${$(pwd):t}"

    threads=${1-1}
    coords=${2-'geom.xyz'}
    charge=${3-0}

    tsp -L $label zsh -c "crest $coords -c $charge -T $threads -niceprint -cluster -gff > output.dat" | add_job $label
}
crest_gfn2gff()
{
    label="CREST_GFN2//GFNFF_${$(pwd):t}"

    threads=${1-1}
    coords=${2-'geom.xyz'}
    charge=${3-0}

    tsp -L $label zsh -c "crest $coords -c $charge -T $threads -niceprint -cluster -gfn2//gfnff > output.dat" | add_job $label
}
