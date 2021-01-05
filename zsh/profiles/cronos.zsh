# Prompt style
if [ $USER = jevandezande ]
then
    export PROMPT='%F{blue}@cronos%f% %~$ '
elif [ $USER = z ]
then
    export PROMPT='%F{blue}z@cronos%f% %~$ '
fi

source $HOME/.zsh/profiles/local.zsh
