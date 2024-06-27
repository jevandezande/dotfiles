# System profile selecter
HOST=${HOST:-`hostname`}

if [ $HOST = "pccec0668" ]
then
    source ~/.zsh/profiles/koios.zsh
    source ~/.zsh/profiles/wsl.zsh

elif [ ${HOST} = 'Hyperion' ]
then
    source ~/.zsh/profiles/hyperion.zsh
    source ~/.zsh/profiles/wsl.zsh

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

elif [ $HOST = 'Bob' ]
then
    source ~/.zsh/profiles/bob.zsh

elif [ ${HOST:0:3} = '1sr' ]
then
    source ~/.zsh/profiles/cluster.zsh
    source ~/.zsh/profiles/1sr_mpi.zsh

elif [ $HOST = 'ZL-12213' ]
then
    source ~/.zsh/profiles/zym.zsh
    source ~/.zsh/profiles/rhea.zsh
    source ~/.zsh/profiles/mac.zsh
    source ~/.zsh/profiles/local.zsh

elif [ $HOST = 'ZL-12640' ]
then
    source ~/.zsh/profiles/zym.zsh
    source ~/.zsh/profiles/tethys.zsh
    source ~/.zsh/profiles/local.zsh

elif [ $HOST = 'nyc-laptop-w105' ]
then
    source ~/.zsh/profiles/schrodinger.zsh
    source ~/.zsh/profiles/themis.zsh
    source ~/.zsh/profiles/wsl.zsh
    source ~/.zsh/profiles/local.zsh

elif [ $HOST = 'desk-lu251.schrodinger.com' ]
then
    source ~/.zsh/profiles/schrodinger.zsh
    source ~/.zsh/profiles/themis.zsh

elif [ $HOST = 'crius' ]
then
    source ~/.zsh/profiles/crius.zsh

elif [ -n "$HOST" ]
then
    echo "Cannot find the proper host and associated system profile. Host: $HOST"

else
    echo "No host found!!!"
fi
