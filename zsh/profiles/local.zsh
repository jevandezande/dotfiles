################
# Cluster Sync #
################
cluster_sync () {
    if [ -z $1 ]
    then
        echo "Please choose from a cluster in"
        ls ~/tmp/sync
    else
        echo "Syncing $1"
        # note: rsync works on first matching pattern (thus include must be first)
        rsync $1: \
            ~/tmp/sync/$1/ \
            -azP \
            --delete \
            --include=input.dat \
            --exclude={"input.*","*.tar.gz","*.tgz","*.tbz",tmp/,progs/,old/,".*"}
    fi
}

alias mrv='MarvinSketch $1 2> /dev/null'

################
# File Copying #
################
alias gcz='scp geom.xyz zeus:'

################
# File Viewing #
################
alias aout='avogadro2 output.dat'
alias aview='get_geom -i output.dat && avogadro geom.xyz'
alias cout='cheMVP output.dat'

###################
# Program Running #
###################
alias cfour_run='xcfour ZMAT > output.dat 2> /dev/null & disown'


#####################
# VirtualEnvWrapper #
#####################
#source /usr/local/bin/virtualenvwrapper.sh
