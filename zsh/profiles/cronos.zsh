# Prompt style
if [ $USER = jevandezande ]
then
    export PROMPT='%F{blue}@cronos%f% %~$ '
elif [ $USER = z ]
then
    export PROMPT='%F{blue}z@cronos%f% %~$ '
fi

source $HOME/.zsh/profiles/local.zsh

export LD_LIBRARY_PATH=/home/jevandezande/progs/orca/orca_4_2_1
export PATH=~/progs/orca/orca_4_2_1/:$PATH
