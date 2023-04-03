###########
# Helpers #
###########
add_job()
{
    read
    local number=${REPLY}
    local label=${1:-${$(pwd):t}}
    echo "$number - $label - $(pwd)" >> ~/.jobs
}

task_spool()
{
    local cmd=${1}
    local label=${2:-"tsp"}
    local threads=${3:-1}

    echo "tsp -L $label -N $threads zsh -c \"$cmd\" | add_job $label"

    tsp -L $label -N $threads zsh -c "$cmd" | add_job $label
}


############
# Programs #
############
crest="conda run -n crest crest"
orca="~jevandezande/progs/orca/run_orca.zsh"
psi4="conda run -n cc psi4"
xtb="conda run -n crest xtb"


############
# Settings #
############
# xtb
export OMP_STACKSIZE=18G
ulimit -s unlimited


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
    local threads=${1:-1}

    local cmd="conda run -n psi4 psi4 -n $threads"

    task_spool $cmd $label $threads
}


#######
# XTB #
#######
xtb_opt()
{
    local label="xTB_${$(pwd):t}"

    local coords=${1:-'geom.xyz'}
    local charge=${2:-0}
    local threads=${3:-8}

    local input=""
    if [ -f input.dat ]
    then
        input="--input input.dat"
    fi

    local cmd="$xtb $coords --opt -c $charge -P $threads $input > output.dat"

    task_spool $cmd $label $threads
}

xtb_copt()
{
    local label="XTB_copt_${$(pwd):t}"

    local atoms=${1}
    if [[ -z $atoms ]]
    then
        echo "Missing atoms to constrain"
        return
    fi
    local force_constant=${2:-5}

    local coords=${3:-'geom.xyz'}
    local charge=${4:-0}
    local threads=${5:-8}

    echo "\$constrain
    atoms: $atoms
    force constant=$force_constant
\$end" > input.dat
    input="--input input.dat"

    local cmd="$xtb $coords --opt -c $charge -P $threads $input > output.dat"

    task_spool $cmd $label $threads
}

xtb_scan()
{
    local label="XTB_scan_${$(pwd):t}"

    local scan=${1}
    if [[ -z $scan ]]
    then
        echo "Missing scan parameters"
        return
    fi
    local force_constant=${2:-5}

    local coords=${3:-'geom.xyz'}
    local charge=${4:-0}
    local threads=${5:-8}

    echo "\$constrain
    force constant=$force_constant
\$scan
    $scan
\$end" > input.dat
    input="--input input.dat"

    local cmd="$xtb $coords --opt -c $charge -P $threads $input > output.dat"

    task_spool $cmd $label $threads
}

xtb_spin()
{
    local name="${$(pwd):t}"
    local coords="geom.xyz"

    local mult1=${1:-1}
    local mult2=${2:-7}
    local threads=${3:-8}

    for mult in {$mult1..$mult2..2}
    do
        let "spin = $mult - 1"
        mkdir $mult
        cp $coords $mult
        echo "\$spin $spin" > $mult/input.dat
        if [ -f input.dat ]
        then
            cat input.dat >> $mult/input.dat
        fi
        pushd $mult
            local cmd="$xtb $coords --opt --input input.dat -P $threads $input > output.dat"
            local label="xTB_spin_$spin_$name"
            task_spool $cmd $label_$mult $threads
        popd
    done
}

xtb_hess()
{
    local label="xTB_hess_${$(pwd):t}"

    local coords=${1:-'geom.xyz'}
    local charge=${2:-0}
    local threads=${3:-8}

    local input=""
    if [ -f input.dat ]
    then
        input="--input input.dat"
    fi

    local cmd="$xtb $coords --hess -c $charge -P $threads $input > output.dat"

    task_spool $cmd $label $threads
}

xtb_md()
{
    local label="xTBMD_${$(pwd):t}"

    local coords=${1:-'geom.xyz'}
    local charge=${2:-0}
    local threads=${3:-8}

    local input=""
    if [ -f input.dat ]
    then
        input="--input input.dat"
    fi

    local cmd="$xtb $coords --omd $input -c $charge -P $threads > output.dat"

    task_spool $cmd $label $threads
}

xtb_path()
{
    local label="xTB_path_${$(pwd):t}"

    local start=${1:-"start.xyz"}
    local path_end=${2:-"end.xyz"}
    local input=${3:-"path.in"}
    local charge=${4:-0}
    local threads=${5:-8}

    local input=""
    if [ -f input.dat ]
    then
        input="--input input.dat"
    fi

    local cmd="$xtb $start --path $path_end $input -c $charge -P $threads > output.dat"

    task_spool $cmd $label $threads
}

stda()
{
    local label="sTDA_${$(pwd):t}"

    local coords=${1:-'geom.xyz'}
    local charge=${2:-0}
    local threads=${3:-8}

    tsp -L $label -N $threads zsh -c "xtb4stda $coords -T $threads -chrg $charge > xtb.out" | add_job $label
    tsp -d -L $label -N $threads zsh -c "~/progs/bin/stda_v1_6_2 coords -T $threads -xtb -e 10"| add_job $label
}

crest_run()
{
    local label="CREST_${$(pwd):t}"

    local coords=${1:-'geom.xyz'}
    local charge=${2:-0}
    local threads=${3:-8}

    local input=""
    if [ -f input.dat ]
    then
        input="--input input.dat"
    fi

    local constrain=""
    if [ -f constrain.inp ]
    then
        constrain="--cinp constrain.inp --subrmsd"
    fi

    local cmd="$crest $coords -T $threads $input $constrain -c $charge -niceprint > output.dat"

    task_spool $cmd $label $threads
}

crest_gff()
{
    local label="CREST_GFF_${$(pwd):t}"

    local coords=${1:-'geom.xyz'}
    local charge=${2:-0}
    local threads=${3:-8}

    local input=""
    if [ -f input.dat ]
    then
        input="--input input.dat"
    fi

    local constrain=""
    if [ -f constrain.inp ]
    then
        constrain="--cinp constrain.inp --subrmsd"
    fi

    local cmd="$crest $coords -T $threads $input $constrain -c $charge -niceprint --gff > output.dat"

    task_spool $cmd $label $threads
}

crest_gfn2gff()
{
    local label="CREST_GFN2//GFNFF_${$(pwd):t}"

    local coords=${1:-'geom.xyz'}
    local charge=${2:-0}
    local threads=${3:-8}

    local input=""
    if [ -f input.dat ]
    then
        input="--input input.dat"
    fi

    local constrain=""
    if [ -f constrain.inp ]
    then
        constrain="--cinp constrain.inp --subrmsd"
    fi

    local cmd="$crest $coords -T $threads $input $constrain -c $charge -niceprint -gfn2//gfnff > output.dat"

    task_spool $cmd $label $threads
}

crest_constrain()
{
    local label_xtb="xTB_${$(pwd):t}"
    local label_CREST="CREST_${$(pwd):t}"

    local coords=${1:-'geom.xyz'}
    local threads=${2:-8}

    if [ ! -f input.dat ]
    then
        echo "Missing input file"
        return 1
    fi
    if [ ! -f constrain.inp ]
    then
        cp input.dat constrain.inp
    fi

    # Optimize
    local cmd="$xtb $coords --opt -P $threads --input input.dat > output.dat && cp xtbopt.xyz geom.xyz"
    task_spool $cmd $label_xtb $threads

    # Run CREST afterwards
    echo "tsp -L $label_CREST -N $threads -d zsh -c \"$cmd\" | add_job $label_CREST"
    local cmd="$crest $coords -T $threads --cinp constrain.inp --subrmsd -niceprint >> output.dat"
    tsp -L $label_CREST -N $threads -d zsh -c "$cmd" | add_job $label_CREST
}

nanoreactor_setup()
{
    local coords=${1:-'geom.xyz'}
    local charge=${2:-0}
    local genpot=${3:-10}
    local genmtd=${4:-10}

    echo "Optimizing initial coordinates"
    eval "$xtb $coords --opt -c $charge > output.dat"

    mv xtbopt.xyz nanoreactor_start.xyz

    echo "Setting up input file"
    eval "$crest nanoreactor_start.xyz --reactor --genpot $genpot --genmtd $genmtd >> output.dat"

    echo "\$chrg $charge" > input.dat
    cat rcontrol >> input.dat
    rm rcontrol

    # then use nanoreactor_run
}

nanoreactor_run()
{
    local label="NanoReactor_${$(pwd):t}"

    local coords=${1:-'nanoreactor_start.xyz'}
    local threads=${2:-8}
    local cmd="$xtb $coords --omd --input input.dat -P $threads > output.dat"

    task_spool $cmd $label $threads

    label="${label}_opt"
    cmd="$crest coord --input input.dat --reactor --fragopt >> output.dat"

    tsp -d -L $label -N $threads zsh -c "$cmd" | add_job $label
}

alias clean_xtb="find xtb{opt.{coord,log},restart,topo.mol} wbo charges -type f 2> /dev/null | xargs rm 2> /dev/null"
alias clean_crest="clean_xtb; find bondlengths coord{,.original} cre_members cregen_{0..9}.tmp crest.energies gfnff_{adjacency,charges,topo} struc.xyz tmpcoord xtb.out -type f 2> /dev/null | xargs rm 2> /dev/null"


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

    local threads=${1:-$NUMCPUS}

    local cmd="time make -j $threads --load-average=$threads > make.out 2> make.error"

    task_spool $cmd $label $threads
}

tsp_cmake(){
    local label="CMAKE_$(pwd)"

    local threads=${1:-$NUMCPUS}

    local cmd="cmake --build . --config Release -j $threads > make.out 2> make.error"

    task_spool $cmd $label $threads
}
