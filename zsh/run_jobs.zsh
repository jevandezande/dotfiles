###########
# Helpers #
###########
add_job()
{
    read
    local number=${REPLY}
    local label=${1-${$(pwd):t}}
    echo "$number - $label - $(pwd)" >> ~/.jobs
}

task_spool()
{
    local cmd=${1}
    local label=${2:-"tsp"}
    local threads=${3:-1}

    echo "tsp -L $label -N $threads zsh -c $cmd | add_job $label"

    tsp -L $label -N $threads zsh -c "$cmd" | add_job $label
}


############
# Programs #
############
crest="conda run -n crest crest"
orca="~jevandezande/progs/orca/run_orca.zsh"
psi4="conda run -n cc psi4"
xtb="conda run -n cc xtb"


########
# Orca #
########
orca_run()
{
    local label="orca_${$(pwd):t}"
    local inp=${1:-input.dat}

    local nprocs=1
    if [[ -f $inp ]]
    then
        pal=`head -1 $inp | cut -d " " -f 1`
        pal2=`head -1 $inp | cut -d " " -f 2`
        if [[ $pal == "%pal" ]]
        then
            nprocs=`head -1 $inp | cut -d " " -f 3`
        elif [[ $pal2 == "pal" ]]
        then
            nprocs=`head -1 $inp | cut -d " " -f 4`
        fi
    fi

    local cmd="$orca $@"

    task_spool $cmd $label $nprocs
}
alias killorca='killall orca{,_scf,_scfgrad,_casscf,_cipsi}{,_mpi}'
alias clean_orca="find input.{cis,engrad,ges,hostnames,opt,prop,qro,uno,unso,xyz} input{,_atom{45,77}}{,_property}.txt -type f 2> /dev/null | xargs rm 2> /dev/null"

#alias orca_2mkl='$HOME/progs/orca/x86_exe/orca_2mkl'

function molden ()
{
    # Strip the file extenstion
    local file=${1:r}
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
    local label="PSI4_${$(pwd):t}"
    local threads=${1-1}

    local cmd="conda run -n psi4 psi4 -n $threads"

    task_spool $cmd $label $threads
}


#######
# XTB #
#######
xtb_opt()
{
    local label="xTB_${$(pwd):t}"

    local coords=${1-'geom.xyz'}
    local charge=${2-0}
    local threads=${3-8}

    local cmd="$xtb $coords --opt -c $charge -P $threads > output.dat"

    task_spool $cmd $label $threads
}

xtb_md()
{
    local label="xTBMD_${$(pwd):t}"

    local coords=${1-'geom.xyz'}
    local charge=${2-0}
    local threads=${3-8}

    local cmd="$xtb $coords --omd -c $charge -P $threads > output.dat"

    task_spool $cmd $label $threads
}

xtb_path()
{
    local label="xTB_path_${$(pwd):t}"

    local start=${1-"start.xyz"}
    local path_end=${2-"end.xyz"}
    local input=${3-"path.in"}
    local charge=${4-0}
    local threads=${5-8}

    local cmd="$xtb $start --path $path_end --input $input -c $charge -P $threads > output.dat"

    task_spool $cmd $label $threads

}

stda()
{
    local label="sTDA_${$(pwd):t}"

    local coords=${1-'geom.xyz'}
    local charge=${2-0}
    local threads=${3-8}

    tsp -L $label -N $threads zsh -c "xtb4stda $coords -T $threads -chrg $charge > xtb.out" | add_job $label
    tsp -d -L $label -N $threads zsh -c "~/progs/bin/stda_v1_6_2 coords -T $threads -xtb -e 10"| add_job $label
}

crest_run()
{
    local label="CREST_${$(pwd):t}"

    local coords=${1-'geom.xyz'}
    local charge=${2-0}
    local threads=${3-8}

    local cmd="$crest $coords -T $threads -c $charge -niceprint > output.dat"

    task_spool $cmd $label $threads
}

crest_gff()
{
    local label="CREST_GFF_${$(pwd):t}"

    local coords=${1-'geom.xyz'}
    local charge=${2-0}
    local threads=${3-8}

    local cmd="$crest $coords -c $charge -T $threads -niceprint -gff > output.dat"

    task_spool $cmd $label $threads
}

crest_gfn2gff()
{
    local label="CREST_GFN2//GFNFF_${$(pwd):t}"

    local coords=${1-'geom.xyz'}
    local charge=${2-0}
    local threads=${3-8}

    local cmd="$crest $coords -c $charge -T $threads -niceprint -gfn2//gfnff > output.dat"

    task_spool $cmd $label $threads
}

alias clean_xtb="find xtb{opt.log,opt.xyz,restart,topo.mol} wbo charges -type f 2> /dev/null | xargs rm 2> /dev/null"


################
# Torsiondrive #
################
torsion()
{
    #run_torsion()
    #{
    #    echo "conda run -n torsion-drive torsiondrive-launch input.dat dihedrals.txt"
    #}
    #plot_torsion()
    #{
    #    echo "conda run -n torsion-drive torsiondrive-plot1D scan.xyz &> /dev/null && convert scan.pdf td_1D.png || torsiondrive-plot2D scan.xyz && convert torsiondrive_2D.pdf td_2D.png"
    #}
    #tsp -L $label zsh -c run_torsion | add_job $label
    #tsp -L $label zsh -c plot_torsion

    local label="TD_${$(pwd):t}"
    local conv_label="${label}_plotting"

    tsp -L $label zsh -c "conda run -n torsion-drive torsiondrive-launch input.dat dihedrals.txt" | add_job $label
    tsp -L $conv_label -d zsh -c "conda run -n torsion-drive torsiondrive-plot1D scan.xyz &> /dev/null && convert scan.pdf td_1D.png || torsiondrive-plot2D scan.xyz && convert torsiondrive_2D.pdf td_2D.png"
}


#################
# Miscellaneous #
#################
tsp_make()
{
    local label="MAKE_$(pwd)"

    local threads=${1-$NUMCPUS}

    local cmd="time make -j $threads --load-average=$threads > make.out 2> make.error"

    task_spool $cmd $label $threads
}

tsp_cmake(){
    local label="CMAKE_$(pwd)"

    local threads=${1-$NUMCPUS}

    local cmd="cmake --build . --config Release -j $threads > make.out 2> make.error"

    task_spool $cmd $label $threads
}
