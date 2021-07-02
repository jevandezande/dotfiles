################
# Cluster Sync #
################
cluster_sync () {
    cluster=${1-sch}
    if [ -z $cluster ]
    then
        echo "Please choose from a cluster in"
        ls ~/tmp/sync
    else
        echo "Syncing $cluster"
        # note: rsync works on first matching pattern (thus include must be first)
        rsync $cluster: \
            ~/tmp/sync/$cluster/ \
            -azP \
            --delete \
            #--include=input.dat \
            --exclude={
                "input.*","*.tar.gz","*.tgz","*.tbz",
                "job.log","job.recover","job.01.mae",
                tmp/,progs/,old/,wekafiles,
                ".*",}
    fi
}

alias mrv='MarvinSketch $1 2> /dev/null'

################
# File Viewing #
################
alias aout='avogadro2 output.dat'
alias aview='get_geom -i output.dat && avogadro geom.xyz'
alias cout='cheMVP output.dat'
