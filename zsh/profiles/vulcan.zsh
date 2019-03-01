# Prompt style
prompt adam1 orange


#########
# Queue #
#########
alias qall='qstat -f -u "*"'
alias qu='qinfo2 -u'
alias qw='qinfo2 -uw'

cdj () {
    # cd to the appropriate job, whether running or finished
    # Find the job in qstat
    job=$(qstat -j $1 2> /dev/null)
    # If the job string is not empty
    if [[ -n $job ]]
    then
        # cut out the directory and cd to the job
        cd $(echo $job | grep "cwd" | cut -f2 -d ":" | tr -d ' ')
    else
        # If finished, find in queue_complete_csv
        completed_job=$(tac ~/.queue_complete_csv | grep "^$1, " -m 1)
        if [[ -n $completed_job ]]
        then
            # cut out the directory and cd to the job
            cd $(echo $completed_job | cut -f2 -d ',' | tr -d ' ')
        else
            echo "Could not find job"
        fi
    fi
}

finished () {
    tail $HOME/.queue_complete_csv -n ${1:-10} | cut -d ',' -f 1,2,3,4 | column -s, -t
}

alias jobtail='echo "Tailing Jobs\n-----------------------------------"; tail -fn0 ~/.queue_complete_csv'

# Delete all e and o files
alias rmeo='find . -regextype posix-extended -regex ".*\.(e|o)[0-9]{4,}.*" -delete'


################
# Load Modules #
################

module load python/3


##########
# INTDER #
##########
alias intder_auto_format='~jagarwal/bin/Intder/auto_format'
alias intder='~jagarwal/bin/Intder/intder2005'
alias intder_run='~jagarwal/bin/Intder/intder2005 < intder.inp > intder.out'
alias parse_hess_orca2cfour='~/bin/miscellaneous/parse_hess_orca2cfour.py'


###########
# Copying #
###########
alias scpo='scp output.dat cronos:'
alias scpg='scp geom.xyz cronos:'
alias scpz='scp ZMAT cronos:'


#########################
# Vulcan Job Submission #
#########################
vbl () { vulcan submit $@ large.q bagel@master }
vb3 () { vulcan submit $@ gen3.q bagel@master }
vb4 () { vulcan submit $@ gen4.q bagel@master }
vb5 () { vulcan submit $@ gen5.q bagel@master }
vb6 () { vulcan submit $@ gen6.q bagel@master }
vb7 () { vulcan submit $@ gen7.q bagel@master }
vcl () { vulcan submit $@ large.q cfour@2.0+mpi }
vc3 () { vulcan submit $@ gen3.q cfour@2.0+mpi }
vc4 () { vulcan submit $@ gen4.q cfour@2.0+mpi }
vc5 () { vulcan submit $@ gen5.q cfour@2.0+mpi }
vc6 () { vulcan submit $@ gen6.q cfour@2.0+mpi }
vc7 () { vulcan submit $@ gen7.q cfour@2.0+mpi }
vml () { vulcan submit $@ large.q molpro@2010.1.67~mpi }
vm3 () { vulcan submit $@ gen3.q molpro@2010.1.67~mpi }
vm4 () { vulcan submit $@ gen4.q molpro@2010.1.67~mpi }
vm5 () { vulcan submit $@ gen5.q molpro@2010.1.67~mpi }
vm6 () { vulcan submit $@ gen6.q molpro@2010.1.67~mpi }
vm7 () { vulcan submit $@ gen7.q molpro@2010.1.67~mpi }
vol () { vulcan submit $@ large.q orca@3.0.3 }
vo3 () { vulcan submit $@ gen3.q orca@3.0.3 }
vo4 () { vulcan submit $@ gen4.q orca@3.0.3 }
vo5 () { vulcan submit $@ gen5.q orca@3.0.3 }
vo6 () { vulcan submit $@ gen6.q orca@3.0.3 }
vo7 () { vulcan submit $@ gen7.q orca@3.0.3 }
vpl () { vulcan submit $@ large.q psi4@master }
vp3 () { vulcan submit $@ gen3.q psi4@master }
vp4 () { vulcan submit $@ gen4.q psi4@master }
vp5 () { vulcan submit $@ gen5.q psi4@master }
vp6 () { vulcan submit $@ gen6.q psi4@master }
vp7 () { vulcan submit $@ gen7.q psi4@master }
vql () { vulcan submit $@ large.q qchem@4.4 }
vq3 () { vulcan submit $@ gen3.q qchem@4.4 }
vq4 () { vulcan submit $@ gen4.q qchem@4.4 }
vq5 () { vulcan submit $@ gen5.q qchem@4.4 }
vq6 () { vulcan submit $@ gen6.q qchem@4.4 }
vq7 () { vulcan submit $@ gen7.q qchem@4.4 }


#######
# NBO #
#######
alias nbo='/opt/nbo/6/nbo6/bin/nbo6.i8.exe < input.47 > nbo_out.dat & disown'
export GENEXE='/opt/nbo/6/nbo6/bin/gennbo.i8/exe < input.47; pwd'
export NBOEXE=pwd


##########
# Others #
##########
alias ipython='/opt/anaconda/3/bin/ipython'
alias count='qstat |tee >(grep gen2 -c) |tee >(grep gen3 -c) |tee >(grep gen4 -c)'

export PYTHONPATH=$PYTHONPATH:'/home/vulcan/avcopan/bin/psi4/obj/bin/'
export PYTHONPATH=$PYTHONPATH:$HOME/bin/optavc
export PYTHONPATH=$PYTHONPATH:/opt/vulcan/lib/vulcan
