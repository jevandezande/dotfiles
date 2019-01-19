# System profile selecter

if [ $HOST = "pccec0668" ]
then
    source ~/.zsh/profiles/koios.zsh

elif [ $HOST = "cronos" ]
then
    source ~/.zsh/profiles/cronos.zsh

elif ( [ $HOST = "vlogin1.ccqc.uga.edu" ] || [ $HOST = "vlogin2.ccqc.uga.edu" ] ) && [ -f profiles/vulcan.zsh ]
then
    source ~/.zsh/profiles/cluster.zsh
    source ~/.zsh/profiles/vulcan.zsh

elif [ ${HOST} = 'master1' ] || [ ${HOST} = 'master2' ]
then
    source ~/.zsh/profiles/cluster.zsh
    source ~/.zsh/profiles/mpi.zsh
    source ~/.zsh/profiles/pbs.zsh

    # look for Hera proc
    proc=$(grep 'E5649  @ 2.53GHz' /proc/cpuinfo)
    if [ $proc ]
    then
        source ~/.zsh/profiles/hera.zsh
    else
        source ~/.zsh/profiles/hermes.zsh
    fi

elif [ ${HOST:0:6} = 'zeusln' ]
then
    source ~/.zsh/profiles/cluster.zsh
    source ~/.zsh/profiles/mpi.zsh
    source ~/.zsh/profiles/pbs.zsh
    source ~/.zsh/profiles/zeus.zsh

elif [ ${HOST} = 'xe32th1' ]
then
    source ~/.zsh/profiles/cluster.zsh
    source ~/.zsh/profiles/mpi.zsh
    source ~/.zsh/profiles/kofo.zsh
    source ~/.zsh/profiles/sge.zsh
    source ~/.zsh/profiles/xe32th1.zsh

elif [ ${HOST:0:3} = 'uga' ] || [ ${HOST: -13} = 'gacrc.uga.edu' ]
then
    source ~/.zsh/profiles/cluster.zsh
    source ~/.zsh/profiles/sapelo.zsh

elif [ -n "$HOST" ]
then
    echo "Cannot find the proper host and associated system profile. Host: $HOST"

else
    echo "No host found!!!"
fi
