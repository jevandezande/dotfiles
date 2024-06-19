################
# Cluster Sync #
################
cluster_sync () {
    cluster=${1-cronos}
    echo "Syncing $1"
    # note: rsync works on first matching pattern (thus include must be first)
    rsync $1: \
        ~/tmp/sync/$1/ \
        -azP \
        --delete \
        --include=input.dat \
        --exclude={"input.*","*.tar.gz","*.tgz","*.tbz",.cache/,.dotfiles/,OB/,old/,progs/,tmp,".*","*.zip"}
}

alias mrv='MarvinSketch $1 2> /dev/null'

################
# File Viewing #
################
alias aout='avogadro2 output.dat'
alias aview='get_geom -i output.dat && avogadro geom.xyz'
alias cout='cheMVP output.dat'
