# System profile selecter

if [ $HOST = "pccec0668" ]
then
    source ~/.zsh/profiles/koios.zsh
elif ( [ $HOST = "vlogin1.ccqc.uga.edu" ] || [ $HOST = "vlogin2.ccqc.uga.edu" ] ) && [ -f profiles/vulcan.zsh ]
then
    source ~/.zsh/profiles/vulcan.zsh
    source ~/.zsh/profiles/cluster.zsh
elif [ ${HOST} = 'master1' ] || [ ${HOST} = 'master2' ]
then
    # look for Hera proc
    proc=$(grep 'E5649  @ 2.53GHz' /proc/cpuinfo)
    if [ $proc ]
    then
        source ~/.zsh/profiles/hera.zsh
    else
        source ~/.zsh/profiles/hermes.zsh
    fi
    source ~/.zsh/profiles/mpi.zsh
    source ~/.zsh/profiles/cluster.zsh
elif [ ${HOST:0:6} = 'zeusln' ]
then
    source ~/.zsh/profiles/zeus.zsh
    source ~/.zsh/profiles/mpi.zsh
    source ~/.zsh/profiles/cluster.zsh
elif [ ${HOST:0:3} = 'uga' ] || [ ${HOST: -13} = 'gacrc.uga.edu' ]
then
    source ~/.zsh/profiles/sapelo.zsh
    source ~/.zsh/profiles/cluster.zsh
elif [ -n "$HOST" ]
then
    echo "Cannot find the proper host and associated system profile. Host: $HOST"
else
    echo "No host found!!!"
fi
